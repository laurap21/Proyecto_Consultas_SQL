/* 
 * A continuación se irán realizando las distintas consultas solicitadas para el proyecto de SQL
 * del curso Data Analytics V3
 */

/* 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ:
 * La clasificación por edades de las películas se encuentra en la columna 'rating' de la tabla 'film'.
 * En la consulta se ha incluido el nombre de la película por claridad.
 */

SELECT f.title , f.rating 
FROM film f 
WHERE f.rating = 'R'; 


/* 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40:
 * El nombre y el id de los actores se encuentran en la tabla 'actor'.
 * Para mayor comprensión, se concatenan nombre y apellido de los actores con la función "CONCAT".
 * Por tanto, se ha de utilizar la función HAVING ya que se tiene una función de agregación previa.
*/

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Full_Name", a.actor_id 
FROM actor a 
WHERE a.actor_id > 30 AND a.actor_id < 40 ;


/* 4. Obtén las películas cuyo idioma coincide con el idioma original:
 * En la tabla 'film' se recogen tanto el idioma de la película ('language_id') como el idioma original ('original_language_id').
 * En la consulta se solicita el nombre de las películas cuyo 'laguange_id' coincida con 'original_language_id'. 
 * La consulta no devuelve ningún resultado, pues en la tabla original de datos se ve que la columna 'original_language_id' solo tiene valores NULL
*/

SELECT f.title , f.language_id , f.original_language_id 
FROM film f 
WHERE f.language_id = f.original_language_id ;


/* 5. Ordena las películas por duración de forma ascendente:
 * La duración de las películas se mide en la columna 'length'.
 * En la consulta se muestra el título de la película y su duración.
 */

SELECT f.title , f.length 
FROM film f 
ORDER BY f.length ASC ;


/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
* Los datos de los actores se encuentran recogidos en la tabla 'actor'.
* En la base de datos, los nombres y apellidos de los actores vienen en mayúsculas,
* por lo que para hacer correctamente la consulta se deberá incluir la palabra 'ALLEN' en mayúsculas también.
*/

SELECT a.first_name , a.last_name 
FROM actor a 
WHERE a.last_name LIKE '%ALLEN%';


/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento:
 * La clasificación de cada películas se recoge en la columna 'rating'. 
 * Se utiliza la función COUNT para contar el total de películas de cada categoría y se agrupan por estas mismas para mostrarlo.
 */

SELECT f.rating , COUNT(f.rating) AS "Total_films_per_category"
FROM film f
GROUP BY f.rating ;


/* 8.Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film:
 * En la consulta se muestra el título, la clasificación y la duración de las películas.
 * Se aplica el filtro solicitado en el WHERE, donde la clasificación debe ser igual a 'PG-13) o
 * la duración debe ser mayor que 180 (ya que tres horas corresponden a 180 minutos).
 */

SELECT f.title, f.rating , f.length 
FROM film f 
WHERE f.rating = 'PG-13' OR f.length > 180;


/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 * Para hallar la variablidad de lo que costaría reemplazar las películas se van a calcular los siguientes valores:
 * Mmáximo, mínimo, promedio, varianza y desviación estándar, redondeando estos dos últimos valores a 2 decimales.
 */

SELECT 
	MAX(f.replacement_cost) AS "Coste_maximo",
	MIN(f.replacement_cost) AS "Coste_minimo",
	AVG(f.replacement_cost) AS "Coste_promedio",
	ROUND(VARIANCE(f.replacement_cost),2) AS "Varianza",
	ROUND(STDDEV(f.replacement_cost),2) AS "Desviacion_estandar"
FROM film f ;

/* 10.  Encuentra la mayor y menor duración de una película de nuestra BBDD:
 * Para averiguar las duraciones máxima y mínima de las películas se utilizan las funciones de agregación MAX y MIN
 */

SELECT
	MAX(f.length) AS "Mayor_duracion",
	MIN(f.length) AS "Menor_duracion"
FROM film f ;


/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día:
 * La fecha de alquiler de las películas se encuentra en la tabla 'rental'. 
 * En la consulta se muestra el id y la fecha, ordenados descendente, es decir, de más nuevo a más antiguo. 
 * Se ha añadido además un LIMIT 1 para mostrar un solo resultado y un OFFSET 2 para no mostrar el último y penúltimo resutlados.
 */

