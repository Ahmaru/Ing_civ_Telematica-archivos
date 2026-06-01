<?php
session_start();
session_destroy();
header("Location: ../html/login.html");
exit();

//archivo de logout para sentido del codigo y orden

?>
