
--1. Crea el esquema de la BBDD.
	La BBDD ya se encuentra generada, se visualiza en:
	ProyectoSQL - Esquemas - public (botón derecho) - View Diagram
	
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de R.

SELECT "title" AS "pelicula", "rating"
FROM "film"
WHERE "rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT "actor_id" , "first_name" , "last_name"
FROM "actor"a 
WHERE "actor_id" BETWEEN 30 AND 40; 

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT f."title", l."name"
FROM "film" f 
INNER JOIN "language" l 
ON f."language_id" = l."language_id"
WHERE f."language_id" = f."original_language_id" ;

-- 5. Ordena las películas por duración de forma ascendente.

SELECT "title" AS "pelicula", "length" AS "duracion"
FROM "film" f 
ORDER BY  "length"  ASC ;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT "first_name" , "last_name"
FROM "actor" a 
WHERE "last_name" ILIKE '%Allen%' ;

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
	  “film” y muestra la clasificación junto con el recuento. */

SELECT "rating", 
		COUNT ("rating") AS "Cantidad_Total_peliculas"
FROM "film"  f 
GROUP BY "rating" ;

/* 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
	  duración mayor a 3 horas en la tabla film. */

SELECT "title" AS "pelicula", "rating" , "length" AS "duración"
FROM "film" f
WHERE "rating" = 'PG-13'OR "length" > 180 ;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT ROUND (STDDEV ("replacement_cost"), 2) AS "Variabilidad" -- Entiendo variabilidad como desviación estándar.
FROM "film" f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT 
	MAX ("length") AS "Mayor_duracion", 
	MIN ("length") AS "Menor_duracion"
FROM "film" f ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT "amount" AS "coste" ,
	   "payment_date" 
FROM "payment" p 
ORDER BY "payment_date" DESC 
LIMIT 1
OFFSET 2;

/* 12. Encuentra el título de las películas en la tabla “film” que no sean ni 
       ‘NC-17’ ni ‘G’ en cuanto a su clasificación. */

SELECT "title" AS "pelicula", "rating"
FROM "film" f 
WHERE "rating" NOT IN ('NC-17', 'G') ;
	
/* 13. Encuentra el promedio de duración de las películas para cada
	   clasificación de la tabla film y muestra la clasificación junto con el
	   promedio de duración. */

SELECT "rating", 
	    ROUND (AVG ("length"), 0) AS "Promedio_duracion"
FROM "film" f 
GROUP BY "rating" ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT "title" AS "pelicula", "length" AS "duracion"
FROM "film" f 
WHERE "length" > 180 ;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM ("amount") AS "Ingreso_Total"
FROM "payment" p ;

-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT "customer_id"
FROM "customer" c 
ORDER BY "customer_id" DESC 
LIMIT 10 ;

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’. */

SELECT f."title" AS "pelicula", a."first_name" , a."last_name" 
FROM "film" f 
INNER JOIN "film_actor" fa 
ON f."film_id" = fa."film_id"
INNER JOIN "actor" a 
ON fa."actor_id" = a."actor_id"
WHERE f."title" ILIKE 'Egg Igby';

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT	"title" AS "Nombre_pelicula_unicos"
FROM "film" f ;

/* 19. Encuentra el título de las películas que son comedias y tienen una
       duración mayor a 180 minutos en la tabla “film”. */

SELECT f."title" AS "pelicula", c."name" , f."length" AS "duracion"
FROM "film" f 
INNER JOIN "film_category"fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Comedy'
	AND f."length" > 180 ; 

/* 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración. */

SELECT c."name" AS "categoria", 
		ROUND (AVG (f."length"), 0) AS "Promedio_duracion"
FROM "film" f 
INNER JOIN "film_category"fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" c 
ON fc."category_id" = c."category_id"
GROUP BY c."name" 
HAVING AVG (f."length") > 110 ;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT ROUND (AVG ("rental_duration" ), 0) AS "promedio_alquiler"
FROM "film" f ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT ("first_name", ' ', "last_name") AS "Nombre_Completo"
FROM "actor" a ;

/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de
	   forma descendente. */

SELECT COUNT("rental_date") AS "Numeros_alquiler",
	   DATE ("rental_date" ) AS "dia_alquiler"
FROM "rental" r 
GROUP BY DATE ("rental_date" )
ORDER BY "Numeros_alquiler" DESC ;

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT "title" AS "pelicula" , 
	   "length" AS "duracion"
FROM "film" f 
WHERE "length" >
		(SELECT AVG ("length")
		FROM "film" );

