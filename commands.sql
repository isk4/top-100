-- 1. Crear base de datos llamada películas
CREATE DATABASE peliculas;
\c peliculas

-- 2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas.
CREATE TABLE peliculas(id SERIAL PRIMARY KEY, pelicula VARCHAR(100), año_estreno INT, director VARCHAR(50));
CREATE TABLE reparto(pelicula_id INT, nombre VARCHAR(50), FOREIGN KEY(pelicula_id) REFERENCES peliculas(id));

-- 3. Cargar ambos archivos a su tabla correspondiente
\copy peliculas FROM '/home/victor/Documents/base-datos/top-100/peliculas.csv' CSV HEADER;
\copy reparto FROM '/home/victor/Documents/base-datos/top-100/reparto.csv' CSV;

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto
SELECT peliculas.pelicula, peliculas.año_estreno, peliculas.director, reparto.nombre FROM peliculas INNER JOIN reparto ON pelicula_id=peliculas.id WHERE pelicula='Titanic';

-- 5. Listar los titulos de las películas donde actúe Harrison Ford
SELECT pelicula FROM peliculas INNER JOIN reparto ON pelicula_id=peliculas.id WHERE nombre='Harrison Ford';

-- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100
SELECT peliculas.director, count(director) AS numero_peliculas FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);

-- 7. Indicar cuantos actores distintos hay
SELECT count(actores) FROM (SELECT nombre FROM reparto GROUP BY(nombre)) AS actores;

-- 8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente
SELECT pelicula FROM peliculas WHERE año_estreno >= 1990 AND año_estreno <= 1999 ORDER BY(pelicula);

-- 9. Listar el reparto de las películas lanzadas el año 2001
SELECT reparto.nombre AS actor_actriz, peliculas.pelicula FROM peliculas INNER JOIN reparto ON pelicula_id=peliculas.id WHERE año_estreno=2001;

-- 10. Listar los actores de la película más nueva
SELECT nombre FROM reparto INNER JOIN peliculas ON pelicula_id=peliculas.id WHERE año_estreno = (SELECT MAX(año_estreno) FROM peliculas);