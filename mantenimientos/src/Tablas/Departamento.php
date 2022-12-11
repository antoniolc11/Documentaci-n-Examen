<?php

namespace App\Tablas;

use PDO;

class Departamento
{
    protected static string $tabla = 'departamento';

    public $cod_depart;
    public $nom_depart;

    public function __construct(array $campos)
    {
        $this->cod_depart = $campos['cod_depart'];
        $this->nom_depart = $campos['nom_depart'];
    }

    public static function insertar($nombre, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare('INSERT INTO departamento (nom_depart)
                                    VALUES (:nombre)');
        $sent->execute([':nombre' => $nombre]);
    }

    public static function comprobar($departamento, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare('SELECT *
                                 FROM departamento
                                WHERE nom_depart = :departamento');
        $sent->execute([':departamento' => $departamento]);
        $fila = $sent->fetch(PDO::FETCH_ASSOC);

        if ($fila === false) {
            return false;
        }
        
        return $fila['nom_depart'] ? new static($fila) : false;
    }
}