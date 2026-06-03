<?php

ini_set("display_errors", 1);
error_reporting(E_ALL);

session_start();
require_once "../php/connect_DB.php";

$sts = $conn->query(
    "SELECT rut FROM credenciales ",
);

$update = $conn->prepare("UPDATE credenciales SET password = ? WHERE rut = ?");

$hash_pass = password_hash('password', PASSWORD_DEFAULT);

while ($row = $sts->fetch()) {

    $update->execute([$hash_pass, $row["rut"]]);
}

echo "Hasheado completado loquete";

?>
