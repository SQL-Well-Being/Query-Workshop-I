USE municipios;

-- Busqueda de Strings --

-- Punto 1 --
SELECT nom FROM comunidad WHERE nom LIKE '%Castilla%' AND nom NOT LIKE '%Mancha%';

-- Punto 2 -- 
SELECT *  FROM municipio
	WHERE (LENGTH(nom) >= 20) AND (LENGTH(nom) - LENGTH(REPLACE(LOWER(nom),  'x', '')) = 1);

-- Punto 3 --
SELECT * FROM municipio
	WHERE  
		((LENGTH(nom) - LENGTH(REGEXP_REPLACE(nom, '[aáàAÁÀ]', '', 1, 1))) + 
        (LENGTH(nom) - LENGTH(REGEXP_REPLACE(nom, '[eéèEÉÈ]', '', 1, 1))) +
        (LENGTH(nom) - LENGTH(REGEXP_REPLACE(nom, '[iíìIÍÌ]', '', 1, 1))) +
        (LENGTH(nom) - LENGTH(REGEXP_REPLACE(nom, '[oóòOÓÒ]', '', 1, 1))) + 
        (LENGTH(nom) - LENGTH(REGEXP_REPLACE(nom, '[uúùUÚÙ]', '', 1, 1))) ) = 1;

-- Busqueda Numerica --

-- Punto 1 --
SELECT nom FROM municipio ORDER BY poblacion2003 DESC LIMIT 10;

-- Punto 2 --
SELECT nom FROM municipio ORDER BY poblacion2003 / superficie DESC LIMIT 5;

-- Punto 3 --
SELECT nom FROM municipio WHERE (superficie < (SELECT AVG(superficie) / 10 FROM municipio));

-- Punto 4 --
SELECT nom, poblacion2001, poblacion1991 FROM municipio WHERE (poblacion2001 > (poblacion1991 * 10) AND poblacion1991 > 0);

-- Joins --

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

-- AR --

USE eventos;
-- Punto A --
SELECT confe_nombre, confe_duracion
	FROM conferencia
	WHERE confe_duracion >= 2;

-- Punto B --
SELECT confe_nombre, confe_duracion, con_nombre, con_apellido
	FROM conferencia
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id;

-- Punto C --
SELECT con_nombre, con_apellido
	FROM conferencia
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id
    WHERE confe_nombre='Musica clasica';

-- Punto D --
SELECT confe_nombre
	FROM conferencia
	INNER JOIN conferencista ON  conferencista.con_id = conferencia.con_id
    WHERE conferencista.con_nombre = 'Andres' AND conferencia.confe_duracion = 1;

-- Punto E --
SELECT DISTINCT sal_nombre
	FROM salon
    INNER JOIN evento ON evento.sal_id = salon.sal_id
    WHERE sal_tipo = 'Auditorio';

-- Punto F --
SELECT DISTINCT sal_nombre, sal_tipo
	FROM salon
    INNER JOIN evento ON evento.sal_id = salon.sal_id;

-- Punto G --
SELECT DISTINCT confe_nombre
	FROM salon
    INNER JOIN evento ON evento.sal_id = salon.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    WHERE sal_nombre = 'Rembrandt';

-- Punto H --
SELECT DISTINCT con_nombre, con_apellido
	FROM salon
    INNER JOIN evento ON evento.sal_id = salon.sal_id
	INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id
    WHERE sal_tipo = 'Auditorio';

-- Punto I --
SELECT DISTINCT confe_nombre
	FROM salon
    INNER JOIN evento ON evento.sal_id = salon.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    WHERE sal_nombre = 'Rembrandt' AND fecha >= '2018-09-01' AND fecha <= '2019-04-10';

-- Punto J --
SELECT confe_nombre, confe_duracion, con_nombre, con_apellido, sal_nombre, fecha
	FROM evento
    INNER JOIN salon ON evento.sal_id = salon.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id;

-- Punto K --
SELECT COUNT(*) AS 'Conferencistas con menos de 15 horas trabajadas' 
	FROM conferencista WHERE con_horas_trabajadas < 15;
    
-- Punto L --
SELECT sal_tipo, COUNT(confe_id) AS 'Conferencias realizadas' FROM 
	evento INNER JOIN salon ON evento.sal_id = salon.sal_id
    GROUP BY sal_tipo;
    
-- Punto M --
SELECT sal_nombre, COUNT(confe_id) AS 'Conferencias realizadas' FROM 
	evento RIGHT JOIN salon ON evento.sal_id = salon.sal_id
    GROUP BY sal_nombre;
    
-- Punto N --
SELECT confe_nombre, COUNT(evento.confe_id) AS 'Veces presentada' FROM 
	conferencia LEFT JOIN evento ON conferencia.confe_id = evento.confe_id
    GROUP BY confe_nombre;

-- Punto O --
SELECT SUM(confe_duracion) AS 'Horas ocupacion' FROM
	salon 
    INNER JOIN evento ON salon.sal_id = evento.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    WHERE salon.sal_id=62;

-- Punto P --
SELECT sal_nombre FROM

	(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		INNER JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab1
		-- 
		INNER JOIN
		
	(SELECT MAX(ocupacion) AS 'maximo_ocupacion' FROM 
		(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		INNER JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab2) AS tab3
		
		ON tab1.ocupacion = tab3.maximo_ocupacion;

-- Punto Q --
SELECT sal_nombre FROM

	(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		LEFT JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab1
		
		INNER JOIN
		
	(SELECT MIN(ocupacion) AS 'minimo_ocupacion' FROM 
		(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		LEFT JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab2) AS tab3
		
		ON tab1.ocupacion = tab3.minimo_ocupacion;

-- Punto R --
SELECT AVG(con_horas_trabajadas) AS 'promedio_horas_trabajadas' FROM
	evento
    INNER JOIN salon ON salon.sal_id = evento.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id
    WHERE salon.sal_tipo = 'Auditorio';

-- Viajes --

USE viajes;

SELECT ciudad.ciu_nombre, ciudad_destino.ciu_nombre FROM viaje INNER JOIN ciudad ON viaje.ciu_origen_id = ciudad.ciu_id INNER JOIN ciudad AS ciudad_destino ON viaje.ciu_destino_id = ciudad_destino.ciu_id;