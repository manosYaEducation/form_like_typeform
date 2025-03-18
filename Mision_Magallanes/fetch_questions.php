<?php
// fetch_questions.php
require_once 'Database.php';

header('Content-Type: application/json; charset=utf-8');

$conn = (new Database())->getConnection();

// Tomar category_id de la URL si existe
$categoryId = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;

try {
    switch ("list") {  // Usamos "list" para listar
        case 'list':
            // Filtrar preguntas por categoría (si se pasa un category_id)
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
            while($row = $result->fetch_assoc()){
                $questions[] = $row;
            }

            // Obtener total de categorías
            $sqlCatCount = "SELECT COUNT(*) as total FROM categories";
            $resCatCount = $conn->query($sqlCatCount);
            $rowCatCount = $resCatCount->fetch_assoc();
            $totalCategories = (int)$rowCatCount['total'];

            // Obtener el nombre de la categoría actual (si $categoryId > 0)
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
    }
} catch(Exception $e){
    echo json_encode(['status'=>'error','message'=>$e->getMessage()]);
}
