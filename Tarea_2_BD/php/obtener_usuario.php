<?php
session_start();
require_once 'connect_DB.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user'])) {
    http_response_code(403);
    echo json_encode(['error' => 'No logueado']);
    exit();
}

try {
    $query = $conn->prepare("
        SELECT i.nombre, c.id_tipo
        FROM integrantes i
        JOIN credenciales c ON i.rut = c.rut
        WHERE i.rut = ?
    ");

    $query->execute([$_SESSION['user']]);
    $usuario = $query->fetch(PDO::FETCH_ASSOC);

    if ($usuario) {
        echo json_encode([
            'nombre' => $usuario['nombre'],
            'rut' => $_SESSION['user'],
            'rol' => $_SESSION['rol']
        ]);
    } else {
        echo json_encode(['error' => 'Usuario no encontrado']);
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}

?>