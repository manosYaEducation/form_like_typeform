<?php
// models/Answer.php
require_once 'Database.php';

class Answer {
    private $db;
    public function __construct(){
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function saveAnswers($user_rut, $answers){
        // $answers es un arreglo asociativo: [question_id => selected_option]
        foreach($answers as $questionId => $selectedOption){
            $stmt = $this->db->prepare("INSERT INTO answers (user_rut, question_id, selected_option) VALUES (?, ?, ?)");
            $stmt->bind_param("sis", $user_rut, $questionId, $selectedOption);
            $stmt->execute();
        }
    }
}
?>
