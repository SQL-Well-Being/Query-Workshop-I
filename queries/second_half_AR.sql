-- Punto j --
SELECT confe_nombre, confe_duracion, con_nombre, con_apellido, sal_nombre, fecha
	FROM evento
    INNER JOIN salon ON evento.sal_id = salon.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id;

-- Punto k--
SELECT COUNT(*) AS 'Conferencistas con menos de 15 horas trabajadas' 
	FROM conferencista WHERE con_horas_trabajadas < 15;
    
-- Punto l--
SELECT sal_tipo, COUNT(confe_id) AS 'Conferencias realizadas' FROM 
	evento INNER JOIN salon ON evento.sal_id = salon.sal_id
    GROUP BY sal_tipo;
    
-- Punto m --
SELECT sal_nombre, COUNT(confe_id) AS 'Conferencias realizadas' FROM 
	evento RIGHT JOIN salon ON evento.sal_id = salon.sal_id
    GROUP BY sal_nombre;
    
-- Punto n --
SELECT confe_nombre, COUNT(evento.confe_id) AS 'Veces presentada' FROM 
	conferencia LEFT JOIN evento ON conferencia.confe_id = evento.confe_id
    GROUP BY confe_nombre;

-- Punto o--
SELECT SUM(confe_duracion) AS 'Horas ocupacion' FROM
	salon 
    INNER JOIN evento ON salon.sal_id = evento.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    WHERE salon.sal_id=62;

-- Punto p --
SELECT sal_nombre FROM

	(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		INNER JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab1
		
		INNER JOIN
		
	(SELECT MAX(ocupacion) AS 'maximo_ocupacion' FROM 
		(SELECT sal_nombre, SUM(confe_duracion) AS 'ocupacion' FROM
		salon 
		INNER JOIN evento ON salon.sal_id = evento.sal_id
		INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
		GROUP BY sal_nombre) AS tab2) AS tab3
		
		ON tab1.ocupacion = tab3.maximo_ocupacion;

-- Punto q --
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

-- Punto r --
SELECT AVG(con_horas_trabajadas) AS 'promedio_horas_trabajadas' FROM
	evento
    INNER JOIN salon ON salon.sal_id = evento.sal_id
    INNER JOIN conferencia ON evento.confe_id = conferencia.confe_id
    INNER JOIN conferencista ON conferencia.con_id = conferencista.con_id
    WHERE salon.sal_tipo = 'Auditorio';