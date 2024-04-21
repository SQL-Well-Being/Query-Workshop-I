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