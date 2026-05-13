<?php
session_start();
require_once 'connect_DB.php';

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

    // Verificar que la postulación existe
    $check_post = $conn->prepare("SELECT codigo_interno FROM postulacion WHERE codigo_interno = ?");
    $check_post->execute([$codigo]);
    if (!$check_post->fetch()) {
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'Postulación no encontrada']);
        exit();
    }

    // Verificar que el evaluador está asignado a esta postulación
    $check_asignado = $conn->prepare("
        SELECT id FROM evaluacion WHERE codigo_interno = ? AND rut_evaluador = ?
    ");
    $check_asignado->execute([$codigo, $_SESSION['user']]);
    if (!$check_asignado->fetch()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'No tienes permiso para evaluar esta postulación']);
        exit();
    }

    try {
        $conn->beginTransaction();

        // 1. Actualizar estado de la postulación
        $update_post = $conn->prepare("
            UPDATE postulacion
            SET id_estado_postulacion = ?
            WHERE codigo_interno = ?
        ");
        $update_post->execute([$estado_nuevo, $codigo]);

        // 2. Actualizar la evaluación con comentarios y estado final
        $update_eval = $conn->prepare("
            UPDATE evaluacion
            SET estado_nuevo = ?, comentarios = ?
            WHERE codigo_interno = ? AND rut_evaluador = ?
        ");
        $update_eval->execute([$estado_nuevo, $comentarios, $codigo, $_SESSION['user']]);

        $conn->commit();

        echo json_encode(['success' => true, 'message' => 'Evaluación registrada correctamente']);

    } catch (Exception $e) {
        $conn->rollBack();
        throw $e;
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

?>