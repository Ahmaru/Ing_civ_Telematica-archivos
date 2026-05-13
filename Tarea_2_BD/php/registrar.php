<?php
session_start();
require_once 'connect_DB.php';

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
        // Verificar que la empresa existe
        $check_empresa = $conn->prepare("SELECT rut_empresa FROM empresa WHERE rut_empresa = ?");
        $check_empresa->execute([$rut_empresa]);
        if (!$check_empresa->fetch()) {
            throw new Exception("Empresa no existe");
        }

        // Generar número de postulación único (formato: YYYYMMDD-XXXX)
        $numero_postulacion = date('Ymd') . '-' . str_pad(rand(1, 9999), 4, '0', STR_PAD_LEFT);

        // Iniciar transacción
        $conn->beginTransaction();

        // 1. Insertar postulación (estado = 5 = "Borrador")
        $insert_post = $conn->prepare("
            INSERT INTO postulacion (
                numero_postulacion, fecha_postulacion, nombre_iniciativa,
                objetivo, descripcion_soluciones, resultados_esperados,
                presupuesto, rut_empresa, id_sede, id_reg_ejec, id_reg_impc,
                id_tipo_iniciativa, id_estado_postulacion
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $insert_post->execute([
            $numero_postulacion,
            date('Y-m-d'),  // fecha_postulacion = hoy
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
            5  // id_estado = 5 (Borrador)
        ]);

        // Obtener el ID de la postulación recién creada
        $codigo_interno = $conn->lastInsertId();

        // 2. Insertar en equipo_trabajo (usuario como responsable)
        $insert_equipo = $conn->prepare("
            INSERT INTO equipo_trabajo (codigo_interno, rut, rol, es_responsable)
            VALUES (?, ?, ?, ?)
        ");

        $insert_equipo->execute([
            $codigo_interno,
            $_SESSION['user'],  // RUT del postulante logueado
            'Responsable',
            1  // es_responsable = 1
        ]);

        // Confirmar transacción
        $conn->commit();

        // Éxito
        $_SESSION['success'] = "Postulación creada correctamente. N°: $numero_postulacion";
        header("Location: ../html/postulante.html");
        exit();

    } catch (Exception $e) {
        // Revertir transacción en caso de error
        $conn->rollBack();
        $_SESSION['error'] = "Error al crear postulación: " . $e->getMessage();
        header("Location: ../html/registrar_postulacion.html");
        exit();
    }
}

?>