SELECT a.titulo, a.num_paginas
FROM articulos_monografias am JOIN articulos a ON (am.articulo_id = a.id)
WHERE monografia_id = 2


SELECT am.*, sum(a.num_paginas)
FROM articulos_monografias am JOIN articulos a ON (am.articulo_id = a.id)
WHERE monografia_id = 2
GROUP BY am.articulo_id, am.monografia_id;

SELECT m.titulo, sum(a.num_paginas)
FROM monografias m JOIN articulos_monografias am ON (m.id = am.monografia_id)
		   JOIN articulos a ON (am.articulo_id = a.id)
WHERE m.id = 1
GROUP BY m.id;

Crear la ruta GET monografias/{monografia}/autores, que muestre el título de la monografía indicada y el nombre de todos los autores que han participado en esa monografía.

SELECT DISTINCT m.titulo, autores.nombre
FROM monografias m JOIN articulos_monografias am ON (m.id = am.monografia_id)
		   JOIN articulos a ON (am.articulo_id = a.id)
		   JOIN articulos_autores au ON (a.id = au.articulo_id)
		   JOIN autores ON (autores.id = au.articulo_id)
WHERE m.id = 1;

En la ruta GET articulos, mostrar una columna con el número de autores que tiene
cada artículo y otra con el número de monografías en las que aparece cada artículo.

SELECT a.titulo, COUNT(au.autor_id) autores
FROM articulos_autores au JOIN articulos a ON (au.articulo_id = a.id)
GROUP BY au.articulo_id, a.titulo;


SELECT a.titulo, COUNT(am.monografia_id)
FROM articulos_monografias am JOIN articulos a ON (am.articulo_id = a.id)
GROUP BY am.articulo_id, a.titulo;


SELECT a.titulo, COUNT(au.autor_id) autores, COUNT(am.monografia_id) monografias
FROM articulos_autores au JOIN articulos a ON (au.articulo_id = a.id)
			  JOIN articulos_monografias am ON (am.articulo_id = a.id)
			  JOIN monografias ON (monografias.id = am.monografia_id)
GROUP BY au.articulo_id, a.titulo;

 En la vista albumes/view/id, mostrar también los temas que componen cada álbum,
indicando además (en el DetailView del álbum) la duración total del álbum, calculado como la
suma de las duraciones de todos sus temas. Indicación: la suma la tiene que hacer el SGBD, no el
PHP.

SELECT titulo
FROM albunes_temas at JOIN temas t ON at.tema_id = t.id
WHERE at.albun_id = 1

UNION

SELECT CAST(sum(duracion) AS varchar)
FROM albunes_temas at JOIN temas t ON at.tema_id = t.id
WHERE at.albun_id = 1; 



SELECT titulo, (SELECT CAST(sum(duracion) AS varchar)
		FROM albunes_temas at JOIN temas t ON at.tema_id = t.id
		WHERE at.albun_id = 1) TOTAL
FROM albunes_temas at JOIN temas t ON at.tema_id = t.id
WHERE at.albun_id = 1;

En la vista temas/index, mostrar una columna con el número de artistas que tiene
cada tema y otra con el número de álbumes en los que aparece cada tema, permitiendo filtrar y
ordenar por dichas columnas.

SELECT t.titulo, count(*) Num_Autores
FROM artistas_temas at JOIN temas t ON at.tema_id = t.id 
GROUP BY t.titulo, tema_id;

SELECT t.titulo, count(*) Albunes
FROM albunes_temas at JOIN temas t ON at.tema_id = t.id 
GROUP BY t.titulo, tema_id;

SELECT t.titulo, count(t.*) Num_Autores, count(albunes_temas.*) Albunes
FROM artistas_temas at left JOIN temas t ON at.tema_id = t.id 
		       right JOIN albunes_temas ON  albunes_temas.tema_id = t.id 
GROUP BY t.titulo, albunes_temas.tema_id;


Crear la vista artistas/albumes/id, que muestre el nombre del artista identificado
por su id y el nombre de todos los álbumes en los que ha participado ese artista.

SELECT a.nombre, albunes.titulo Albunes
FROM artistas_temas at JOIN artistas a ON at.tema_id = a.id
		       JOIN albunes_temas ON albunes_temas.tema_id = at.tema_id
		       JOIN albunes ON albunes.id = albunes_temas.albun_id
WHERE a.id = 2
GROUP BY albunes.titulo, a.nombre;













