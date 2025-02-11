<?php
// models/Question.php
require_once 'Database.php';

class Question {
    private $db;
    
    public function __construct(){
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function getTotalQuestions(){
        $result = $this->db->query("SELECT COUNT(*) as total FROM questions");
        $row = $result->fetch_assoc();
        return $row['total'];
    }
    
    public function getQuestions($offset, $limit){
        $stmt = $this->db->prepare("SELECT * FROM questions ORDER BY id LIMIT ?, ?");
        $stmt->bind_param("ii", $offset, $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function createQuestion($question_text, $option_a, $option_b, $option_c, $option_d){
        $stmt = $this->db->prepare("INSERT INTO questions (question_text, option_a, option_b, option_c, option_d) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $question_text, $option_a, $option_b, $option_c, $option_d);
        return $stmt->execute();
    }
    
    public function getQuestionById($id){
        $stmt = $this->db->prepare("SELECT * FROM questions WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }
    
    public function updateQuestion($id, $question_text, $option_a, $option_b, $option_c, $option_d){
        $stmt = $this->db->prepare("UPDATE questions SET question_text = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ? WHERE id = ?");
        $stmt->bind_param("sssssi", $question_text, $option_a, $option_b, $option_c, $option_d, $id);
        return $stmt->execute();
    }
    
    public function deleteQuestion($id){
        $stmt = $this->db->prepare("DELETE FROM questions WHERE id = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}
?>
