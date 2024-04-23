USE municipios;

-- Punto 1 --
SELECT municipio.nom, comunidad.nom FROM municipio, comunidad WHERE municipio.ca_id = comunidad.ca_id AND comunidad.nom = "Catalunya" ORDER BY municipio.nom; 
SELECT comunidad.nom, SUM(municipio.poblacion2003) FROM municipio, comunidad WHERE municipio.ca_id= comunidad.ca_id GROUP BY comunidad.nom ORDER BY comunidad.nom; 

-- Punto 2 --
SELECT municipio.nom, comunidad.nom FROM municipio INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id WHERE comunidad.nom = "Catalunya" ORDER BY municipio.nom;
SELECT comunidad.nom, SUM(municipio.poblacion2003) AS superficie_total FROM municipio INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id GROUP BY comunidad.nom ORDER BY comunidad.nom;

-- Punto 3 --
SELECT comunidad.nom, SUM(municipio.superficie) FROM municipio INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id GROUP BY comunidad.nom;

-- Punto 4 --
SELECT comunidad.nom, SUM(municipio.poblacion2001) - SUM(municipio.poblacion1991) AS variacion FROM municipio INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id GROUP BY comunidad.nom;

-- Punto 5 --
SELECT comunidad.nom, SUM(municipio.superficie) AS superficie_total FROM municipio INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id WHERE comunidad.nom = "Galicia";