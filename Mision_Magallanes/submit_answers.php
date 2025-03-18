<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

require_once 'Database.php';

try {
    // Activar reporte de errores para depuración
    ini_set('display_errors', 1);
    error_reporting(E_ALL);
    
    $db = new Database();
    $conn = $db->getConnection();
    
    $rawData = file_get_contents('php://input');
    $data = json_decode($rawData, true);
    
    error_log("submit_answers.php - Received data: " . $rawData);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception('Error al decodificar JSON: ' . json_last_error_msg());
    }
    
    $currentCategory = isset($data['category_id']) ? (int)$data['category_id'] : 0;
    $answers = isset($data['answers']) ? $data['answers'] : [];
    
    if (empty($answers)) {
        throw new Exception('No se recibieron respuestas para guardar');
    }
    
    $currentUserRut = $_SESSION['rut'] ?? '';
    
    if (empty($currentUserRut)) {
        throw new Exception('No se ha identificado al usuario (RUT)');
    }
    
    $conn->begin_transaction();
    
    try {
        $insertCount = 0;
        $updateCount = 0;
        
        foreach ($answers as $ans) {
            if (!isset($ans['question_id']) || !isset($ans['selected_option'])) {
                continue;
            }
            
            $questionId = (int)$ans['question_id'];
            $selectedOption = $ans['selected_option'];
            
            // Verificar que la pregunta exista
            $checkQuestionStmt = $conn->prepare("SELECT id FROM questions WHERE id = ?");
            $checkQuestionStmt->bind_param("i", $questionId);
            $checkQuestionStmt->execute();
            $questionResult = $checkQuestionStmt->get_result();
            if ($questionResult->num_rows === 0) {
                error_log("Question ID $questionId does not exist");
                $checkQuestionStmt->close();
                continue;
            }
            $checkQuestionStmt->close();
            
            // Verificar si ya existe una respuesta para este usuario y pregunta
            $checkStmt = $conn->prepare("SELECT id FROM answers WHERE user_rut = ? AND question_id = ?");
            $checkStmt->bind_param("si", $currentUserRut, $questionId);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();
            
            if ($checkResult->num_rows > 0) {
                $updateStmt = $conn->prepare("UPDATE answers SET selected_option = ?, answered_at = NOW() WHERE user_rut = ? AND question_id = ?");
                $updateStmt->bind_param("ssi", $selectedOption, $currentUserRut, $questionId);
                if ($updateStmt->execute()) {
                    $updateCount++;
                } else {
                    error_log("Error updating answer: " . $updateStmt->error);
                }
                $updateStmt->close();
            } else {
                $insertStmt = $conn->prepare("INSERT INTO answers (user_rut, question_id, selected_option, answered_at) VALUES (?, ?, ?, NOW())");
                $insertStmt->bind_param("sis", $currentUserRut, $questionId, $selectedOption);
                if ($insertStmt->execute()) {
                    $insertCount++;
                } else {
                    error_log("Error inserting answer: " . $insertStmt->error);
                    throw new Exception("Error al insertar respuesta para pregunta ID $questionId: " . $insertStmt->error);
                }
                $insertStmt->close();
            }
            $checkStmt->close();
        }
        
        $conn->commit();
        
        error_log("Answers processed successfully: $insertCount inserted, $updateCount updated");
        
        // Determinar si existe siguiente categoría
        $hasNext = false;
        $nextCategoryId = null;
        
        $stmt2 = $conn->prepare("SELECT id FROM categories WHERE id > ? ORDER BY id ASC LIMIT 1");
        $stmt2->bind_param("i", $currentCategory);
        $stmt2->execute();
        $result = $stmt2->get_result();
        $nextCat = $result->fetch_assoc();
        if ($nextCat) {
            $hasNext = true;
            $nextCategoryId = (int)$nextCat['id'];
        }
        $stmt2->close();
        
        $response = [
            "success" => true,
            "hasNextCategory" => $hasNext,
            "insertedCount" => $insertCount,
            "updatedCount" => $updateCount
        ];
        
        if ($hasNext && $nextCategoryId !== null) {
            $response["nextCategoryId"] = $nextCategoryId;
        } else {
            $response["hasNextCategory"] = false;
        }
        
        echo json_encode($response);
        
    } catch (Exception $e) {
        $conn->rollback();
        throw $e;
    }
    
} catch (Exception $e) {
    error_log("Exception in submit_answers.php: " . $e->getMessage());
    echo json_encode([
        "success" => false,
        "message" => $e->getMessage()
    ]);
}
?>