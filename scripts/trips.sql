CREATE SCHEMA IF NOT EXISTS viajes;

USE viajes;

DROP TABLE IF EXISTS viaje;
DROP TABLE IF EXISTS ciudad;

CREATE TABLE ciudad (
    ciu_id INT PRIMARY KEY,
    ciu_nombre VARCHAR(50)
);

CREATE TABLE viaje (
    ciu_origen_id INT,
    ciu_destino_id INT,
    FOREIGN KEY (ciu_origen_id) REFERENCES ciudad(ciu_id),
    FOREIGN KEY (ciu_destino_id) REFERENCES ciudad(ciu_id)
);

INSERT INTO ciudad 
	(ciu_id, ciu_nombre) 
VALUES
	(1, 'Bogotá'),
	(2, 'Pasto'),
	(3, 'Barranquilla'),
	(4, 'Medellín'),
	(5, 'Cali');

INSERT INTO viaje 
	(ciu_origen_id, ciu_destino_id) 
VALUES
	(1, 3),
	(1, 2),
	(5, 4),
	(5, 1),
	(3, 2),
	(2, 5),
	(2, 1),
	(2, 4);
