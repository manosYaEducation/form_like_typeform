<?php
// models/User.php
require_once 'Database.php';

class User {
    private $db;
    public function __construct(){
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function register($rut, $nombre, $correo){
        $stmt = $this->db->prepare("INSERT INTO users (rut, nombre, correo) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE nombre = ?, correo = ?");
        $stmt->bind_param("sssss", $rut, $nombre, $correo, $nombre, $correo);
        return $stmt->execute();
    }
}
?>