SELECT r.rental_id, r.rental_date, p.amount, p.payment_date  
FROM rental r
INNER JOIN payment p ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC 
LIMIT 1 OFFSET 2 ;

-- Versión mejorada: 
SELECT r.rental_id, r.rental_date
FROM rental r
ORDER BY r.rental_date DESC
LIMIT 1 OFFSET 2;


/* 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación:
 * Añadiendo un NOT IN en el WHERE, se muestran todas las películas que no están clasificadas como 'NC-17' ni 'G'.
 */

SELECT f.title, f.rating 
FROM film f 
WHERE f.rating NOT IN ('NC-17', 'G') ;


/* 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación
 * junto con el promedio de duración:
 * Se seleccionan de la tabla 'film' las distintas clasificaciones y se hace el promedio con la función de agregación AVG (con su
 * correspondiente alias). Para mostrarlo, se agrupan con la función GROUP BY.
 */

SELECT f.rating, ROUND(AVG(f.length),2) AS "Average_length"
FROM film f 
GROUP BY f.rating ;


/* 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
 * Se aplica el filtro en el WHERE para obtener una duración mayor a 180 minutos.
 */

SELECT f.title , f.length 
FROM film f 
WHERE f.length > 180 ;


/* 15. ¿Cuánto dinero ha generado en total la empresa?
 * El dinero total generado se obtiene haciendo una suma de 'amount' de la tabla 'payment'
 */

SELECT SUM(p.amount) AS "Total_income"
FROM payment p ;


/* 16. Muestra los 10 clientes con mayor valor de id.
 * Para mayor entendimiento, se concatenan nombre y apellido de los clientes, ordenador por su id en orden descendiente y limitado a 10 con el LIMIT
 */

SELECT CONCAT(c.first_name , ' ', c.last_name ) AS "Customer_name", c.customer_id 
FROM customer c
ORDER BY c.customer_id DESC 
LIMIT 10 ;


/* 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ:
 * Para esta consulta será necesario unir 3 tablas, ya que el título de la película requerido se encuentra en la tabla 'film' con su correspondiente id,
 * que se relaciona con el id de los actores en la tabla 'film_actor', que a su vez se relaciona a través del 'actor_id' con la tabla 'actor' que contiene 
 * los nombres de los actores. 
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "actor_name", f.title
FROM actor a 
INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id 
INNER JOIN film f
	ON f.film_id = fa.film_id 
WHERE f.title = 'EGG IGBY';



/* 18. Selecciona todos los nombres de las películas únicos.
 * La función DISTINCT muestra los reultados únicos de cada tabla.
 */

SELECT DISTINCT(f.title)
FROM film f ;


/* 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
 * Para esta consulta será necesario unir 3 tablas de nuevo: 'film', que nos devolverá el nombre de la película y contiene las duraciones, 
 * 'film_category', que recoge el id de la categoría que buscamos y 'category' que identifica cada id de categoría con la caterogía real.
 * 
 */

SELECT f.title , c."name" , f.length 
FROM film f 
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c 
	ON c.category_id = fc.category_id 
WHERE c."name" = 'Comedy' AND f.length > 180 ;


/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría 
 * junto con el promedio de duración:
 * De igual forma que para el ejercicio anterior, se necesita unir las 3 tablas 'film', 'film_category' y 'category' para conectar las duraciones
 * promedio de las películas con la categoría a la que corresponden.
 */

SELECT c."name" , ROUND(AVG(f.length),2) AS "Average_length"
FROM film f 
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c 
	ON c.category_id = fc.category_id 
GROUP BY c."name"
HAVING AVG(f.length) > 110 ;


/* 21. ¿Cuál es la media de duración del alquiler de las películas?
 * La media de duración de los alquileres se mide en la columna 'rental_duration' de la tabla 'film'.
 * Se redondea a 0 decimales ya que los días son valores enteros y los alquileres van por día completo.
 */

SELECT ROUND(AVG(f.rental_duration))
FROM film f ;


/* 22. Crea una columna con el nombre y apellidos de todos los actores y actrices:
 * Se emplea la función CONCAT para unir 'first_name' y 'last_name' creando el nombre completo.
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Full_Name"
FROM actor a ;


/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente:
 * Con la función COUNT se cuenta el total de alquileres y se argupa por fecha (y hora, según esta BBDD).
 * Con el ORDER BY, se ordena por la variable que consideremos, en este caso 'Total_rentals' como la cuenta de alquileres por fecha.
 */

