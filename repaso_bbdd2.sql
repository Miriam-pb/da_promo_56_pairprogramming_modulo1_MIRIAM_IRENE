USE sakila;
-- Obtener los clientes y las películas que han alquilado.
-- Obtener los actores y las películas en las que han actuado.
-- Obtener todos los clientes y mostrar la cantidad de alquileres que han realizado, incluso si no han realizado ningún alquiler.
SELECT c.customer_id, first_name, COUNT(r.rental_id) AS cantidad_alquileres
FROM customer AS c
LEFT JOIN rental AS r
USING (customer_id)
GROUP BY c.customer_id; -- NO HAY CLIENTES SIN ALQUILER

-- solucion
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS cantidad_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY cantidad_alquileres;
-- Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.film_id, f.title, a.first_name, a.last_name, a.actor_id
FROM film AS f
LEFT JOIN film_actor AS f_a
ON f.film_id = f_a.film_id
LEFT JOIN actor AS a
ON a.actor_id = f_a.actor_id;

-- Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT f.film_id, f.title, a.first_name, a.last_name, a.actor_id
FROM film AS f
RIGHT JOIN film_actor AS f_a
ON f.film_id = f_a.film_id
RIGHT JOIN actor AS a
ON a.actor_id = f_a.actor_id;

-- Encuentra todas las películas que comienzan con la letra "A" en su título.
SELECT title
FROM film
WHERE title REGEXP '^A';
SELECT title
FROM film
WHERE title LIKE 'A%'; -- otra opcion

-- Encuentra todas las películas que tienen al menos una vocal en su título.

SELECT title
FROM film
WHERE title REGEXP '[aeiou]';

-- Encuentra todas las películas que tienen una longitud de título de al menos 10 caracteres.
SELECT title
FROM film
WHERE title REGEXP '.{10,}';

-- Encuentra todos los actores cuyos nombres comienzan con la letra "A" en la tabla actor, y 
-- encuentra todos los clientes cuyos nombres comienzan con la letra "B" en la tabla customer.
-- Combina ambos conjuntos de resultados en una sola tabla.

-- Encuentra todas las películas cuyos títulos contienen la palabra "Comedy" en la tabla film, y 
-- encuentra todas las películas cuyo título comienza con la letra "D" en la misma tabla. 
-- Combina ambos conjuntos de resultados en una sola lista de películas.
SELECT title, 'contiene_comedy' AS resultado_ejercicio 
FROM film
WHERE title LIKE "%comedy%" OR title LIKE "comedy%" OR title LIKE "%comedy"
UNION
SELECT title, 'comienzapord'
FROM film
WHERE title REGEXP "^D" 

-- Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que 
-- la película "ACADEMY DINOSAUR" 
-- se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

SELECT MIN(r.rental_date)
FROM rental AS r
INNER JOIN inventory AS i
USING (inventory_id)
INNER JOIN film AS f
USING (film_id)
WHERE f.title = "ACADEMY DINOSAUR"

SELECT DISTINCT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS f_a
USING (actor_id)
INNER JOIN film AS f
USING (film_id)
INNER JOIN inventory AS i
USING (film_id)
INNER JOIN rental AS r
USING (inventory_id)
WHERE r.rental_date > (SELECT MIN(r.rental_date)
							FROM rental AS r
							INNER JOIN inventory AS i
							USING (inventory_id)
							INNER JOIN film AS f
							USING (film_id)
							WHERE f.title = "ACADEMY DINOSAUR")
ORDER BY a.last_name ASC;
-- Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre "MARY SMITH" y 
-- que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT return_date
FROM rental
WHERE return_date IS NULL;

SELECT f.title
FROM film AS f
LEFT JOIN inventory AS i
USING (film_id)
LEFT JOIN rental AS r
USING (inventory_id)
LEFT JOIN customer AS c
USING (customer_id)
WHERE c.first_name = 'MARY' AND c.last_name = 'SMITH' AND return_date IS NULL
ORDER BY f.title ASC;

SELECT f.title
FROM film AS f
LEFT JOIN inventory AS i
USING (film_id)
LEFT JOIN rental AS r
USING (inventory_id)
LEFT JOIN customer AS c
USING (customer_id)
WHERE CONCAT(c.first_name, ' ', c.last_name) AS cliente = 'MARY SMITH'

SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.first_name = 'MARY' AND customer.last_name = 'SMITH'
AND rental.return_date IS NULL
ORDER BY film.title;

-- Encuentra los nombres de los clientes que han alquilado al menos 5 películas distintas. 
-- Ordena los resultados alfabéticamente por apellido.

SELECT COUNT(DISTINCT title) AS num_peliculas
FROM rental AS r
LEFT JOIN inventory AS i USING (inventory_id)
LEFT JOIN film AS f USING (film_id)
GROUP BY r.customer_id
HAVING num_peliculas > 5

SELECT c.first_name
FROM customer AS c
WHERE (SELECT COUNT(DISTINCT title) AS num_peliculas
				FROM rental AS r
				LEFT JOIN inventory AS i USING (inventory_id)
				LEFT JOIN film AS f USING (film_id)
				GROUP BY r.customer_id
				HAVING num_peliculas > 5)

SELECT customer.first_name, customer.last_name
FROM customer
JOIN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(DISTINCT inventory_id) >= 5
) AS subquery ON customer.customer_id = subquery.customer_id
ORDER BY customer.last_name, customer.first_name;