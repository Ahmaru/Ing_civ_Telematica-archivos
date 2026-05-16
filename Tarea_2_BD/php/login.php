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
        $_SESSION['user'] = $key['rut'];
        $_SESSION['rol'] = $key['id_tipo'];

        header("Location: frontpage.php");
        exit();
    } else {
        header("Location: ../html/login.html?error=1");
        exit();
    }
} else {
    header("Location: ../html/login.html?error=1");
    exit();
}

?>