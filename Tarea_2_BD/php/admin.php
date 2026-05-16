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

$action = $_GET['action'] ?? $_POST['action'] ?? '';

try {
    // ESTADÍSTICAS
    if ($action === 'stats') {
        $stats = [];

        // Total postulaciones
        $total = $conn->prepare("SELECT COUNT(*) as count FROM postulacion");
        $total->execute();
        $stats['total'] = $total->fetch(PDO::FETCH_ASSOC)['count'];

        // En revisión
        $revision = $conn->prepare("SELECT COUNT(*) as count FROM postulacion WHERE id_estado_postulacion = 1");
        $revision->execute();
        $stats['en_revision'] = $revision->fetch(PDO::FETCH_ASSOC)['count'];

        // Aprobadas
        $aprobadas = $conn->prepare("SELECT COUNT(*) as count FROM postulacion WHERE id_estado_postulacion = 2");
        $aprobadas->execute();
        $stats['aprobadas'] = $aprobadas->fetch(PDO::FETCH_ASSOC)['count'];

        // Rechazadas
        $rechazadas = $conn->prepare("SELECT COUNT(*) as count FROM postulacion WHERE id_estado_postulacion = 3");
        $rechazadas->execute();
        $stats['rechazadas'] = $rechazadas->fetch(PDO::FETCH_ASSOC)['count'];

        // Total evaluadores
        $evaluadores = $conn->prepare("SELECT COUNT(*) as count FROM credenciales WHERE id_tipo = 2");
        $evaluadores->execute();
        $stats['evaluadores'] = $evaluadores->fetch(PDO::FETCH_ASSOC)['count'];

        echo json_encode($stats);
    }

    // LISTAR EVALUADORES
    else if ($action === 'evaluadores') {
        $query = $conn->prepare("
            SELECT
                c.rut,
                i.nombre,
                i.mail,
                COUNT(e.id) as postulaciones_asignadas
            FROM credenciales c
            JOIN integrantes i ON c.rut = i.rut
            LEFT JOIN evaluacion e ON c.rut = e.rut_evaluador
            WHERE c.id_tipo = 2
            GROUP BY c.rut, i.nombre, i.mail
            ORDER BY i.nombre
        ");
        $query->execute();
        echo json_encode($query->fetchAll(PDO::FETCH_ASSOC));
    }

    // LISTAR TODAS LAS POSTULACIONES
    else if ($action === 'postulaciones') {
        $query = $conn->prepare("
            SELECT
                p.codigo_interno,
                p.numero_postulacion,
                p.nombre_iniciativa,
                empresa.nombre as empresa,
                p.presupuesto,
                ep.descripcion as estado,
                p.fecha_postulacion
            FROM postulacion p
            JOIN empresa ON p.rut_empresa = empresa.rut_empresa
            JOIN estado_postulacion ep ON p.id_estado_postulacion = ep.id_estado
            ORDER BY p.fecha_postulacion DESC
        ");
        $query->execute();
        echo json_encode($query->fetchAll(PDO::FETCH_ASSOC));
    }

    // POSTULACIONES SIN EVALUADOR ASIGNADO
    else if ($action === 'postulaciones_sin_evaluador') {
        $query = $conn->prepare("
            SELECT
                p.codigo_interno,
                p.numero_postulacion,
                p.nombre_iniciativa,
                empresa.nombre as empresa
            FROM postulacion p
            JOIN empresa ON p.rut_empresa = empresa.rut_empresa
            WHERE p.id_estado_postulacion = 1
            AND p.codigo_interno NOT IN (
                SELECT DISTINCT codigo_interno FROM evaluacion
            )
            ORDER BY p.fecha_postulacion DESC
        ");
        $query->execute();
        echo json_encode($query->fetchAll(PDO::FETCH_ASSOC));
    }

    // LISTAR ASIGNACIONES RECIENTES
    else if ($action === 'asignaciones') {
        $query = $conn->prepare("
            SELECT
                p.numero_postulacion,
                i.nombre as evaluador_nombre,
                e.fecha_evaluacion as fecha
            FROM evaluacion e
            JOIN postulacion p ON e.codigo_interno = p.codigo_interno
            JOIN integrantes i ON e.rut_evaluador = i.rut
            ORDER BY e.fecha_evaluacion DESC
            LIMIT 20
        ");
        $query->execute();
        echo json_encode($query->fetchAll(PDO::FETCH_ASSOC));
    }

    // ASIGNAR EVALUADOR A POSTULACIÓN (POST)
    else if ($action === 'asignar' && $_SERVER['REQUEST_METHOD'] === 'POST') {
        $codigo = $_POST['codigo'] ?? null;
        $rut = $_POST['rut'] ?? null;

        if (!$codigo || !$rut) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Código y RUT requeridos']);
            exit();
        }

        try {
            // Usar procedure sp_asignar_evaluador
            $stmt = $conn->prepare("CALL sp_asignar_evaluador(?, ?)");
            if ($stmt->execute([$codigo, $rut])) {
                echo json_encode(['success' => true, 'message' => 'Evaluador asignado correctamente']);
            } else {
                http_response_code(500);
                echo json_encode(['success' => false, 'message' => 'Error al asignar evaluador']);
            }
        } catch (Exception $e) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        }
    }

    else {
        http_response_code(400);
        echo json_encode(['error' => 'Acción no válida']);
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error del servidor: ' . $e->getMessage()]);
}

?>