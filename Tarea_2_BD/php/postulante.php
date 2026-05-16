<?php
session_start();
require_once 'connect_DB.php';

header('Content-Type: application/json');

// Protección: solo postulantes
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 3) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

try {
    // Obtener todas las postulaciones donde el usuario es responsable
    $query = $conn->prepare("SELECT * FROM postulaciones_vista_academic WHERE responsable = ?");

    $query->execute([$_SESSION['user']]);
    $postulaciones = $query->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($postulaciones);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener postulaciones: ' . $e->getMessage()]);
}

?>