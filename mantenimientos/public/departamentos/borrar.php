<?php
session_start();
require '../../src/auxiliar2.php';

$cod_depart = obtener_post('cod_depart');


if (!isset($cod_depart)) {
    return volver_admin();
}

// TODO: Validar id

$pdo = conectar();

$sent = $pdo->prepare("SELECT count(cod_depart) 
                       FROM departamento
                       WHERE cod_depart = :cod_depart");
$sent->execute([':cod_depart' => $cod_depart]);
$existe = $sent->fetchColumn();
if ($existe != 1) {
    $_SESSION['error'] = 'No existe el departamento.';
    return volver_admin();
}

$sent = $pdo->prepare("SELECT count(*) 
                       FROM departamento JOIN oper_depart USING(cod_depart)
                       WHERE cod_depart = :cod_depart");
$sent->execute([':cod_depart' => $cod_depart]);

$tiene_empleados = $sent->fetchColumn();
if ($tiene_empleados != 0) {
    $_SESSION['error'] = 'No se puede borrar el departamento por que aún tiene trabajadores dentro.';
    return volver_admin();
}


$sent = $pdo->prepare("DELETE FROM departamento WHERE cod_depart = :cod_depart");
$sent->execute([':cod_depart' => $cod_depart]);

$_SESSION['exito'] = 'El artículo se ha borrado correctamente.';

volver_admin();