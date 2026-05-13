<?php
session_start();
require_once 'connect_DB.php';

header('Content-Type: application/json');

// Protección: solo postulantes
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 3) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Acceso denegado']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
    exit();
}

try {
    $codigo = $_POST['codigo'] ?? null;

    if (!$codigo) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Código requerido']);
        exit();
    }

    // Verificar que postulación existe, está en Borrador y el usuario es responsable
    $check = $conn->prepare("
        SELECT p.codigo_interno, p.id_estado_postulacion
        FROM postulacion p
        JOIN equipo_trabajo et ON p.codigo_interno = et.codigo_interno
        WHERE p.codigo_interno = ?
        AND et.rut = ?
        AND et.es_responsable = 1
        AND p.id_estado_postulacion = 5
    ");

    $check->execute([$codigo, $_SESSION['user']]);
    if (!$check->fetch()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'No puedes enviar esta postulación (solo borrador y siendo responsable)']);
        exit();
    }

    // Cambiar estado de 5 (Borrador) a 1 (En revisión)
    $update = $conn->prepare("
        UPDATE postulacion
        SET id_estado_postulacion = 1
        WHERE codigo_interno = ?
    ");

    if ($update->execute([$codigo])) {
        echo json_encode(['success' => true, 'message' => 'Postulación enviada correctamente']);
    } else {
        throw new Exception('Error al actualizar');
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

?>