<?php
/* 
    CMS
    Variables de configuración para el proyecto
    Creación 10-07-2021
*/
//Validar el acceso a través de la url
if (strpos($_SERVER['REQUEST_URI'], '.php') !== false) {
    exit('No está permitido el acceso al recurso');
}
//Base URL del proyecto
$config['base_url'] = strtolower(explode('/', $_SERVER['SERVER_PROTOCOL'])[0]); //HTTP/1.0
$config['base_url'] = $config['base_url'] . 's://' . $_SERVER['HTTP_HOST'];
$config['base_url'] = $config['base_url'] .  $_SERVER['PHP_SELF'];
$config['base_url'] = str_replace('index.php', '', $config['base_url']);
//Root del proyecto 
$config['root'] = str_replace('index.php', '', $_SERVER['SCRIPT_FILENAME']);

// print_r($config);
