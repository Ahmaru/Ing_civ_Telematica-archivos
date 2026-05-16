<?php

//archivo para encriptar passwords para los datos pre-hechos

ini_set('display_errors',1);
error_reporting(E_ALL);

session_start();
require_once 'connect_DB.php';

$sts = $conn->query("SELECT rut,password FROM credenciales");

$update = $conn->prepare("UPDATE credenciales SET password = ? WHERE rut = ?");

while($row = $sts->fetch()){

    $hash_pass = password_hash($row['password'],PASSWORD_DEFAULT);

    $update->execute([$hash_pass,$row['rut']]);

}

echo "Hasheado completado loquete";

?>