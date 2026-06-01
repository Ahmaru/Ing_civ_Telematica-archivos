<?php
session_start();
require_once 'connect_DB.php';

//archivo para logica de asignar una evaluacion y guardar en tabla evaluacion

header('Content-Type: application/json');

// Protección: solo evaluadores
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 2) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Método no permitido']);
    exit();
}

try {
    $codigo = $_POST['codigo_interno'] ?? null;
    $estado_nuevo = $_POST['estado_nuevo'] ?? null;
    $comentarios = trim($_POST['comentarios'] ?? '');

    // Validaciones
    if (!$codigo || !$estado_nuevo) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Código y estado requeridos']);
        exit();
    }

    // Validar que estado es válido (2=Aprobada, 3=Rechazada)
    if ($estado_nuevo != 2 && $estado_nuevo != 3) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Estado no válido']);
        exit();
    }

    // Usar procedure sp_registrar_evaluacion
    $stmt = $conn->prepare("CALL sp_registrar_evaluacion(?, ?, ?, ?)");
    if ($stmt->execute([$codigo, $_SESSION['user'], $estado_nuevo, $comentarios])) {
        echo json_encode(['success' => true, 'message' => 'Evaluación registrada correctamente']);
    } else {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Error al registrar evaluación']);
    }

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

?>