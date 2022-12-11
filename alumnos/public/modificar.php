<?php session_start() ?>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="../css/output.css" rel="stylesheet">
  <title>Modificar</title>
</head>

<body>
  <?php
  require '../vendor/autoload.php';
  
  $pdo = conectar();
  
  $id = obtener_get('id');
  $nombrem = obtener_get('nombrem');
  $nombre = obtener_post('nombre');
  
  if ($nombre == $nombrem) {
    $_SESSION['error'] = 'El usuario no se puede modificar si es el mismo.';   
  }
  
  if (isset($nombre) && $nombre != '' && $nombre != $nombrem) {
    \App\Tablas\Alumno::modificar($id, $nombre, $pdo);
    $_SESSION['exito'] = 'El usuario se ha modificado correctamente.';
    return volver();
  }
  
  require '../src/_alerts.php';
  ?>


  <form class="mt-5 mr-96 ml-96" action="" method="POST">
    <div class="mb-6">
      <label for="departamento" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Nombre Alumno</label>
      <input value="<?= hh($nombrem) ?>" type="text" id="nombre" name="nombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required="">
    </div>


    <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">modificar</button>
  </form>

  <script src="../js/flowbite/flowbite.js"></script>

</body>

</html> 