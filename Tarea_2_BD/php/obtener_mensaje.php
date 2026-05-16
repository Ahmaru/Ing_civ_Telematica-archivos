<?php
session_start();
header('Content-Type: application/json');

$mensaje = ['type' => null, 'text' => null];

if (isset($_SESSION['success'])) {
    $mensaje['type'] = 'success';
    $mensaje['text'] = $_SESSION['success'];
    unset($_SESSION['success']);
} elseif (isset($_SESSION['error'])) {
    $mensaje['type'] = 'error';
    $mensaje['text'] = $_SESSION['error'];
    unset($_SESSION['error']);
}

echo json_encode($mensaje);
?>
