<?php
session_start();

if (!isset($_SESSION['rut'])){
    header("Location: ../html/login.html");
    exit();
}

//seccion para ADMINISTRADOR DE PROYECTOS
if($_SESSION['rol'] === 1){

}

//seccion para COORDINADOR DE PROYECTOS
if($_SESSION['rol'] === 2){

}

//seccion para POSTULANTE
if($_SESSION['rol'] === 3){

}



?>