SELECT r.rental_date, COUNT(r.rental_date) AS "Total_rentals"
FROM rental r 
GROUP BY r.rental_date 
ORDER BY "Total_rentals" DESC;

--Versión mejorada
SELECT r.rental_date::date, COUNT(r.rental_date) AS "Total_rentals"
FROM rental r 
GROUP BY r.rental_date::date
ORDER BY "Total_rentals" DESC;


/* 24. Encuentra las películas con una duración superior al promedio:
 * Utilizando una subconsulta en el WHERE, se calula el promedio de todas las duraciones y solo se seleccionan aquellas que superen este filtro.
 * Para comprobar que es correcto, se ha comprobado que la media de duración es de 115,272 con la siguiente consulta: 
 * SELECT AVG(f.length)
 * FROM film f ;
 */


SELECT f.title, f.length 
FROM film f 
WHERE f.length > (
	SELECT AVG(f.length)
	FROM film f 
) ;



/* 25. Averigua el número de alquileres registrados por mes:
 * Se usa la función TO_CHAR para asignar el nombre al mes correspondiente. Esta función convierte un registro de tiempo,
 * un intervalo, un entero, un valor de doble precisión o un valor numérico en una cadena, de acuerdo con un formato específico. En este caso, 
 * de la fecha de alquiler 'rental_date' devuelve el nombre del mes (en inglés) de acuerdo al formato 'month'.
 * Por otra parte, con la función EXTRACT(MONTH FROM...) se extrae el mes de la fecha 'rental_date' y se emplea como valor clave para contar alquileres.
 * Finalmente, se agrupa tanto por el nombre como por el número de mes para mostrar el recuento total.
 */

SELECT 
	TO_CHAR(r.rental_date, 'Month') AS "Month_Name",
	EXTRACT(MONTH FROM r.rental_date) AS "Month", 
	COUNT(EXTRACT(MONTH FROM r.rental_date)) AS "Total_rentals"
FROM rental r 
GROUP BY "Month", "Month_Name" ;


/* 26.  Encuentra el promedio, la desviación estándar y varianza del total pagado.
 * Las funciones AVG, STDDEV y VARIANCE calculan los parámetros estadísticos solicitados.
 */

SELECT 
	ROUND(AVG(p.amount), 2) AS "Promedio",
	ROUND(STDDEV(p.amount),2) AS "Desviacion_estandar",
	ROUND(VARIANCE(p.amount),2) AS "Varianza"
FROM payment p ;


/* 27. ¿Qué películas se alquilan por encima del precio medio?
 * Con una subconsulta en el WHERE se compara el precio de alquiler con el precio medio calculado y se muestran solo las que son mayores que este.
 * Se ordena por precio de alquiler por facilidad de visibilidad y comprobación que está correcta la consulta.
 */

SELECT f.title , f.rental_rate 
FROM film f 
WHERE f.rental_rate > (
	SELECT AVG(f.rental_rate)
	FROM film f
)
ORDER BY f.rental_rate ;

/* 28. Muestra el id de los actores que hayan participado en más de 40 películas:
 */

SELECT fa.actor_id , COUNT (fa.film_id) AS "Total_films"
FROM film_actor fa  
GROUP BY fa.actor_id 
HAVING COUNT(fa.film_id) > 40;

/* 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
 * Para obtener los nombres de las películas que están en inventario se necesita hacer un JOIN de las tablas 'film' e 'inventory'.
 * Se cuenta el stock (o disponibilidad) desde la tabla 'inventory' y se muestran solo los nombres de las películas disponibles.
 * 
 */

SELECT f.title , f.film_id, COUNT(i.inventory_id) AS "Amount_available"
FROM film f
JOIN inventory i ON f.film_id = i.film_id 
GROUP BY f.film_id, f.title 
ORDER BY f.film_id ASC;


/* 30. Obtener los actores y el número de películas en las que ha actuado:
 * Se hace un CONCAT para mostrar el nombre completo del actor (tabla 'actor') y se cuenta con COUNT el número de películas, que luego se agrupa por actor_id, de la tabla
 * 'film_acto'.
 * Con el LEFT JOIN se unen ambas tablas para mostrar la información conjunta.
 */

