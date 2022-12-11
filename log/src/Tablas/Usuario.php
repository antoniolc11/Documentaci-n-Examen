<?php
namespace App\Tablas;

use PDO;

class Usuario extends Modelo
{
    protected static string $tabla = 'usuarios';

    public $id;
    public $usuario;

    public function __construct(array $campos)
    {
        $this->id = $campos['id'];
        $this->usuario = $campos['usuario'];
    }

    public function getUsuario()
    {
        return $this->usuario;
    }

    
    public static function esta_logueado(): bool
    {
        return isset($_SESSION['login']);
    }
    
    public static function logueado(): ?static
    {
        return isset($_SESSION['login']) ? unserialize($_SESSION['login']) : null;
    }
    
    public static function comprobar($usuario, $password, ?PDO $pdo = null)
    {
        $pdo = $pdo ?? conectar();
        
        $sent = $pdo->prepare('SELECT *
                                 FROM usuarios
                                WHERE usuario = :usuario');
        $sent->execute([':usuario' => $usuario]);
        $fila = $sent->fetch(PDO::FETCH_ASSOC);
        
        if ($fila === false) {
            return false;
        }
        
        return password_verify($password, $fila['password']) ? new static($fila) : false;
    }
    
    
    public static function registrar($login, $password, ?PDO $pdo = null)
    {
        $sent = $pdo->prepare('INSERT INTO usuarios (usuario, password)
                               VALUES (:login, :password)');
        $sent->execute([
            ':login' => $login,
            ':password' => password_hash($password, PASSWORD_DEFAULT),
        ]);
    }
    
    
    public static function existe($login, ?PDO $pdo = null): bool
    {
        return $login == '' ? false : !empty(static::obtener_todos(['usuario = :usuario'], [':usuario' => $login], $pdo));
    }
    /*     public function es_admin(): bool
    {
        return $this->usuario == 'admin';
    } */
}