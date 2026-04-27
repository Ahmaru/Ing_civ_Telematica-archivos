<?php

$host = 'localhost';
$usr = 'test_usr';
$password = 'ola';
$dbname = 'postulaciones_ct_usm';
$port = "3306";

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname",$usr,$password);
    //no caxe que iba despues
    //echo "Connection good :)\n";
} catch (PDOException $e) {
    echo "Error in la connection: " . $e->getMessage();
}

?>