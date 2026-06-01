<?php
session_start();
require_once 'connect_DB.php';

//archivo para la logica que muestra las postulaciones que estan asignadas al evaluador.

header('Content-Type: application/json');

// Protección: solo evaluadores
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 2) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

try {
    // Obtener búsqueda opcional
    $busqueda = $_GET['q'] ?? '';

    // Query: postulaciones EN REVISIÓN asignadas al evaluador logueado
    $sql = "
        SELECT
            p.codigo_interno,
            p.numero_postulacion,
            p.nombre_iniciativa,
            empresa.nombre as empresa,
            ep.descripcion as estado,
            p.fecha_postulacion,
            ti.descripcion as tipo_iniciativa
        FROM postulacion p
        JOIN empresa ON p.rut_empresa = empresa.rut_empresa
        JOIN estado_postulacion ep ON p.id_estado_postulacion = ep.id_estado
        JOIN tipo_iniciativa ti ON p.id_tipo_iniciativa = ti.id_tipo_in
        JOIN evaluacion e ON p.codigo_interno = e.codigo_interno
        WHERE e.rut_evaluador = ? AND p.id_estado_postulacion = 1
    ";

    // Si hay búsqueda, agregar filtro
    if (!empty($busqueda)) {
        $sql .= " AND (
            p.numero_postulacion LIKE ?
            OR p.nombre_iniciativa LIKE ?
            OR empresa.nombre LIKE ?
        )";
    }

    $sql .= " ORDER BY p.fecha_postulacion DESC";

    $query = $conn->prepare($sql);

    // Ejecutar con o sin búsqueda
    if (!empty($busqueda)) {
        $busqueda_param = '%' . $busqueda . '%';
        $query->execute([$_SESSION['user'], $busqueda_param, $busqueda_param, $busqueda_param]);
    } else {
        $query->execute([$_SESSION['user']]);
    }

    $postulaciones = $query->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($postulaciones);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al obtener postulaciones: ' . $e->getMessage()]);
}

?>