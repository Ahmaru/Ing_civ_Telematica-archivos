<?php
session_start();
require_once 'connect_DB.php';

//archivo para registrar nuevas postulaciones usando logica mas compleja TT

// Protección: solo postulantes pueden crear
if (!isset($_SESSION['user']) || $_SESSION['rol'] != 3) {
    http_response_code(403);
    echo json_encode(['error' => 'Acceso denegado']);
    exit();
}

// Si es GET: mostrar formulario (el HTML ya lo tiene)
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // El formulario está en registrar_postulacion.html
    exit();
}

// Si es POST: crear postulación
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Obtener y validar datos
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

    // Validaciones básicas
    $errores = [];

    if (empty($nombre_iniciativa) || strlen($nombre_iniciativa) > 100) {
        $errores[] = "Nombre de iniciativa inválido";
    }
    if (empty($objetivo) || strlen($objetivo) > 255) {
        $errores[] = "Objetivo inválido";
    }
    if (empty($descripcion_soluciones) || strlen($descripcion_soluciones) > 255) {
        $errores[] = "Descripción inválida";
    }
    if (empty($resultados_esperados) || strlen($resultados_esperados) > 255) {
        $errores[] = "Resultados esperados inválidos";
    }
    if (!is_numeric($presupuesto) || $presupuesto <= 0) {
        $errores[] = "Presupuesto debe ser mayor a 0";
    }
    if (empty($rut_empresa)) {
        $errores[] = "RUT empresa requerido";
    }
    if (empty($id_sede) || empty($id_reg_ejec) || empty($id_reg_impc) || empty($id_tipo_iniciativa)) {
        $errores[] = "Todos los campos son requeridos";
    }

    // Si hay errores, devolver
    if (!empty($errores)) {
        $_SESSION['error'] = implode(', ', $errores);
        header("Location: ../html/registrar_postulacion.html");
        exit();
    }

    try {
        // Generar número de postulación secuencial: POST-XXX
        $last_post = $conn->query("SELECT MAX(CAST(SUBSTRING(numero_postulacion, 6) AS UNSIGNED)) as max_num FROM postulacion WHERE numero_postulacion LIKE 'POST-%'")->fetch(PDO::FETCH_ASSOC);
        $next_num = ($last_post['max_num'] ?? 0) + 1;
        $numero_postulacion = 'POST-' . str_pad($next_num, 3, '0', STR_PAD_LEFT);

        // Llamar procedure sp_crear_postulacion
        $stmt = $conn->prepare("CALL sp_crear_postulacion(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @codigo_out)");

        $stmt->execute([
            $numero_postulacion,
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
            $_SESSION['user']  // RUT del postulante logueado como responsable
        ]);

        // Consumir resultados del procedure para limpiar el buffer
        while ($stmt->nextRowset()) {
            $stmt->fetchAll();
        }

        // Obtener el código generado
        $result = $conn->query("SELECT @codigo_out as codigo")->fetch(PDO::FETCH_ASSOC);
        $codigo_interno = $result['codigo'];

        if ($codigo_interno > 0) {
            // Éxito
            $_SESSION['success'] = "Postulación creada correctamente. N°: $numero_postulacion";
            header("Location: ../html/postulante.html");
            exit();
        } else {
            throw new Exception("Error al generar código de postulación: " . ($codigo_interno ?? 'NULL'));
        }

    } catch (Exception $e) {
        $_SESSION['error'] = "Error al crear postulación: " . $e->getMessage();
        header("Location: ../html/registrar_postulacion.html");
        exit();
    }
}

?>