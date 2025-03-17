<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;
use Dotenv\Dotenv;

require 'vendor/autoload.php';

$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

session_start();

// Permitir POST o GET
if ($_SERVER["REQUEST_METHOD"] == "POST" || $_SERVER["REQUEST_METHOD"] == "GET") {

    // 1. Tomar datos de la sesión
    $userRut             = $_SESSION['rut']                 ?? '';
    $userEmail           = $_SESSION['correo']              ?? '';
    $nombreRepresentante = $_SESSION['nombre_representante'] ?? 'Usuario';
    $nombreEmpresa       = $_SESSION['nombre_empresa']       ?? 'Su Empresa';

    if (empty($userEmail) || empty($userRut)) {
        // Si falta info, redirigimos con un mensaje de error en la URL
        header("Location: respuestafinal.html?puntaje=0&clasificacion=ErrorSesion");
        exit;
    }

    // 2. Conectarnos a la base de datos
    require_once 'Database.php';
    $db   = new Database();
    $conn = $db->getConnection();

    // 2.1. Verificar si se han respondido todas las preguntas
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

    // Si no están respondidas todas, redirigimos con un mensaje de error
    if ($answered < $totalQuestions) {
        header("Location: respuestafinal.html?puntaje=0&clasificacion=ErrorNoCompletado");
        exit;
    }

    // 3. Calcular el puntaje total
    $sqlScore = "
        SELECT 
          SUM(
            CASE selected_option
              WHEN 'A' THEN 1.5
              WHEN 'B' THEN 0.99 
              WHEN 'C' THEN 0.495
              WHEN 'D' THEN 0
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

    // 4. Determinar la clasificación (texto corto)
    if ($finalScore == 75) {
        $classification = "NIVEL A: MODO CIRCULAR ♻️";
    } elseif ($finalScore > 50) {
        $classification = "NIVEL B: EN RUTA SOSTENIBLE 🌱";
    } elseif ($finalScore > 25) {
        $classification = "NIVEL C: EN PROCESO DE TRANSFORMACIÓN 🔄";
    } else {
        $classification = "NIVEL D: ALERTA AMBIENTAL 🛑";
    }


    if ($finalScore == 75) {
        $message = "Modo Circular Activado 🌍 Eres un referente en sostenibilidad y economía circular. Tu compromiso inspira el cambio. ¡Sigue liderando el camino hacia un Magallanes más sostenible!";
    } elseif ($finalScore > 50) {
        $message = "¡Casi llegas a la cima! ✨ Estás en el camino correcto hacia la sustentabilidad. Con pequeños ajustes, puedes alcanzar el máximo impacto positivo. ¡No pares ahora!";
    } elseif ($finalScore > 25) {
        $message = "ALERTA AMBIENTAL 🛑 Buen comienzo, pero queda camino 🌟 Estás dando los primeros pasos hacia la economía circular. Es momento de ajustar procesos y tomar decisiones más verdes. ¡Cada esfuerzo cuenta!";
    } else {
        $message = "🌍 Es momento de repensar tus prácticas. La sostenibilidad no es una opción, es una necesidad. ¿Aceptas el desafío de transformar tu empresa y ser parte del cambio?";
    }

    // 5. Insertar el resultado en la tabla 'results'
    $sqlInsert = "INSERT INTO results (correo, user_rut, resultado, clasificacion) VALUES (?, ?, ?, ?)";
    $stmtInsert = $conn->prepare($sqlInsert);
    $stmtInsert->bind_param("ssds", $userEmail, $userRut, $finalScore, $classification);
    if (!$stmtInsert->execute()) {
        // Si falla la inserción, redirigimos con un error
        $errorMsg = urlencode("InsertError: " . $stmtInsert->error);
        header("Location: respuestafinal.html?puntaje=0&clasificacion=$errorMsg");
        exit;
    }
    $stmtInsert->close();

    // 6. Recuperar todas las preguntas y respuestas del usuario
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

    // 7. Construir una tabla HTML con las preguntas y la respuesta seleccionada
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
        $selectedLetter = $row['selected_option'];

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

    // 8. Enviar el correo
    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = $_ENV['SMTP_HOST'];
        $mail->SMTPAuth   = true;
        $mail->Username   = $_ENV['SMTP_USERNAME'];
        $mail->Password   = $_ENV['SMTP_PASSWORD'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = $_ENV['SMTP_PORT'];

        $mail->setFrom($_ENV['SMTP_FROM_EMAIL'], $_ENV['SMTP_FROM_NAME']);
        $mail->addAddress($userEmail);

        $mail->CharSet = 'UTF-8';
        $mail->isHTML(true);
        $mail->Subject = 'Resumen de tu Encuesta de Modelo de Negocio';

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
        <p>Tu puntaje obtenido es: <strong>{$finalScore}</strong></p>
        <p>Tu clasificación es: <strong>{$classification}</strong></p>
        <hr>
        <p>{$message}</p>
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
        // Listo, el correo fue enviado: redirigimos a respuestafinal.html
        // Pasamos puntaje y clasificación en la URL
        $finalUrl = "respuestafinal.html?puntaje={$finalScore}&clasificacion=" . urlencode($classification) . "&mensaje=" . urlencode($message);
header("Location: $finalUrl");
exit;

        exit;

    } catch (Exception $e) {
        // Si falla el correo, redirigimos con un error
        $errorMail = urlencode($mail->ErrorInfo);
        header("Location: respuestafinal.html?puntaje=0&clasificacion=$errorMail");
        exit;
    }

} else {
    // Si no es POST ni GET, se muestra el mensaje de error
    header("Location: respuestafinal.html?puntaje=0&clasificacion=MetodoNoPermitido");
    exit;
}
?>
