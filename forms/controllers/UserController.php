<?php
// controllers/UserController.php
require_once BASE_PATH . '/models/User.php';

class UserController {
    private $user;
    public function __construct(){
        $this->user = new User();
    }
    
    public function register(){
        $error = '';
        if ($_SERVER['REQUEST_METHOD'] == 'POST'){
            $rut    = trim($_POST['rut']);
            $nombre = trim($_POST['nombre']);
            $correo = trim($_POST['correo']);

            if(empty($rut) || empty($nombre) || empty($correo)){
                $error = "Por favor, complete todos los campos.";
            } elseif (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
                $error = "Correo inválido.";
            } else {
                if($this->user->register($rut, $nombre, $correo)){
                    $_SESSION['rut'] = $rut;
                    header("Location: index.php?action=questions&page=1");
                    exit();
                } else {
                    $error = "Error al registrar el usuario.";
                }
            }
        }
        include BASE_PATH . '/views/register.php';
    }
}
?>
