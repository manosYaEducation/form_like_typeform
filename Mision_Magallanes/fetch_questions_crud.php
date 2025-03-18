<?php
// fetch_questions.php
require_once 'Database.php';

header('Content-Type: application/json; charset=utf-8');

$conn = (new Database())->getConnection();

// Detectar la acción
$action = isset($_GET['action']) ? $_GET['action'] : 'list';

// Tomar category_id de la URL si existe
$categoryId = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;

try {
    switch ($action) {
        case 'list':
            // LISTAR preguntas, filtrando por category_id si se especifica, y obtener también el nombre de la categoría
            $whereClause = "";
            if ($categoryId > 0) {
                $whereClause = "WHERE q.category_id = $categoryId";
            }
            
            $sql = "SELECT q.id, q.question_text, q.option_a, q.option_b, q.option_c, q.option_d,
                           q.category_id, c.name AS category_name
                    FROM questions q
                    LEFT JOIN categories c ON q.category_id = c.id
                    $whereClause
                    ORDER BY q.id";
            $result = $conn->query($sql);
            $questions = [];
            while ($row = $result->fetch_assoc()) {
                $questions[] = $row;
            }
            
            // Obtener total de categorías
            $sqlCatCount = "SELECT COUNT(*) as total FROM categories";
            $resCatCount = $conn->query($sqlCatCount);
            $rowCatCount = $resCatCount->fetch_assoc();
            $totalCategories = (int)$rowCatCount['total'];
            
            // Obtener el nombre de la categoría actual (si category_id > 0)
            $currentCategoryName = "";
            if ($categoryId > 0) {
                $sqlCatName = "SELECT name FROM categories WHERE id = $categoryId";
                $resCatName = $conn->query($sqlCatName);
                if ($catRow = $resCatName->fetch_assoc()) {
                    $currentCategoryName = $catRow['name'];
                }
            }
            
            echo json_encode([
                'status'          => 'success',
                'questions'       => $questions,
                'totalCategories' => $totalCategories,
                'currentCategory' => $categoryId,
                'category_name'   => $currentCategoryName
            ]);
            break;
        
        case 'add':
            // AGREGAR nueva pregunta
            $question_text = trim($_POST['question_text']);
            $option_a = trim($_POST['option_a']);
            $option_b = trim($_POST['option_b']);
            $option_c = trim($_POST['option_c']);
            $option_d = trim($_POST['option_d']);
            $category_id = (int)$_POST['category_id'];
            
            if(empty($question_text) || empty($option_a) || empty($option_b) ||
               empty($option_c) || empty($option_d)) {
                echo json_encode(['status'=>'error','message'=>'Faltan campos']);
                break;
            }
            
            $stmt = $conn->prepare("INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, category_id)
                                    VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("sssssi", $question_text, $option_a, $option_b, $option_c, $option_d, $category_id);
            if($stmt->execute()){
                echo json_encode(['status'=>'success']);
            } else {
                echo json_encode(['status'=>'error','message'=>'Error al insertar']);
            }
            break;
        
        case 'edit':
            // EDITAR pregunta
            $id = (int)$_POST['id'];
            $question_text = trim($_POST['question_text']);
            $option_a = trim($_POST['option_a']);
            $option_b = trim($_POST['option_b']);
            $option_c = trim($_POST['option_c']);
            $option_d = trim($_POST['option_d']);
            $category_id = (int)$_POST['category_id'];
            
            if($id < 1 || empty($question_text) || empty($option_a) || empty($option_b) ||
               empty($option_c) || empty($option_d)) {
                echo json_encode(['status'=>'error','message'=>'Datos inválidos']);
                break;
            }
            
            $stmt = $conn->prepare("UPDATE questions
                                    SET question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, category_id=?
                                    WHERE id=?");
            $stmt->bind_param("sssssii", $question_text, $option_a, $option_b, $option_c, $option_d, $category_id, $id);
            if($stmt->execute()){
                echo json_encode(['status'=>'success']);
            } else {
                echo json_encode(['status'=>'error','message'=>'Error al actualizar']);
            }
            break;
        
        case 'delete':
            // ELIMINAR pregunta
            $id = (int)$_POST['id'];
            if($id < 1){
                echo json_encode(['status'=>'error','message'=>'ID inválido']);
                break;
            }
            $stmt = $conn->prepare("DELETE FROM questions WHERE id=?");
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