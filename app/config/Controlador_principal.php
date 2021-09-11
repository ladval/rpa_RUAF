<?php
/* 
    CMS
    Clase principal del proyecto
    Creación 17-07-2021
*/

//Validar el acceso a través de la url

if (strpos($_SERVER['REQUEST_URI'], '.php') !== false) {
    exit('No está permitido el acceso al recurso');
}

class Controlador_principal
{
    //Características (public, protected, private)
    //Privado: Solo se puede acceder en la clase que es definida
    //Publico: Se extiende y se puede acceder desde cualquier clase
    //Protegido: Se puede acceder desde la clase que se define y desde las que se heredan

    protected $uri;

    //Comportamientos
    function __construct()
    {
        $this->uri = (!empty($_SERVER['QUERY_STRING'])) ? $_SERVER['QUERY_STRING'] : null;
        // include('config.php');
    }


    protected function vista($ruta, $info = null)
    {
        (is_array($info) && !empty($info)) ? extract($info) : null;
        include('app/view/' . $ruta . '.php');
    }

    function cargar()
    {
        $controller =  (!empty(explode('/', $this->uri)[1])) ? explode('/', $this->uri)[1] : null;

        //configuración para fechas
        date_default_timezone_set('America/Bogota');

        //incluir el archivo con las funciones
        include('funciones.php');

        //validar si existe el archivo de tipo controller
        if (is_file('app/controller/' . $controller . '.php')) {

            //incluir archivo controller
            include('app/controller/' . $controller . '.php');

            //instanciar la clase del controller
            $clase = new $controller();

            //validar sí existe el método index
            $funcion = (!empty(explode('/', $this->uri)[2])) ? explode('/', $this->uri)[2] : null;
            if (!empty($funcion)) {
                if (method_exists($clase, $funcion)) {
                    $clase->$funcion(); //Llamando dinamicamente la funcion
                } else {
                    echo 'No existe el MÉTODO en el controller';
                }
            } else {
                $clase->index();
            }
        } else {
            echo 'No existe el ARCHIVO en el controller';
        }
    }
}
