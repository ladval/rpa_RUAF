<?php
/* 
    CMS
    Controlador del MVC
    Creación 08-09-2021
*/
//Validar el acceso a través de la url
if (strpos($_SERVER['REQUEST_URI'], '.php') !== false) {
    exit('No está permitido el acceso al recurso');
}

class Procesos extends Controlador_principal
{
    protected $procesos = array();
    function __construct()
    {
        parent::__construct();
        //incluir archivo del model
        include('app/model/procesos.php');
        //instanciar la clase del model
        $this->procesos = new app\model\procesos;
    }

    function index()
    {

        $listado_usuarios = $this->procesos->listado();
        $listado_usuarios = json_encode($listado_usuarios);
        $datos = [
            'listado' => $listado_usuarios
        ];
        //incluir vista
        $this->vista('procesos', $datos);
    }

    function expedicion()
    {
        if (!empty($_POST)) {
            $datos = [
                'cedula' => $_POST['cedula']
            ];
            $resultado = $this->procesos->expedicion($datos);
            $resultado = json_encode($resultado);
            $datos = [
                'response' => $resultado
            ];
            $this->vista('expedicion', $datos);
        }
    }

    function actualizar()
    {
        if (!empty($_POST)) {
            $datos = [
                'response' => $_POST['response'],
                'status' => $_POST['status'],
                'id_usuario' => $_POST['id_usuario']
            ];
            $resultado = $this->procesos->actualizar($datos);
            if ($resultado == true) {
                $response = 1;
            } else {
                $response = 0;
            }
            $datos = [
                'response' => '1'
            ];
            $this->vista('response', $datos);
        }
    }
}
