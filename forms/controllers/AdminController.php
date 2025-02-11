<?php
// controllers/AdminController.php
require_once BASE_PATH . '/models/Question.php';

class AdminController {
    private $questionModel;
    
    public function __construct(){
        $this->questionModel = new Question();
    }
    
    // Listar todas las preguntas (sin paginación para el administrador)
    public function listQuestions(){
        $questions = $this->questionModel->getQuestions(0, 1000); // Asumimos menos de 1000 preguntas
        include BASE_PATH . '/views/admin/list_questions.php';
    }
    
    // Agregar una nueva pregunta
    public function addQuestion(){
        $error = '';
        if ($_SERVER['REQUEST_METHOD'] === 'POST'){
            $question_text = trim($_POST['question_text']);
            $option_a = trim($_POST['option_a']);
            $option_b = trim($_POST['option_b']);
            $option_c = trim($_POST['option_c']);
            $option_d = trim($_POST['option_d']);
            
            if(empty($question_text) || empty($option_a) || empty($option_b) || empty($option_c) || empty($option_d)){
                $error = "Todos los campos son obligatorios.";
            } else {
                if($this->questionModel->createQuestion($question_text, $option_a, $option_b, $option_c, $option_d)){
                    header("Location: index.php?action=admin&admin_action=list");
                    exit();
                } else {
                    $error = "Error al agregar la pregunta.";
                }
            }
        }
        include BASE_PATH . '/views/admin/add_question.php';
    }
    
    // Editar una pregunta existente
    public function editQuestion(){
        $error = '';
        if (!isset($_GET['id'])) {
            header("Location: index.php?action=admin&admin_action=list");
            exit();
        }
        $id = (int) $_GET['id'];
        $question = $this->questionModel->getQuestionById($id);
        if (!$question) {
            header("Location: index.php?action=admin&admin_action=list");
            exit();
        }
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST'){
            $question_text = trim($_POST['question_text']);
            $option_a = trim($_POST['option_a']);
            $option_b = trim($_POST['option_b']);
            $option_c = trim($_POST['option_c']);
            $option_d = trim($_POST['option_d']);
            
            if(empty($question_text) || empty($option_a) || empty($option_b) || empty($option_c) || empty($option_d)){
                $error = "Todos los campos son obligatorios.";
            } else {
                if($this->questionModel->updateQuestion($id, $question_text, $option_a, $option_b, $option_c, $option_d)){
                    header("Location: index.php?action=admin&admin_action=list");
                    exit();
                } else {
                    $error = "Error al actualizar la pregunta.";
                }
            }
        }
        include BASE_PATH . '/views/admin/edit_question.php';
    }
    
    // Eliminar una pregunta
    public function deleteQuestion(){
        if (!isset($_GET['id'])) {
            header("Location: index.php?action=admin&admin_action=list");
            exit();
        }
        $id = (int) $_GET['id'];
        $this->questionModel->deleteQuestion($id);
        header("Location: index.php?action=admin&admin_action=list");
        exit();
    }
}
?>
