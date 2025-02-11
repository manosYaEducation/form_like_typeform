<?php
// controllers/QuestionController.php
require_once BASE_PATH . '/models/Question.php';
require_once BASE_PATH . '/models/Answer.php';

class QuestionController {
    private $questionModel;
    private $answerModel;
    
    public function __construct(){
        $this->questionModel = new Question();
        $this->answerModel   = new Answer();
    }
    
    public function showQuestions(){
        if (!isset($_SESSION['rut'])){
            header("Location: index.php?action=register");
            exit();
        }
        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
        if($page < 1) $page = 1;
        $questionsPerPage = 3;
        $offset = ($page - 1) * $questionsPerPage;
        $totalQuestions = $this->questionModel->getTotalQuestions();
        $totalPages = ceil($totalQuestions / $questionsPerPage);
        $questions = $this->questionModel->getQuestions($offset, $questionsPerPage);
        include BASE_PATH . '/views/question.php';
    }
    
    public function saveAnswers(){
        if (!isset($_SESSION['rut'])){
            header("Location: index.php?action=register");
            exit();
        }
        if ($_SERVER['REQUEST_METHOD'] === 'POST'){
            $page = isset($_POST['page']) ? (int)$_POST['page'] : 1;
            $totalPages = isset($_POST['totalPages']) ? (int)$_POST['totalPages'] : 1;
            $answers = isset($_POST['answer']) ? $_POST['answer'] : array();
            $this->answerModel->saveAnswers($_SESSION['rut'], $answers);
            if($page < $totalPages){
                $nextPage = $page + 1;
                header("Location: index.php?action=questions&page=" . $nextPage);
            } else {
                header("Location: index.php?action=finish");
            }
            exit();
        }
    }
}
?>
