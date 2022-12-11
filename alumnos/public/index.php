<?php session_start() ?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/output.css" rel="stylesheet">
    <title>Document</title>
</head>

<body>
    <?php

    require '../vendor/autoload.php';
    require '../src/_alerts.php';


    $pdo = conectar();
    $sent = $pdo->query("SELECT * FROM alumnos");


    ?>


    <form action="" method="GET">
        <label for="buscar">
            nombre:
            <input type="text" id="keywords" name="buscar" size="30" maxlength="30">
        </label>
        <button type="submit" name="searh">Buscar</button>
    </form>

    <?php

//Si se ha pulsado el botón de buscar

if (isset($_GET['searh'])) {
    //Recogemos las claves enviadas
    $nombre = $_GET['buscar'];

    //Conectamos con la base de datos en la que vamos a buscar
    $pdo = conectar();

    $sent = $pdo->prepare("SELECT * FROM alumnos WHERE lower(nombre) LIKE lower(:nombre)");

    $sent->execute([':nombre' => "$nombre%"]);
}
    ?>

    <div class="overflow-x-auto relative mt-4 ">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <th scope="col" class="py-3 px-6">Nombre</th>
                <th scope="col" class="py-3 px-6">Fecha de nacimiento</th>
                <th scope="col" class="py-3 px-6">Saldo</th>
                <th scope="col" class="py-3 px-6 text-center">Acciones</th>
            </thead>
            <tbody>
                <?php foreach ($sent as $fila) : ?>
                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                        <td class="py-4 px-6"><?= hh($fila['nombre']) ?></td>
                        <td class="py-4 px-6"><?= hh(mostrar_fecha($fila['fecha_nac'])) ?></td>
                        <td class="py-4 px-6"><?= hh(dinero($fila['saldo'])) ?></td>

                        <td class="py-4 px-6 text-center">
                            <a href="modificar.php?id=<?= $fila['id'] ?>&nombrem=<?= $fila['nombre'] ?>" class="focus:outline-none text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-900">Editar</a>
                            <form action="borrar.php" method="POST" class="inline">
                                <input type="hidden" name="id" value="<?= hh($fila['id']) ?>">
                                <button type="submit" class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900">Borrar</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach ?>

                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td></td>
                    <td class="py-4 px-6 text-center">
                        <a href="añadir.php" class="focus:outline-none text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">Añadir alumno</a>
                </tr>
            </tbody>
        </table>
    </div>

    <script src="/js/flowbite/flowbite.js"></script>

</body>

</html>