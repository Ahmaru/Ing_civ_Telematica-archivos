<?php
session_start();
require_once 'connect_DB.php';

header('Content-Type: application/json');

// Protección: solo administradores
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 1) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

try {
    $query = $conn->prepare("
        SELECT
            a.id_auditoria,
            a.codigo_interno,
            p.numero_postulacion,
            p.nombre_iniciativa,
            ep1.descripcion as estado_anterior,
            ep2.descripcion as estado_nuevo,
            a.fecha_cambio,
            COALESCE(i.nombre, 'Sistema') as usuario
        FROM auditoria_postulacion a
        JOIN postulacion p ON a.codigo_interno = p.codigo_interno
        LEFT JOIN estado_postulacion ep1 ON a.estado_anterior = ep1.id_estado
        LEFT JOIN estado_postulacion ep2 ON a.estado_nuevo = ep2.id_estado
        LEFT JOIN integrantes i ON a.rut_usuario = i.rut
        ORDER BY a.fecha_cambio DESC
        LIMIT 50
    ");
    $query->execute();
    echo json_encode($query->fetchAll(PDO::FETCH_ASSOC));

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
}

?>
