<?php

namespace app\model;
//namespace siempre por regla debe ir al inicio del archivo o genera error
/* 
    CMS
    Controlador del MVC
    Creación 14-08-2021
*/
//Validar el acceso a través de la url
if (strpos($_SERVER['REQUEST_URI'], '.php') !== false) {
    exit('No está permitido el acceso al recurso');
}

class Procesos

{
    protected $midb;
    function __construct()
    {
        require_once('app/config/conn.php');
        $this->midb = $db;
    }

    //Mostrar resumen de todas las páginas
    function listado()
    {
        $sql = $this->midb->query("
        SELECT * FROM usuarios WHERE status = 0;
");
        $resultado = stmt($sql);
        return ($resultado->count() > 0) ? $resultado : false;
    }


    function expedicion($datos)
    {
        $sql = $this->midb->query("
        SELECT * FROM base_ruaf.ani WHERE ANINuip =" . $datos['cedula'] . "
");
        $resultado = stmt($sql);
        return ($resultado->count() > 0) ? $resultado : false;
    }

    function actualizar($data)
    {
        $sql = "
        UPDATE usuarios SET
        status = " . $data['status'] . ",
        respuesta = '" . $data['response'] . "',
        fecha_actualizacion = '" .  date("Y-m-d H:i:s")  . "'
        WHERE uid = " . $data['id_usuario'] . ";
    ";
        $stmt = $this->midb->prepare($sql);
        return ($stmt->execute()) ? $sql : false;
    }
}
