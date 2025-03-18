<?php
// fetch_categories.php
require_once 'Database.php';
session_start();  // Para acceder a $_SESSION['rut']
header('Content-Type: application/json; charset=utf-8');

$conn = (new Database())->getConnection();

// Detectar action
$action = isset($_GET['action']) ? $_GET['action'] : 'list';

try {
    switch ($action) {
        case 'list':
            // Seleccionar id, name e image_url de todas las categorías
            $sql = "SELECT id, name, image_url FROM categories ORDER BY name";
            $result = $conn->query($sql);
            $categories = [];
            // Tomamos el rut del usuario de la sesión (si existe)
            $user_rut = $_SESSION['rut'] ?? '';
            
            while ($row = $result->fetch_assoc()) {
                $catId = $row['id'];
                // 1. Contar total de preguntas en la categoría
                $stmtQ = $conn->prepare("SELECT COUNT(*) as totalQ FROM questions WHERE category_id = ?");
                $stmtQ->bind_param("i", $catId);
                $stmtQ->execute();
                $resQ = $stmtQ->get_result();
                $rowQ = $resQ->fetch_assoc();
                $totalQuestions = (int)$rowQ['totalQ'];
                $stmtQ->close();
                
                // 2. Contar respuestas registradas para este usuario en la categoría
                $answeredCount = 0;
                if (!empty($user_rut)) {
                    $stmtA = $conn->prepare("SELECT COUNT(DISTINCT question_id) as answeredQ FROM answers WHERE user_rut = ? AND question_id IN (SELECT id FROM questions WHERE category_id = ?)");
                    $stmtA->bind_param("si", $user_rut, $catId);
                    $stmtA->execute();
                    $resA = $stmtA->get_result();
                    $rowA = $resA->fetch_assoc();
                    $answeredCount = (int)$rowA['answeredQ'];
                    $stmtA->close();
                }
                
                // 3. Si total de preguntas > 0 y todas fueron respondidas, la categoría está completada
                $completed = false;
                if ($totalQuestions > 0 && $answeredCount === $totalQuestions) {
                    $completed = true;
                }
                // Agregar la propiedad "completed" al array de la categoría
                $row['completed'] = $completed;
                $categories[] = $row;
            }
            
            echo json_encode([
                'status' => 'success',
                'categories' => $categories
            ]);
            break;

        case 'add':
            // Agregar nueva categoría
            $name = trim($_POST['name']);
            if(empty($name)){
                echo json_encode(['status'=>'error','message'=>'Nombre vacío']);
                break;
            }
            $stmt = $conn->prepare("INSERT INTO categories (name) VALUES (?)");
            $stmt->bind_param("s", $name);
            if($stmt->execute()){
                echo json_encode(['status'=>'success']);
            } else {
                echo json_encode(['status'=>'error','message'=>'Error al insertar']);
            }
            break;

        case 'edit':
            // Editar categoría
            $id = (int)$_POST['id'];
            $name = trim($_POST['name']);
            if($id < 1 || empty($name)){
                echo json_encode(['status'=>'error','message'=>'Datos inválidos']);
                break;
            }
            $stmt = $conn->prepare("UPDATE categories SET name=? WHERE id=?");
            $stmt->bind_param("si", $name, $id);
            if($stmt->execute()){
                echo json_encode(['status'=>'success']);
            } else {
                echo json_encode(['status'=>'error','message'=>'Error al actualizar']);
            }
            break;

        case 'delete':
            // Eliminar categoría
            $id = (int)$_POST['id'];
            if($id < 1){
                echo json_encode(['status'=>'error','message'=>'ID inválido']);
                break;
            }
            $stmt = $conn->prepare("DELETE FROM categories WHERE id=?");
            $stmt->bind_param("i", $id);
            if($stmt->execute()){
                echo json_encode(['status'=>'success']);
            } else {
                echo json_encode(['status'=>'error','message'=>'Error al eliminar']);
            }
            break;

        default:
            echo json_encode(['status'=>'error','message'=>'Acción desconocida']);
            break;
    }
} catch(Exception $e){
    echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
?>
