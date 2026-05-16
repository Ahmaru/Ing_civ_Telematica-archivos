<?php
session_start();
require_once 'connect_DB.php';

//archivo con la logica para el conteo de cuantas postulaciones quedan por evaluar por evaluador.

header('Content-Type: application/json');

// Protección: solo evaluadores
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 2) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

try {
    // Usar función SQL: fn_postulaciones_pendientes_evaluador
    $query = $conn->prepare("SELECT fn_postulaciones_pendientes_evaluador(?) as total");
    $query->execute([$_SESSION['user']]);
    $result = $query->fetch(PDO::FETCH_ASSOC);

    echo json_encode([
        'total' => $result['total'] ?? 0
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener cantidad: ' . $e->getMessage()]);
}

?>