SELECT CONCAT(a.first_name,' ', a.last_name) AS "Actor_name", a.actor_id, COUNT(fa.film_id) AS "Total_films_per_actor"
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id ;


/* 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados:
 * Unimos las tablas 'film' y 'film_actor' contando cuántos actores hay por película (agrupados en el GROUP BY). Con el LEFT JOIN se muestran todos los resultados.
 */

SELECT f.title, COUNT(fa.actor_id) AS "Actors_per_film"
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY f.title 
ORDER BY "Actors_per_film" ASC ;

--Mejora comentarios:
SELECT f.title, COUNT(fa.actor_id) AS "Actors_per_film"
FROM film f 
INNER JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY f.title 
ORDER BY "Actors_per_film" ASC ;


/* 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película:
 * Siguiendo la misma lógica que la consulta anterior, unimos las tablas 'actor' y 'film_actor' y contamos las películas con la función COUNT, agrupando después
 * por 'actor_id'.
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name", a.actor_id, COUNT(fa.film_id) AS "Total_films"
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id  
ORDER BY "Total_films" ASC ;

--Mejora comentarios:
SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name", a.actor_id, COUNT(fa.film_id) AS "Total_films"
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id  
ORDER BY "Total_films" ASC ;


/* 33. Obtener todas las películas que tenemos y todos los registros de alquiler:
 * Unimos las tablas 'film' (contiene los nombres de las películas), 'inventory' (relaciona las tablas 'film' y 'rental') y 'rental' (contiene
 * los registros de los alquileres.
 */

SELECT f.title, COUNT (r.rental_id) AS "Registros_alquiler"
FROM film f 
LEFT JOIN inventory i 
	ON f.film_id = i.film_id 
LEFT JOIN rental r 
	ON i.inventory_id = r.inventory_id 
GROUP BY f.title 
ORDER BY "Registros_alquiler" ASC ;


/* 34.  Encuentra los 5 clientes que más dinero se hayan gastado con nosotros:
 * El dinero gastado se encuentra en la tabla 'payment' que se relaciona con 'customer' a través de 'customer_id', por lo que se unen ambas tablas con
 * el JOIN para mostrar el nombre y el total gastado.
 * Se ordenan los resultados de forma descendente y se limita a 5 la vista.
 */

SELECT CONCAT (c.first_name, ' ', c.last_name) AS Customer_name, c.customer_id, SUM(p.amount) AS Total_spent
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id 
ORDER BY Total_spent  DESC
LIMIT 5 ;


/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 * Con el filtro en el WHERE se seleccionan los actores cuyo nombre coincida con 'JOHNNY'.
 * Todos los nombres están en mayúsculas en la BBDD.
 * Para hacer la consulta insensible a mayúsculas o minúsculas, se usa la función ILIKE.
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name"
FROM actor a
WHERE a.first_name = 'JOHNNY' ;

/*SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name"
FROM actor a
WHERE a.first_name ILIKE 'Johnny' ;*/


/* 36.  Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
 */

SELECT a.first_name AS "Nombre", a.last_name AS "Apellido"
FROM actor a ;


/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor:
 * Utilizando las funciones MIN y MAX se obtienen los valores más alto y más bajo del id de los actores.
 */

SELECT MAX(a.actor_id) AS "max_id", MIN(a.actor_id) AS "min_id"
FROM actor a ;


/* 38. Cuenta cuántos actores hay en la tabla “actorˮ:
 */


SELECT COUNT(a.actor_id) AS "Total_actores"
FROM actor a ;

/* 39.  Selecciona todos los actores y ordénalos por apellido en orden ascendente.
 * 
 */

SELECT a.first_name, a.last_name 
FROM actor a 
ORDER BY a.last_name ASC ;


/* 40. Selecciona las primeras 5 películas de la tabla “filmˮ.
 * Así se muestran las 5 primeras películas en la tabla 'film' según el orden de la BBDD.
 */

SELECT f.title 
FROM film f 
LIMIT 5 ;


/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
 * Para mostrar el nombre más repetido, se ordena la cuenta (agrupada por 'first_name') de forma descendiente.
 */

SELECT a.first_name, COUNT(a.first_name) AS "Cuenta_nombre"
FROM actor a 
GROUP BY a.first_name 
ORDER BY "Cuenta_nombre" DESC ;


/* 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
 */

