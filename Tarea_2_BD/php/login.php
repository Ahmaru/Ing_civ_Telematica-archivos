<?php
session_start();
require_once 'connect_DB.php';

$usr = trim($_POST['usrname'] ?? ''); //este es el rut
$psswrd = $_POST['psswrd'] ?? ''; //esta es la contra


$ola = $conn->prepare("SELECT rut,password,id_tipo FROM credenciales WHERE rut = ?");
$ola->execute([$usr]);
$key = $ola->fetch(PDO::FETCH_ASSOC);

if ($key){
    
    if(password_verify($psswrd,$key['password'])){
        $_SESSION['rut'] = $key['rut'];
        $_SESSION['rol'] = $key['id_tipo'];

        header("Location: ../php/frontpage.php");
        exit();
    } else {
        echo "Credenciales incorrectas, intente nuevamente.";
        exit(1);
    }
} else {
    echo "Usuario no encontrado. Intente nuevamente o registre un nuevo usuario. ";
}

?>