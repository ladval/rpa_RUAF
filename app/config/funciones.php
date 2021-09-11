<?php
//configuracion
function config($indice = null)
{
    $config = array();
    include('config.php');
    return (!empty($config[$indice])) ? $config[$indice] : false;
}


//Redirigir a una ruta => tipo: error, advertencia
function redirigir($ruta, $mensaje = null, $tipo = null)
{
    $mensajeTipo = ($tipo != null) ? '?' . $tipo . '=' . $mensaje : '';
    $headerdata = 'location:' . config('base_url') . $ruta . $mensajeTipo;
    header($headerdata);
    

}

function GET()
{
    $request_uri = explode('?', $_SERVER['REQUEST_URI']);
    if (!empty($request_uri[1])) {
        $request_uri = explode('&', $request_uri[1]);
        foreach ($request_uri as $GETS) {
            $GetRows = explode('=', $GETS);
            $GET[$GetRows[0]] = urldecode($GetRows[1]);
        }
        return $GET;
    }
    return null;
}

//Sesión del usuario
function sessionAdministrador()
{
    @session_start();
    return (!empty($_SESSION['administrador'])) ? $_SESSION['administrador'] : false;
}

//Eliminar sesión del administrador
function exitSessionAdministrador()
{
    session_start();
    unset($_SESSION['administrador']);
    redirigir('administrador/login');
}

//Subir archivos
function subirArchivo($archivo)
{
    $destino = config('root') . 'uploads/';
    $nombre = date('Y-m-d-H-i-s-') . $archivo['name'];
    if (move_uploaded_file($archivo['tmp_name'], $destino . $nombre)) {
        return $nombre;
    } else {
        return null;
    }
}

