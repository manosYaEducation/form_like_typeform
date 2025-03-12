<?php
// models/Database.php
class Database {
    public static $instance = null;
    public $connection;
    public $host = '127.0.0.1';  // localhost
    public $user = 'alphadocere_mag_sostenible';
    public $password = 'jUN+_}DFO{Rn';
    public $database = 'alphadocere_mag_sostenible';
    public $port = 3307;

    public function __construct(){
        // Se añade el puerto en la conexión
        //$this->connection = new mysqli($this->host, $this->user, $this->password, $this->database, $this->port);
$this->connection = new mysqli($this->host, $this->user,$this->password,$this->database);        

        if($this->connection->connect_error){
            die("Error de conexión: " . $this->connection->connect_error);
        }
        
    // Establecer la codificaci��n de caracteres a UTF-8
    $this->connection->set_charset("utf8");
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

<!-- // models/Database.php
class Database {
    public static $instance = null;
    public $connection;
    public $host = '127.0.0.1';  // localhost
    public $user = 'root';
    public $password = '';
    public $database = 'forms';
    public $port = 3307;

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
} -->
