<?php
//mostrar errores
error_reporting(E_ALL);
ini_set('display_errors', '1');

//incluir el archivo 
// include('app/config/config.php');
include('app/config/Controlador_principal.php');

//instanciar la clase
$controladorPrincipal = new Controlador_principal();
// echo $controladorPrincipal->uri; #Como se accede a una característica de la clase
$controladorPrincipal->cargar(); #Como se accede a un método/funcion de la clase