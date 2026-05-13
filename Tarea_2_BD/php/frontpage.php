<?php
session_start();
require_once 'connect_DB.php';

if (!isset($_SESSION['user'])){
    header("Location: ../html/login.html");
    exit();
}

//Todos usan la barra de busqueda asique definimos el archivo.

//seccion para ADMINISTRADOR
//El admin solamente ve a los evaluadores y postulantes, no ve las postulaciones.

//seccion para EVALUADOR DE PROYECTOS
//Ve las postulaciones y las puede evaluar, editar estado. Este usa barra de busqueda pa postulaciones y evaluar

//seccion para POSTULANTE
//crea postulaciones y edita postulaciones en estado borrador.

if ($_SESSION['rol'] === 1) {
    //echo 'Admin';
    header('Location: ../html/admin.html');
    exit();
} elseif ($_SESSION['rol'] === 2) {
    //echo 'Evaluador';
    header('Location: ../html/evaluador.html');
    exit();
} elseif ($_SESSION['rol'] === 3) {
    //echo 'Postulante';
    header("Location: ../html/postulante.html");
    exit();
} else {
    echo 'MAL AGARRAO EL ROL';
}

?>