SELECT r.rental_id, CONCAT(c.first_name,' ', c.last_name) AS Client_name
FROM rental r 
JOIN customer c 
	ON c.customer_id = r.customer_id ;


/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres:
 */

SELECT CONCAT(c.first_name, ' ', c.last_name) AS "Customer_name", COUNT(r.rental_id) AS "Total_rentals"
FROM customer c 
LEFT JOIN rental r 
	ON c.customer_id = r.customer_id 
GROUP BY "Customer_name" 
ORDER BY "Total_rentals" ASC ;

-- En esta consulta comprobamos si existe algún cliente sin alquileres:
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1 
    FROM rental r 
    WHERE r.customer_id = c.customer_id
);


/* 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
 */

SELECT * 
FROM film f
CROSS JOIN category c ;

--Esta consulta no aoprta valor, ya que se trata del producto cartesiano de todas las variables, sin aportar nada de información.


/* 45. Encuentra los actores que han participado en películas de la categoría 'Action':
 * Se utiliza la función DISTINCT para no repetir nombres de actores.
 * Se unen las tablas 'actor', 'film_actor', 'film_category' y 'category', que contienen la información que se solicita.
 * Finalmente, se filtra por el nombre de la categoría que se busca, 'Action'.
 */

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name", c.name
FROM actor a 
JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
JOIN film_category fc 
	ON fc.film_id = fa.film_id 
JOIN category c 
	ON c.category_id = fc.category_id 
WHERE c.name = 'Action' ;


/* 46. Encuentra todos los actores que no han participado en películas:
 * Es este caso, todos los actores han participado en películas.
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name"
FROM actor a 
LEFT JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
WHERE fa.film_id IS NULL ;


/* 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado:
 */

SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name", COUNT(fa.film_id) AS "Total_films"
FROM actor a 
LEFT JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id  
ORDER BY a.actor_id ASC ;


/* 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
 * Para crear una vista se usa la función CREATE VIEW. Dentro de esta función se especifica lo que se quiere que haga: en este caso, hacer un recuento del
 * número de películas en las que ha participado cada actor, mostrando su nombre. Por tanto, se encadenan las dos tablas 'actor' y 'film_actor' (que recoge
 * el número de películas por actor) y se cuenta el id de cada película, agrupando por id de actor.
 */

CREATE VIEW actor_num_peliculas AS 
	SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name", COUNT(fa.film_id) AS "Total_films"
	FROM actor a 
	INNER JOIN film_actor fa 
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name ;
	
SELECT *
FROM actor_num_peliculas ;


/* 49. Calcula el número total de alquileres realizados por cada cliente.
 */
	
SELECT r.customer_id , CONCAT(c.first_name, ' ', c.last_name) AS "Customer_Name", COUNT(r.rental_id) AS "Total_rentals"
FROM rental r 
INNER JOIN customer c 
	ON c.customer_id = r.customer_id 
GROUP BY r.customer_id, c.first_name, c.last_name ;


/* 50. Calcula la duración total de las películas en la categoría 'Action':
 */

SELECT c."name" , SUM(f.length) AS "Total_duration"
FROM film f 
INNER JOIN film_category fc 
	ON fc.film_id = f.film_id 
INNER JOIN category c 
	ON c.category_id = fc.category_id 
GROUP BY c.name
HAVING c."name" = 'Action' ;

-- Usando subconsultas

SELECT Category, total_duration
FROM (
	SELECT c.name AS Category, SUM(f.length) AS Total_duration
	FROM film f 
	INNER JOIN film_category fc 
		ON f.film_id = fc.film_id 
	INNER JOIN category c
		ON c.category_id = fc.category_id 
	GROUP BY c."name"
) AS category_duration
WHERE Category = 'Action' ;



/* 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente:
 * Se crea la tabla temporal uniendo las tablas 'rental' y 'customer' para mostrar el nombre completo del cliente.
 */

CREATE TEMPORARY TABLE cliente_rentas_temporal AS 
	SELECT r.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS "Customer_name", COUNT(r.rental_id) AS "Total_rentals"
	FROM rental r
	INNER JOIN customer c
		ON c.customer_id = r.customer_id
	GROUP BY r.customer_id, c.first_name, c.last_name ;


SELECT "customer_id", "Customer_name", "Total_rentals"
FROM cliente_rentas_temporal ;

-- Función para borrar la tabla temporal: DROP TABLE cliente_rentas_temporal;


