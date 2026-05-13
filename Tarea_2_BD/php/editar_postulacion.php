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

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Obtener datos de la postulación para editar
    $codigo = $_GET['codigo'] ?? null;

    if (!$codigo) {
        http_response_code(400);
        echo json_encode(['error' => 'Código requerido']);
        exit();
    }

    // Verificar que es dueño y está en Borrador
    $query = $conn->prepare("
        SELECT p.*
        FROM postulacion p
        JOIN equipo_trabajo et ON p.codigo_interno = et.codigo_interno
        WHERE p.codigo_interno = ?
        AND et.rut = ?
        AND et.es_responsable = 1
        AND p.id_estado_postulacion = 5
    ");

    $query->execute([$codigo, $_SESSION['user']]);
    $postulacion = $query->fetch(PDO::FETCH_ASSOC);

    if (!$postulacion) {
        http_response_code(403);
        echo json_encode(['error' => 'No puedes editar esta postulación']);
        exit();
    }

    echo json_encode($postulacion);

} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Actualizar postulación
    $codigo = $_POST['codigo_interno'] ?? null;
    $nombre_iniciativa = trim($_POST['nombre_iniciativa'] ?? '');
    $objetivo = trim($_POST['objetivo'] ?? '');
    $descripcion_soluciones = trim($_POST['descripcion_soluciones'] ?? '');
    $resultados_esperados = trim($_POST['resultados_esperados'] ?? '');
    $presupuesto = $_POST['presupuesto'] ?? 0;
    $rut_empresa = trim($_POST['rut_empresa'] ?? '');
    $id_sede = $_POST['id_sede'] ?? null;
    $id_reg_ejec = $_POST['id_reg_ejec'] ?? null;
    $id_reg_impc = $_POST['id_reg_impc'] ?? null;
    $id_tipo_iniciativa = $_POST['id_tipo_iniciativa'] ?? null;

    // Validaciones
    if (!$codigo || empty($nombre_iniciativa) || !is_numeric($presupuesto) || $presupuesto <= 0) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Datos inválidos']);
        exit();
    }

    // Verificar que es dueño y está en Borrador
    $check = $conn->prepare("
        SELECT codigo_interno FROM postulacion p
        JOIN equipo_trabajo et ON p.codigo_interno = et.codigo_interno
        WHERE p.codigo_interno = ?
        AND et.rut = ?
        AND et.es_responsable = 1
        AND p.id_estado_postulacion = 5
    ");

    $check->execute([$codigo, $_SESSION['user']]);
    if (!$check->fetch()) {
        http_response_code(403);
        echo json_encode(['success' => false, 'message' => 'No puedes editar esta postulación']);
        exit();
    }

    try {
        $update = $conn->prepare("
            UPDATE postulacion SET
                nombre_iniciativa = ?,
                objetivo = ?,
                descripcion_soluciones = ?,
                resultados_esperados = ?,
                presupuesto = ?,
                rut_empresa = ?,
                id_sede = ?,
                id_reg_ejec = ?,
                id_reg_impc = ?,
                id_tipo_iniciativa = ?
            WHERE codigo_interno = ?
        ");

        $update->execute([
            $nombre_iniciativa,
            $objetivo,
            $descripcion_soluciones,
            $resultados_esperados,
            $presupuesto,
            $rut_empresa,
            $id_sede,
            $id_reg_ejec,
            $id_reg_impc,
            $id_tipo_iniciativa,
            $codigo
        ]);

        echo json_encode(['success' => true, 'message' => 'Postulación actualizada correctamente']);

    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
    }

} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no permitido']);
}

?>