-- 25. Averigua el número de alquileres registrados por mes.

SELECT DATE_TRUNC ('month', "rental_date") AS "Mes_alquiler", 
       COUNT(*) AS "Total_alquiler"
FROM "rental" r 
GROUP BY  "Mes_alquiler"
ORDER BY  "Mes_alquiler" ;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT ROUND (AVG ("amount"), 2) AS "Promedio",
		ROUND (STDDEV ("amount"), 2) AS "Desviacion_del_Total",
		ROUND (VARIANCE ("amount"), 2) AS "Varianza"
FROM "payment" p ;

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT "title" AS "pelicula",
	   "rental_rate" AS "promedio_alquiler"
FROM "film" f 
WHERE "rental_rate" > (
						SELECT AVG ("rental_rate")
						FROM "film" );

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
					
SELECT "actor_id" , 
		COUNT ("film_id") AS "Total_peliculas"
FROM "film_actor" fa 
GROUP BY "actor_id"
HAVING COUNT ("film_id")> 40;  			
	  			
-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f."title" AS "pelicula" ,
		COUNT (i."inventory_id") AS "Inventario_disponible"
FROM "film" f 
LEFT JOIN "inventory" i 
ON f."film_id" = i."film_id"
WHERE i."inventory_id" NOT IN (
   							 SELECT r."inventory_id"
    						 FROM "rental" r
    						 WHERE r."return_date" IS NULL
)
GROUP BY f."title" 
ORDER BY "Inventario_disponible" DESC ;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT CONCAT (a."first_name", ' ', a."last_name") AS "Actor-Actriz",
		COUNT (fa."film_id") AS "Numero_peliculas"
FROM "actor" a 
INNER JOIN "film_actor" fa 
ON a."actor_id" = fa."actor_id"
GROUP BY "Actor-Actriz" ;

/* 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados. */

SELECT f."title" AS "pelicula",	
	   CONCAT (a."first_name", ' ', a."last_name") AS "Actor-Actriz"
FROM "film" f 
LEFT JOIN	"film_actor" fa 
ON f."film_id" = fa."film_id" 
LEFT JOIN "actor" a 
ON fa."actor_id" = a."actor_id" ;

/* 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película. */

SELECT CONCAT (a."first_name" , ' ', a."last_name" ) AS "Actor-Actriz",
	   f."title" AS "pelicula"   
FROM "actor" a 
LEFT JOIN "film_actor" fa 
ON a."actor_id" = fa."actor_id"
LEFT JOIN "film" f 
ON fa."film_id" = f."film_id" ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f."title" AS "Peliculas",
		r."rental_id" AS "Alquiler_registro"
FROM "film" f 
FULL JOIN "inventory" i 
ON f."film_id" = i.film_id 
FULL JOIN "rental" r 
ON i."inventory_id" = r."inventory_id" ;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT CONCAT (c."first_name", ' ', c."last_name") AS "Cliente",
	  SUM (p."amount") AS "Total_gastado"   
FROM "customer" c 
INNER JOIN "payment" p 
ON c."customer_id" = p."customer_id" 
GROUP BY c."first_name", c."last_name"
ORDER BY "Total_gastado" DESC 
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT a."first_name" AS "Nombre" , 
	   a."last_name" AS "Apellido"
FROM "actor" a 
WHERE first_name ILIKE 'Johnny';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

SELECT "first_name" AS "Nombre",
		"last_name"  AS "Apellido"
FROM "customer" c ;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN ("actor_id") AS Id_actor_min, 
	   MAX ("actor_id") AS Id_actor_max
FROM "actor" a ;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.

SELECT COUNT ("actor_id") AS "Numero_Actores"
FROM "actor" a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT "last_name" AS "Apellido"
FROM "actor" a 
ORDER BY "Apellido" ASC ;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT "title" AS "pelicula"
FROM "film" f 
LIMIT 5 ;

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido? */

SELECT "first_name" AS "Nombre",
	    COUNT ("first_name") AS "No.veces_repetido"
FROM "actor" a 
GROUP BY "first_name"
ORDER BY COUNT ("first_name") DESC ;
-- Los nombres más repetidos son Kenneth, Penelope y Julia, 4 veces cada uno.

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r."rental_id" AS "Alquiler",
	   c."first_name"  AS "Nombre", 
	   c."last_name" AS "Apellido"
FROM "rental" r 
INNER JOIN "customer" c 
ON r."customer_id"  = c."customer_id" ;

