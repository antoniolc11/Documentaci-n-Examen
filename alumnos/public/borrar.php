<?php
require '../vendor/autoload.php';
use App\Tablas\Alumno;


session_start();

$id = obtener_post('id');


if (!isset($id)) {
    return volver();
}

$pdo = conectar();

$sent = $pdo->prepare("SELECT count(id) 
                       FROM alumnos
                       WHERE id = :id");
$sent->execute([':id' => $id]);
$existe = $sent->fetchColumn();
if ($existe != 1) {
    $_SESSION['error'] = 'No existe el alumno.';
    return volver();
}


$sent = $pdo->prepare("SELECT count(*) 
                       FROM alumnos JOIN notas ON (alumnos.id = notas.alumno_id)
                       WHERE alumnos.id = :id");
$sent->execute([':id' => $id]);

$tiene_empleados = $sent->fetchColumn();
if ($tiene_empleados != 0) {
    $_SESSION['error'] = 'No se puede borrar el alumnos por que aún tiene notas actualmente.';
    return volver();
}

Alumno::borrar($id);
$_SESSION['exito'] = 'El alumno se a borrado correctamente.';

volver();