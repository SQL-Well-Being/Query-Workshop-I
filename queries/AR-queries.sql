-- Punto A)
-- nombre de las conferencias y su duración, 
-- solamente las que tienen duración de dos (2) horas o más.

SELECT confe_nombre, confe_duracion
	FROM conferencia
	WHERE confe_duracion >= 2;