/* 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
 * 
 */

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.title AS "film_name", COUNT(i.inventory_id) AS "total_rentals"
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f
	ON f.film_id = i.film_id 
GROUP BY f.title
HAVING COUNT(i.inventory_id) > 9 ;

SELECT *
FROM peliculas_alquiladas ;


/* 53.  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto.
 * Ordena los resultados alfabéticamente por título de película:
 * En esta consulta se han de unir cuatro tablas para relacionar la información solicitada: 'customer', 'rental', 'inventory' y 'film'. En este primer caso
 * se ha usado como tabla principal (a la que unir el resto) la tabla 'customer', ya que se pide filtrar por el cliente 'Tammy Sanders' y sus alquileres.
 */

SELECT CONCAT(c.first_name, ' ', c.last_name) AS "Customer_name", r.return_date, f.title 
FROM customer c 
INNER JOIN rental r 
	ON c.customer_id = r.customer_id 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE c.first_name ILIKE 'Tammy' AND c.last_name ILIKE 'Sanders' AND r.return_date IS NULL 
ORDER BY f.title ASC ;

-- Utilizando 'film' como tabla principal, ya que se pide como consulta principal el título de las películas.

SELECT f.title, CONCAT (c.first_name, ' ', c.last_name) AS "Customer_name", r.return_date 
FROM film f 
INNER JOIN inventory i 
	ON f.film_id = i.film_id 
INNER JOIN rental r 
	ON i.inventory_id = r.inventory_id 
INNER JOIN customer c
	ON r.customer_id = c.customer_id
WHERE 
	c.first_name ILIKE 'Tammy' AND
	c.last_name ILIKE 'Sanders'
	AND r.return_date IS NULL
ORDER BY f.title ASC ;

-- Utilizando una subconsulta: en este caso se muestra exclusivamente el título de las películas solicitado.

SELECT f.title
FROM film f 
WHERE EXISTS (
	SELECT 1
	FROM rental r 
	INNER JOIN inventory i
		ON r.inventory_id = i.inventory_id
	INNER JOIN customer c
		ON c.customer_id = r.customer_id
	WHERE f.film_id = i.film_id 
		AND c.first_name ILIKE 'Tammy'
		AND c.last_name ILIKE 'Sanders'
		AND r.return_date IS NULL
)
ORDER BY f.title ASC ;


/* 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados 
 * alfabéticamente por apellido:
 * Se utiliza una subconsulta en el WHERE para verificar los actores para los que existe la participación en una película categorizada com o'Sci-Fi'.
 */

SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Actor_name"
FROM actor a
WHERE EXISTS (
	SELECT 1
	FROM film_actor fa 
	INNER JOIN film_category fc 
		ON fa.film_id = fc.film_id
	INNER JOIN category c
		ON c.category_id = fc.category_id
	WHERE fa.actor_id = a.actor_id AND c.name ILIKE 'Sci-Fi'
)
ORDER BY a.last_name ASC ;


/* 55.  Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus 
 * Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
 */

/* -- Cuándo se alquiló por primera vez 'Spartacus Cheaper'
SELECT MIN(r.rental_date)
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE f.title ILIKE 'Spartacus Cheaper' ;

SELECT f.title, r.rental_date
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE f.title ILIKE 'Spartacus Cheaper' 
ORDER BY r.rental_date ASC 
LIMIT 1 
;

-- Películas que se alquilaron después
SELECT f.title, r.rental_date 
FROM film f 
INNER JOIN inventory i 
	ON f.film_id = i.film_id 
INNER JOIN rental r
	ON i.inventory_id = r.inventory_id 
WHERE r.rental_date > (
	SELECT MIN(r2.rental_date)
	FROM rental r2 
	INNER JOIN inventory i2 
		ON i2.inventory_id = r2.inventory_id 
	INNER JOIN film f2 
		ON f2.film_id = i2.film_id 
	WHERE f2.title ILIKE 'Spartacus Cheaper' 
) ; */

-- Como relacionar esas películas con sus actores y que muestre solo el nombre una vez (utilizando DISTINCT)
SELECT DISTINCT a.first_name, a.last_name 
FROM film f 
INNER JOIN inventory i 
	ON f.film_id = i.film_id 
INNER JOIN rental r
	ON i.inventory_id = r.inventory_id 
INNER JOIN film_actor fa 
	ON f.film_id = fa.film_id 
