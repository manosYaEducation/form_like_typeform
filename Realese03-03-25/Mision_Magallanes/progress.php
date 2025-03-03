<?php
// progress.php
session_start();
header('Content-Type: application/json; charset=utf-8');

require_once 'Database.php';
$db = new Database();
$conn = $db->getConnection();

// 1. Tomar rut de sesión
$user_rut = $_SESSION['rut'] ?? '';
if (empty($user_rut)) {
    echo json_encode(["success" => false, "message" => "No hay rut en sesión"]);
    exit;
}

// 2. Contar total de preguntas
$sqlTotal = "SELECT COUNT(*) as total FROM questions";
$resTotal = $conn->query($sqlTotal);
$rowTotal = $resTotal->fetch_assoc();
$totalQuestions = (int)$rowTotal['total'];

// 3. Contar cuántas ha respondido el rut
$stmt = $conn->prepare("
    SELECT COUNT(DISTINCT question_id) as answered 
    FROM answers 
    WHERE user_rut = ?
");
$stmt->bind_param("s", $user_rut);
$stmt->execute();
$res = $stmt->get_result();
$row = $res->fetch_assoc();
$answered = (int)$row['answered'];
$stmt->close();

$percentage = 0;
if ($totalQuestions > 0) {
    $percentage = ($answered / $totalQuestions) * 100;
}

// 4. Retornar
echo json_encode([
    "success" => true,
    "answered" => $answered,
    "total" => $totalQuestions,
    "percentage" => $percentage
]);
