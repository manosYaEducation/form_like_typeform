// user_auth.php
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
        if (empty($nombreEmpresa) || empty($rutEmpresa) || empty($nombreRepresentante) || empty($cargo) || empty($correo)) {
            // Mostrar un mensaje de error y salir
            // O podrías redirigir a login.html con un mensaje
            echo "<script>alert('Todos los campos son obligatorios.');window.history.back();</script>";
            exit;
        }

        // Insertar/actualizar
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
            $stmtUpdate->bind_param("sssss", $nombreEmpresa, $nombreRepresentante, $cargo, $correo, $rutEmpresa);
            $stmtUpdate->execute();
            $stmtUpdate->close();
        } else {
            // Insert
            $stmtInsert = $conn->prepare("
                INSERT INTO users (nombre_empresa, rut, nombre_representante, cargo, correo)
                VALUES (?,?,?,?,?)
            ");
            $stmtInsert->bind_param("sssss", $nombreEmpresa, $rutEmpresa, $nombreRepresentante, $cargo, $correo);
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

        // Redirigir a index.html
        header("Location: modelo_negocio.html");
        exit;
    } else {
        echo "Método no permitido o acción desconocida.";
        exit;
    }
} catch (Exception $e) {
    echo "Error en la autenticación: " . $e->getMessage();
    exit;
}