/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres. */

SELECT c."first_name" AS "Nombre",
	   c."last_name" AS "Apellido",
	   r."rental_id" AS "Alquiler"
FROM "customer" c 
LEFT JOIN "rental" r 
ON c."customer_id" = r."customer_id" ; 

/* 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación. */

SELECT f."title" AS "Pelicula",
	   c."name" AS "Categoria"
FROM "film" f 
CROSS JOIN "category" c ;
/* Los cross join no se suelen usar para relaciones entre datos, en este caso, no hay condiciones lógicas para unir las tablas,
 * por lo tanto se desprende que esta consulta carece de valor. */

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

 SELECT a."first_name" AS "Nombre",
 		a."last_name"  AS "Apellido",
 		c."name" AS "categoria"
 FROM "actor" a 
 INNER JOIN "film_actor" fa 
 ON a."actor_id" = fa."actor_id"
 INNER JOIN "film" f
 ON fa."film_id" = f."film_id"
 INNER JOIN "film_category" fc 
 ON f."film_id" = fc."film_id" 
 INNER JOIN "category" c 
 ON fc."category_id" = c."category_id" 
 WHERE c."name" = 'Action' ;

-- 46. Encuentra todos los actores que no han participado en películas.

SELECT a."first_name" AS "Nombre" ,
		a."last_name" AS "Apellido" ,
		fa."film_id"
FROM "actor" a 
LEFT JOIN	"film_actor" fa 
ON a."actor_id" = fa."actor_id" 
WHERE fa."film_id" IS NULL ;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT a."first_name" AS "Nombre" ,
		a."last_name" AS "Apellido" ,
		COUNT (fa."film_id") AS "Cantidad_peliculas"
FROM "actor" a 
LEFT JOIN "film_actor" fa 
ON a."actor_id" = fa."actor_id" 
GROUP BY "Nombre", "Apellido" ;

/* 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado. */

CREATE VIEW actor_num_peliculas AS
SELECT a."first_name" AS "Nombre" ,
		a."last_name" AS "Apellido" ,
		COUNT (fa."film_id") AS "Cantidad_peliculas"
FROM "actor" a 
LEFT JOIN "film_actor" fa 
ON a."actor_id" = fa."actor_id" 
GROUP BY "Nombre", "Apellido" ;

SELECT *
FROM actor_num_peliculas anp ; -- Verificación de la vista generada.

-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT c."first_name" AS "Nombre",
	   c."last_name" AS "Apellido",
	   COUNT (r."rental_id") AS "Total_alquileres"
FROM "rental"r 
INNER JOIN "customer" c 
ON r."customer_id" = c."customer_id" 
GROUP BY "Nombre", "Apellido" , c."customer_id";

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT c."name" AS "Categoria",
	    SUM (f."length") AS "Duracion_total"
FROM "film" f 
INNER JOIN "film_category" fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Action'
GROUP BY c."name" ;

/* 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente. */

CREATE TEMP	TABLE	cliente_rentas_temporal AS	
SELECT c."first_name" AS "Nombre",
	   c."last_name" AS "Apellido",
	   COUNT (r."rental_id") AS "Total_alquileres"
FROM "rental"r 
INNER JOIN "customer" c 
ON r."customer_id" = c."customer_id" 
GROUP BY "Nombre", "Apellido" , c."customer_id";

SELECT *
FROM cliente_rentas_temporal  -- Verificacion de la tabla temporal creada.

/* 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces. */

CREATE TEMP	TABLE peliculas_alquiladas AS
SELECT f."title" AS "pelicula",
	   COUNT (r."rental_id") AS "Total_alquileres"
FROM "rental"r 
INNER JOIN "inventory" i 
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" f 
ON i."film_id" = f."film_id"
GROUP BY f."title" 
HAVING COUNT (r."rental_id") >= 10
ORDER BY "Total_alquileres" ;

SELECT *
FROM peliculas_alquiladas  -- Verificacion de la tabla temporal creada.

/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película. */

SELECT f."title" AS "Pelicula_no_devuelta",
		CONCAT (c."first_name", ' ', c."last_name") as "Cliente"
FROM "customer" c 
INNER JOIN "rental" r 
ON c."customer_id" = r."customer_id"
INNER JOIN "inventory" i 
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" f 
ON i."film_id" = f."film_id" 
WHERE r."return_date" IS NULL 
GROUP BY f."title" , c."first_name" , c."last_name"
HAVING CONCAT (c."first_name", ' ', c."last_name")ILIKE 'Tammy Sanders'
ORDER BY f."title"  ; 