INNER JOIN actor a 
	ON a.actor_id = fa.actor_id 
WHERE r.rental_date > (
	SELECT MIN(r2.rental_date)
	FROM rental r2 
	INNER JOIN inventory i2 
		ON i2.inventory_id = r2.inventory_id 
	INNER JOIN film f2 
		ON f2.film_id = i2.film_id 
	WHERE f2.title ILIKE 'Spartacus Cheaper' 
) 
ORDER BY a.last_name ;



/* 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
 * En la subconsulta se comprueba los actor_id de actores que nunca han participado en una pelicula categorizada como 'Music'. 
 */

SELECT CONCAT(a.first_name, ' ', a.last_name )
FROM actor a 
WHERE NOT EXISTS (
	SELECT 1
	FROM film_actor fa 
	INNER JOIN film_category fc 
		ON fa.film_id = fc.film_id 
	INNER JOIN category c 
		ON c.category_id = fc.category_id 
	WHERE a.actor_id = fa.actor_id 
		AND c.name = 'Music'
)
ORDER BY a.last_name ;



/* 57.  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días:
 * Se plantean dos soluciones para responder a esta cuestión. En ambas se utiliza la función DISTINCT para evitar títulos repetidos. Para que sea efectivo,
 * se deja comentado la columna "rental_period" que comprueba de forma visual (si se quiere mostrar) que las duraciones de los alquileres son de más de 8 días.
 */

-- 1. De esta manera se muestran los que estrictamente han tenido un alquiler mayor de 8 días, comparando solo los números enteros.
SELECT DISTINCT f.title --, r.return_date::date - r.rental_date::date AS "rental_period"
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE (r.return_date::date - r.rental_date::date) > 8 ;
--ORDER BY r.return_date - r.rental_date ASC ;

-- 2. De esta forma se comparan las fechas, teniendo en cuenta la hora marcada en las variables 'rental_date' y 'return_date'. En esta opción, 
-- se muestran los alquileres que han durado más de 8 días, aunque sean 8 días y 1h.
SELECT DISTINCT f.title --, r.return_date - r.rental_date AS "rental_period"
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film f 
	ON f.film_id = i.film_id 
WHERE (r.return_date - r.rental_date) > INTERVAL '8 days' ;
--ORDER BY r.return_date - r.rental_date ASC ;



/* 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
 */

SELECT f.title 
FROM film f
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c
	ON c.category_id = fc.category_id 
WHERE c."name" ILIKE 'Animation' ;



/* 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados
 * alfabéticamente por título de película.
 */

-- Duración de la película 'Dancing fever' --> subconsulta para filtrar
SELECT f.title, f.length 
FROM film f 
WHERE f.title ILIKE 'Dancing fever' ;

SELECT f.title , f.length 
FROM film f 
WHERE f.length = (
 SELECT f.length 
 FROM film f 
 WHERE f.title ILIKE 'Dancing fever' ) 
ORDER BY f.title ASC ;



/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
 * Ordena los resultados alfabéticamente por apellido. 
*/ 

SELECT c.first_name, c.last_name, COUNT(DISTINCT i.film_id) AS "total__different_films"
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN customer c 
	ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name , c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7 
ORDER BY c.last_name , c.first_name ;



/* 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
 * 
 */

SELECT c.name, COUNT(*) AS "rented_films"
FROM rental r 
INNER JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
INNER JOIN film_category fc 
	ON fc.film_id = i.film_id 
INNER JOIN category c
	ON c.category_id = fc.category_id 
GROUP BY c.name ;



/* 62. Encuentra el número de películas por categoría estrenadas en 2006. 
 */

SELECT c.name, COUNT(f.film_id) AS "total_films"
FROM film f 
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id 
INNER JOIN category c
	ON c.category_id = fc.category_id 
WHERE f.release_year = 2006
GROUP BY c."name" ;



/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
 * 
 */

SELECT s.staff_id, CONCAT(s.first_name, ' ', s.last_name), s2.store_id 
FROM staff s 
CROSS JOIN store s2 ;



/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
 * películas alquiladas.
 */ 

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS "customer_name", COUNT(i.film_id) AS "rented_films"
FROM rental r 
INNER JOIN customer c 
	ON c.customer_id = r.customer_id 
INNER JOIN inventory i
	ON i.inventory_id = r.inventory_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY rented_films DESC ;


	