<?php
// models/Database.php
class Database {
    public static $instance = null;
    public $connection;
    public $host = '127.0.0.1';  // localhost
    public $user = 'root';
    public $password = '';
    public $database = 'forms';
    public $port = 3306;

    public function __construct(){
        // Se añade el puerto en la conexión
        $this->connection = new mysqli($this->host, $this->user, $this->password, $this->database, $this->port);

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