/* 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido. */

SELECT DISTINCT a."first_name" AS "Nombre",
				a."last_name" AS "Apellido"	
FROM "actor" a 
INNER JOIN "film_actor" fa 
ON a."actor_id"  = fa."actor_id"
INNER JOIN "film" f 
ON fa."film_id" =f."film_id"
INNER JOIN "film_category" fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi' 
ORDER BY a."last_name" ;

/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron 
       después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados
       alfabéticamente por apellido. */

SELECT DISTINCT a."first_name" AS "Nombre",
				a."last_name" AS "Apellido"
FROM "actor" a
INNER JOIN "film_actor" fa 
ON a."actor_id" = fa."actor_id"
INNER JOIN "film" f
ON fa."film_id" = f."film_id"
INNER JOIN "inventory" i
ON f."film_id" = i."film_id"
INNER JOIN "rental" r 
ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
							SELECT  MIN(r."rental_date") AS "Fecha_alquiler_inicial"
							FROM "rental" r 
							INNER JOIN "inventory" i 
							ON r."inventory_id" = i."inventory_id"
							INNER JOIN "film" f 
							ON i."film_id" = f."film_id"
							WHERE f."title" ILIKE 'Spartacus Cheaper'
						) 
ORDER BY a."last_name"  ; 

/* 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’. */

SELECT CONCAT (a."first_name", ' ', a."last_name") AS "Actor-Actriz"
FROM "actor" a 
WHERE NOT EXISTS (
					SELECT 1
					FROM "film_actor" fa 
					INNER JOIN "film" f 
					ON fa."film_id" =f."film_id"
					INNER JOIN "film_category" fc 
					ON f."film_id" = fc."film_id"
					INNER JOIN "category" c 
					ON fc."category_id" = c."category_id"
					WHERE  fa."actor_id" = a."actor_id" AND c."name" = 'Music' 
				  ) ;
				 
-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT "title" AS "pelicula", 
	   "rental_duration" AS "dias_alquiler"
FROM "film" f 
WHERE "rental_duration" > 8 ;
 
--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

SELECT f."title" AS "Pelicula"
FROM "film" f 
INNER JOIN "film_category" fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id"
WHERE c."name" = 'Animation' ;

/* 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título
       ‘Dancing Fever’. Ordena los resultado alfabéticamente por título de película. */

SELECT f."title" AS "Pelicula"
FROM "film" f 
WHERE f."length" = (
					SELECT f1."length" AS "Duracion_pelicula"
					FROM "film" f1 
					WHERE f1."title" ILIKE 'Dancing Fever'
				)
ORDER BY f."title" ;

/*  60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido. */

SELECT c."first_name" AS "Nombre",
		c."last_name" AS "Apellido",
		COUNT (DISTINCT i."film_id") AS "Numero_peliculas"
FROM "customer" c 
INNER JOIN "rental" r 
ON c."customer_id" = r."customer_id" 
INNER JOIN "inventory" i 
ON r."inventory_id" = i."inventory_id" 
GROUP BY c."first_name" , c."last_name" 
HAVING COUNT (DISTINCT i."film_id") > 6
ORDER BY c."last_name" ;
     
/* 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres. */

SELECT c."name" AS "Categoria",
       COUNT(r."rental_id") AS "Total_Alquileres"
FROM "rental" r
INNER JOIN "inventory" i 
ON r."inventory_id" = i."inventory_id"
INNER JOIN "film" f 
ON i."film_id" = f."film_id"
INNER JOIN "film_category" fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id"
GROUP BY c."name" ;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT COUNT(c."category_id") AS "Peliculas_estrenadas" ,
		c."name" AS "Categoria"
FROM film f 
INNER JOIN "film_category" fc 
ON f."film_id" = fc."film_id"
INNER JOIN "category" c 
ON fc."category_id" = c."category_id"
WHERE f."release_year" = 2006
GROUP BY c."name" ;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT CONCAT (s."first_name", ' ', s."last_name") AS "Trabajador",
		s2."store_id" AS "Tienda" 
FROM "staff" s 
CROSS JOIN "store" s2 ;

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT c."customer_id" AS "ID_cliente",
       c."first_name" AS "Nombre", 
       c."last_name" AS "Apellido",
       COUNT(r."rental_id") AS "Total_peliculas_alquiladas"
FROM "customer" c
LEFT JOIN "rental" r 
ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name" ;












