<?php
session_start();
require_once 'Database.php';

try {
    $db = new Database();
    $conn = $db->getConnection();

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['action']) && $_GET['action'] === 'login') {
        // Tomar campos
        $nombreEmpresa       = $_POST['nombreEmpresa']       ?? '';
        $rutEmpresa          = $_POST['rutEmpresa']          ?? '';
        $nombreRepresentante = $_POST['nombreRepresentante'] ?? '';
        $cargo               = $_POST['cargo']               ?? '';
        $correo              = $_POST['correo']              ?? '';

        // Validar
        if (empty($nombreEmpresa) || empty($rutEmpresa) || empty($nombreRepresentante) 
            || empty($cargo) || empty($correo)) {
            // Retornar JSON de error
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode([
                "status" => "error",
                "message" => "Todos los campos son obligatorios."
            ]);
            exit;
        }

        // Insertar/actualizar en la tabla users
        $stmt = $conn->prepare("SELECT id FROM users WHERE rut=?");
        $stmt->bind_param("s", $rutEmpresa);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Update
            $stmtUpdate = $conn->prepare("
                UPDATE users 
                SET nombre_empresa=?, nombre_representante=?, cargo=?, correo=?
                WHERE rut=?
            ");
            $stmtUpdate->bind_param("sssss", 
                $nombreEmpresa, 
                $nombreRepresentante, 
                $cargo, 
                $correo, 
                $rutEmpresa
            );
            $stmtUpdate->execute();
            $stmtUpdate->close();
        } else {
            // Insert
            $stmtInsert = $conn->prepare("
                INSERT INTO users (nombre_empresa, rut, nombre_representante, cargo, correo)
                VALUES (?,?,?,?,?)
            ");
            $stmtInsert->bind_param("sssss", 
                $nombreEmpresa, 
                $rutEmpresa, 
                $nombreRepresentante, 
                $cargo, 
                $correo
            );
            $stmtInsert->execute();
            $stmtInsert->close();
        }

        $stmt->close();

        // Guardar en sesión
        $_SESSION['rut'] = $rutEmpresa;
        $_SESSION['nombre_empresa'] = $nombreEmpresa;
        $_SESSION['nombre_representante'] = $nombreRepresentante;
        $_SESSION['cargo'] = $cargo;
        $_SESSION['correo'] = $correo;

        // En vez de header("Location: ..."), retornamos JSON
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode([
            "status" => "success",
            "message" => "Autenticación exitosa"
        ]);
        exit;
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Método no permitido o acción desconocida."
        ]);
        exit;
    }
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Error en la autenticación: " . $e->getMessage()
    ]);
    exit;
}
?>