<?php
session_start();
require_once 'connect_DB.php';

header('Content-Type: application/json');

// Protección: usuario debe estar logueado
if (!isset($_SESSION['user'])) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

try {
    $codigo = $_GET['codigo'] ?? null;

    if (!$codigo) {
        http_response_code(400);
        echo json_encode(['error' => 'Código de postulación requerido']);
        exit();
    }

    // Obtener detalles de la postulación
    $query = $conn->prepare("
        SELECT
            p.codigo_interno,
            p.numero_postulacion,
            p.nombre_iniciativa,
            p.objetivo,
            p.descripcion_soluciones,
            p.resultados_esperados,
            p.presupuesto,
            p.fecha_postulacion,
            empresa.nombre as empresa,
            sede.descripcion as sede,
            r1.descripcion as region_ejecucion,
            r2.descripcion as region_impacto,
            ti.descripcion as tipo_iniciativa,
            ep.descripcion as estado
        FROM postulacion p
        JOIN empresa ON p.rut_empresa = empresa.rut_empresa
        JOIN sede ON p.id_sede = sede.id_sede
        JOIN regiones r1 ON p.id_reg_ejec = r1.id_regiones
        JOIN regiones r2 ON p.id_reg_impc = r2.id_regiones
        JOIN tipo_iniciativa ti ON p.id_tipo_iniciativa = ti.id_tipo_in
        JOIN estado_postulacion ep ON p.id_estado_postulacion = ep.id_estado
        WHERE p.codigo_interno = ?
    ");

    $query->execute([$codigo]);
    $postulacion = $query->fetch(PDO::FETCH_ASSOC);

    if (!$postulacion) {
        http_response_code(404);
        echo json_encode(['error' => 'Postulación no encontrada']);
        exit();
    }

    echo json_encode($postulacion);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error: ' . $e->getMessage()]);
}

?>