<?php
// models/Database.php
class Database {
    private static $instance = null;
    private $connection;
    private $host = 'localhost';
    private $user = 'root';
    private $password = '';
    private $database = 'forms';

    private function __construct(){
        $this->connection = new mysqli($this->host, $this->user, $this->password, $this->database);
        if($this->connection->connect_error){
            die("Error de conexión: " . $this->connection->connect_error);
        }
    }

    public static function getInstance(){
        if(!self::$instance){
            self::$instance = new Database();
        }
        return self::$instance;
    }

    public function getConnection(){
        return $this->connection;
    }
}
?>
