<?php session_start() ?>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="../css/output.css" rel="stylesheet">
  <title>Document</title>
</head>

<body>
  <?php
  require '../../src/auxiliar2.php';

  $departamento = obtener_post('departamento');
 
  $clases_label = '';
  $clases_input = '';
  $error = false;

    if (isset($departamento) && $departamento != '') {
      if (!App\Tablas\Departamento::comprobar($departamento)) {
        //insertar departamento
        //$departamento::insertar($usuario);
        \App\Tablas\Departamento::insertar($departamento);
        return volver_admin();
    } else {
      $_SESSION['error'] = 'El departamento ya existe.';
      $error = true;
      $clases_label = "text-red-700 dark:text-red-500";
      $clases_input = "bg-red-50 border-red-500 text-red-900 placeholder-red-700 focus:ring-red-500 focus:border-red-500 dark:bg-red-100 dark:border-red-400";
      return volver_admin();
    }
    }  


 /*  print_r('existe el $departamento');
   */

  ?>


  <form class="mt-5 mr-96 ml-96" action="" method="POST">
    <div class="mb-6">
      <label for="departamento" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Departamento</label>
      <input type="text" id="departamento" name="departamento" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required="">
    </div>


    <button type="submit" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Registrar</button>
  </form>

  <script src="../js/flowbite/flowbite.js"></script>

</body>

</html>