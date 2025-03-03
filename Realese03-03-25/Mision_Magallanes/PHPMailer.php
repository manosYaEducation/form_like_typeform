<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;
use Dotenv\Dotenv;

require 'vendor/autoload.php';

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // 1. Tomar datos de la sesión
    $userRut             = $_SESSION['rut']                 ?? '';
    $userEmail           = $_SESSION['correo']              ?? '';
    $nombreRepresentante = $_SESSION['nombre_representante'] ?? 'Usuario';
    $nombreEmpresa       = $_SESSION['nombre_empresa']       ?? 'Su Empresa';

    if (empty($userEmail) || empty($userRut)) {
        echo json_encode([
            "success" => false,
            "message" => "No se encontró correo o RUT del usuario en sesión."
        ]);
        exit;
    }

    // 2. Conectarnos a la base de datos
    require_once 'Database.php';
    $db   = new Database();
    $conn = $db->getConnection();

    // 2.1. Verificar si se han respondido todas las preguntas
    //     Comparar la cantidad total de preguntas con las respondidas por este usuario
    $sqlTotalQ = "SELECT COUNT(*) as totalQ FROM questions";
    $resTotalQ = $conn->query($sqlTotalQ);
    $rowTotalQ = $resTotalQ->fetch_assoc();
    $totalQuestions = (int)$rowTotalQ['totalQ'];

    $sqlAnswered = "
        SELECT COUNT(DISTINCT question_id) as answered
        FROM answers
        WHERE user_rut = ?
    ";
    $stmtAnswered = $conn->prepare($sqlAnswered);
    $stmtAnswered->bind_param("s", $userRut);
    $stmtAnswered->execute();
    $resAnswered = $stmtAnswered->get_result();
    $rowAnswered = $resAnswered->fetch_assoc();
    $answered = $rowAnswered['answered'] ?? 0;
    $stmtAnswered->close();

    // Si no están respondidas todas, se retorna el error
    if ($answered < $totalQuestions) {
        echo json_encode([
            "success" => false,
            "message" => "Debes responder todas las preguntas antes de recibir el correo."
        ]);
        exit;
    }

    // 3. Calcular el puntaje total
    //    Sumar según la opción elegida: A=4, B=3, C=2, D=1
    $sqlScore = "
        SELECT 
          SUM(
            CASE selected_option
              WHEN 'A' THEN 4
              WHEN 'B' THEN 3
              WHEN 'C' THEN 2
              WHEN 'D' THEN 1
              ELSE 0
            END
          ) AS total_score
        FROM answers
        WHERE user_rut = ?
    ";
    $stmtScore = $conn->prepare($sqlScore);
    $stmtScore->bind_param("s", $userRut);
    $stmtScore->execute();
    $resScore = $stmtScore->get_result();
    $rowScore = $resScore->fetch_assoc();
    $finalScore = $rowScore['total_score'] ?? 0;
    $stmtScore->close();

    // 4. Recuperar todas las preguntas y respuestas del usuario
    $stmt = $conn->prepare("
        SELECT 
            q.question_text,
            q.option_a,
            q.option_b,
            q.option_c,
            q.option_d,
            a.selected_option
        FROM answers a
        JOIN questions q ON a.question_id = q.id
        WHERE a.user_rut = ?
        ORDER BY q.id
    ");
    $stmt->bind_param("s", $userRut);
    $stmt->execute();
    $result = $stmt->get_result();

    // 5. Construir una tabla HTML con las preguntas y la respuesta seleccionada
    $answersHtml = "
        <table border='1' cellpadding='5' style='border-collapse: collapse; width: 100%;'>
          <thead>
            <tr style='background: #f4f4f4;'>
              <th style='text-align:left;'>Pregunta</th>
              <th style='text-align:left;'>Respuesta Seleccionada</th>
            </tr>
          </thead>
          <tbody>
    ";

    while ($row = $result->fetch_assoc()) {
        $questionText   = $row['question_text'];
        $selectedLetter = $row['selected_option']; // 'A', 'B', 'C', 'D'

        // Convertir la letra seleccionada a su texto correspondiente
        switch ($selectedLetter) {
            case 'A': $selectedText = $row['option_a']; break;
            case 'B': $selectedText = $row['option_b']; break;
            case 'C': $selectedText = $row['option_c']; break;
            case 'D': $selectedText = $row['option_d']; break;
            default:  $selectedText = "Sin respuesta";
        }

        $answersHtml .= "
            <tr>
              <td>{$questionText}</td>
              <td><strong>{$selectedLetter}</strong>: {$selectedText}</td>
            </tr>
        ";
    }
    $answersHtml .= "</tbody></table>";
    $stmt->close();

    // 6. Configurar y enviar el correo con PHPMailer
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = $_ENV['SMTP_HOST'];
        $mail->SMTPAuth   = true;
        $mail->Username   = $_ENV['SMTP_USERNAME'];
        $mail->Password   = $_ENV['SMTP_PASSWORD'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; // Ajusta si usas TLS
        $mail->Port       = $_ENV['SMTP_PORT'];

        $mail->setFrom($_ENV['SMTP_FROM_EMAIL'], $_ENV['SMTP_FROM_NAME']);
        $mail->addAddress($userEmail);

        $mail->CharSet = 'UTF-8';
        $mail->isHTML(true);
        $mail->Subject = 'Resumen de tu Encuesta de Modelo de negocio';

        // 7. Armamos el cuerpo del correo con el puntaje final y la tabla de respuestas
        $mail->Body = "
    <!DOCTYPE html>
    <html lang='es'>
    <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>Resumen de Encuesta</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #222;
                color: #ddd;
                margin: 0;
                padding: 20px;
            }
            .email-container {
                max-width: 800px;
                margin: 0 auto;
                background: rgba(34, 34, 34, 0.9);
                padding: 20px;
                border: 2px solid rgba(141, 255, 118, 0.4);
                border-radius: 8px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
            }
            h2 {
                color: rgb(141, 255, 118);
                font-size: 24px;
                text-align: center;
                margin-bottom: 20px;
            }
            h3 {
                color: rgb(255, 255, 255);
            }
            h2::after {
                content: '';
                display: block;
                width: 100px;
                height: 3px;
                background: rgb(141, 255, 118);
                margin: 10px auto 0;
                border-radius: 2px;
            }
            p {
                font-size: 16px;
                line-height: 1.6;
                margin-bottom: 20px;
                color: rgb(255, 255, 255);
            }
            strong {
                color: rgb(141, 255, 118);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid rgb(141, 255, 118);
            }
            th {
                background: rgb(0, 0, 0);
                color: rgb(141, 255, 118);
                font-weight: bold;
            }
            td {
                background: rgba(0, 0, 0, 0.8);
                color: rgb(255, 255, 255);
            }
            hr {
                border: 0;
                height: 1px;
                background: rgba(141, 255, 118, 0.4);
                margin: 20px 0;
            }
            .footer {
                text-align: center;
                font-size: 14px;
                color: #aaa;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class='email-container'>
            <h2>Resumen de la Encuesta</h2>
            <p>Estimado/a <strong>{$nombreRepresentante}</strong>,</p>
            <p>Como representante de <strong>{$nombreEmpresa}</strong>, le informamos que ha completado la encuesta.</p>
            <p>Su puntaje final es: <strong>{$finalScore}</strong>.</p>
            <hr>
            <h3>Detalle de sus respuestas:</h3>
            {$answersHtml}
            <hr>
            <p>Gracias por participar.</p>
            <div class='footer'>
                <p>Este es un correo automático, por favor no responda a este mensaje.</p>
            </div>
        </div>
    </body>
    </html>
";

        $mail->send();
        echo json_encode([
            "success" => true, 
            "message" => "Correo enviado a $userEmail con el detalle de sus respuestas."
        ]);
        exit;
    } catch (Exception $e) {
        echo json_encode([
            "success" => false, 
            "message" => "Error al enviar el correo: " . $mail->ErrorInfo
        ]);
        exit;
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Método no permitido"
    ]);
}
