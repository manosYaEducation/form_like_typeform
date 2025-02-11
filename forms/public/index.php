<?php
session_start();

// Define la ruta base del proyecto (carpeta padre de public)
define('BASE_PATH', dirname(__DIR__));

// Incluir los controladores
require_once BASE_PATH . '/controllers/UserController.php';
require_once BASE_PATH . '/controllers/QuestionController.php';
require_once BASE_PATH . '/controllers/AdminController.php';

// Enrutado sencillo mediante el parámetro GET "action"
$action = isset($_GET['action']) ? $_GET['action'] : 'register';

switch($action){
    case 'register':
        $userController = new UserController();
        $userController->register();
        break;
    case 'questions':
        $questionController = new QuestionController();
        $questionController->showQuestions();
        break;
    case 'saveAnswers':
        $questionController = new QuestionController();
        $questionController->saveAnswers();
        break;
    case 'finish':
        include BASE_PATH . '/views/finish.php';
        break;
    case 'admin':
        $admin_action = isset($_GET['admin_action']) ? $_GET['admin_action'] : 'list';
        $adminController = new AdminController();
        if($admin_action == 'list'){
            $adminController->listQuestions();
        } elseif($admin_action == 'add'){
            $adminController->addQuestion();
        } elseif($admin_action == 'edit'){
            $adminController->editQuestion();
        } elseif($admin_action == 'delete'){
            $adminController->deleteQuestion();
        } else {
            $adminController->listQuestions();
        }
        break;
    default:
        $userController = new UserController();
        $userController->register();
        break;
}
?>
