USE municipios;

-- Punto 1 --
SELECT nom FROM municipio ORDER BY poblacion2003 DESC LIMIT 10;

-- Punto 2 --
SELECT nom FROM municipio ORDER BY poblacion2003 / superficie DESC LIMIT 5;

-- Punto 3 --
SELECT nom FROM municipio WHERE (superficie < (SELECT AVG(superficie) / 10 FROM municipio));

-- Punto 4 --
SELECT nom, poblacion2001, poblacion1991 FROM municipio WHERE (poblacion2001 > (poblacion1991 * 10) AND poblacion1991 > 0);