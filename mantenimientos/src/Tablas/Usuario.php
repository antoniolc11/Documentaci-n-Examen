<?php

namespace App\Tablas;

use PDO;

class Usuario extends Modelo
{
    protected static string $tabla = 'usuarios';

    public $id_oper;
    public $nombre;
    public $apellido1;
    public $apellido2;
    public $dni;
    public $telefono;
    public $usuario;

    public function __construct(array $campos)
    {
        $this->tabla = 'usuarios';
        $this->id_oper = $campos['id_oper'];
        $this->nombre = $campos['nombre'];
        $this->apellido1 = $campos['apellido1'];
        $this->apellido2 = $campos['apellido2'];
        $this->dni = $campos['dni'];
        $this->telefono = $campos['telefono'];
        $this->usuario = $campos['usuario'];
    }

    public function es_admin(): bool
    {
        return $this->usuario == 'admin';
    }

    public static function esta_logueado(): bool
    {
        return isset($_SESSION['login']);
    }

    public static function logueado(): ?static
    {
        return isset($_SESSION['login']) ? unserialize($_SESSION['login']) : null;
    }

    public static function comprobar($login, $password, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();

        $sent = $pdo->prepare('SELECT *
                                 FROM operario
                                WHERE usuario = :login');
        $sent->execute([':login' => $login]);
        $fila = $sent->fetch(PDO::FETCH_ASSOC);

        if ($fila === false) {
            return false;
        }

        return password_verify($password, $fila['password']) ? new static($fila) : false;
    }
}