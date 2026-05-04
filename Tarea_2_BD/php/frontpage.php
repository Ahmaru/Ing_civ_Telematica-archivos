<?php
session_start();
require_once 'connect_DB.php';

if (!isset($_SESSION['rut'])){
    header("Location: ../html/login.html");
    exit();
}

//Todos usan la barra de busqueda asique definimos el archivo.

//seccion para ADMINISTRADOR
//El admin solamente ve a los evaluadores y postulantes, no ve las postulaciones.
if($_SESSION['rol'] === 1){

    include 'admin.php';
} else {

}

//seccion para EVALUADOR DE PROYECTOS
//Ve las postulaciones y las puede evaluar, editar estado. Este usa barra de busqueda pa postulaciones y evaluar
if($_SESSION['rol'] === 2){

}

//seccion para POSTULANTE
//crea postulaciones y edita postulaciones en estado borrador.
if($_SESSION['rol'] === 3){
    //logica del postulante
    header("Location: searchbar.php");

}



?>