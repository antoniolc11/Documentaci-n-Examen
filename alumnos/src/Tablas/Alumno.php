<?php

namespace App\Tablas;

use PDO;

class Alumno
{
    public $id;
    public $nombre;

    public function __construct(array $campos)
    {
        $this->id = $campos['id'];
        $this->nombre = $campos['nombre'];
    }

    public static function insertar($nombre, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare('INSERT INTO alumnos (nombre)
                                    VALUES (:nombre)');
        $sent->execute([':nombre' => $nombre]);
    }

    public static function modificar($id, $nombre, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare("UPDATE alumnos 
                                  SET nombre= :nombre
                                WHERE id = :id");
        $sent->execute([':id' => $id, ':nombre' => $nombre]);
    }

    public static function borrar($id, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare("DELETE FROM alumnos
                                     WHERE id = :id");
        $sent->execute([':id' => $id]);
    }

}
