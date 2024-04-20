CREATE SCHEMA IF NOT EXISTS eventos DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE eventos;

DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS conferencia;
DROP TABLE IF EXISTS conferencista;
DROP TABLE IF EXISTS salon;

CREATE TABLE salon(
    sal_id INT,
    sal_nombre VARCHAR(50) NOT NULL,
    sal_tipo VARCHAR(50) NOT NULL,

    PRIMARY KEY(sal_id)
);

CREATE TABLE conferencista(
    con_id INT,
    con_nombre VARCHAR(50) NOT NULL,
    con_apellido VARCHAR(50) NOT NULL,
    con_horas_trabajadas INT NOT NULL,

    PRIMARY KEY(con_id)
);


CREATE TABLE conferencia(
    confe_id INT,
    confe_nombre VARCHAR(50) NOT NULL,
    con_id INT NOT NULL,
    confe_duracion INT NOT NULL,

    PRIMARY KEY(confe_id),
    FOREIGN KEY(con_id) REFERENCES conferencista(con_id)
);

CREATE TABLE evento(
    confe_id INT,
    sal_id INT,
    fecha DATE,

    PRIMARY KEY(confe_id, sal_id, fecha),
    FOREIGN KEY(confe_id) REFERENCES conferencia(confe_id),
    FOREIGN KEY(sal_id) REFERENCES salon(sal_id)
);

INSERT INTO conferencista
    (con_id, con_nombre, con_apellido, con_horas_trabajadas)
VALUES
    (101, "Andres", "Mendez", 10),
    (102, "Jorge", "Vargas", 21),
    (103, "Fernando", "Pulido", 15),
    (104, "Alexandra", "Duarte", 18),
    (105, "Angela", "Blanco", 13),
    (106, "Erika", "Sandoval", 6),
    (107, "Luis", "Gomez", 8);


INSERT INTO salon
    (sal_id, sal_nombre, sal_tipo)
VALUES
    (10, "Rembrandt", "Auditorio"),
    (20, "Renoir", "Auditorio"),
    (30, "Monet", "Auditorio"),
    (40, "Juntas", "Sala de Juntas"),
    (50, "Principal", "Sala de Juntas"),
    (61, "Salon 1", "Aula"),
    (62, "Salon 2", "Aula"),
    (63, "Salon 3", "Aula"),
    (64, "Salon 5", "Aula");


INSERT INTO conferencia
    (confe_id, confe_nombre, con_id, confe_duracion)
VALUES
    (100, "Al otro lado del lienzo", 102, 2),
    (110, "Derechos humanos", 103, 1),
    (120, "La tecnologia de hoy", 104, 1),
    (130, "Picasso: un milagro en Basilea", 105, 3),
    (140, "Analisis dimensional", 104, 2),
    (150, "Sociedad y Paz", 103, 3),
    (160, "Educacion para el Desarrollo Sostenible", 101, 1),
    (170, "Musica clasica", 107, 2),
    (180, "Biologia molecular", 106, 2),
    (190, "Epidemiologia", 106, 1),
    (200, "Educacion para todos", 101, 2);


INSERT INTO evento
    (confe_id, sal_id, fecha)
VALUES
    (100, 40, "2018-04-03"),
    (110, 61, "2018-10-05"),
    (120, 20, "2018-11-10"),
    (130, 10, "2019-04-03"),
    (140, 20, "2018-11-10"),
    (150, 30, "2018-10-05"),
    (160, 10, "2018-10-05"),
    (170, 63, "2018-09-14"),
    (180, 62, "2019-01-17"),
    (190, 62, "2019-06-09"),
    (110, 62, "2019-01-20"),
    (130, 10, "2019-05-30"),
    (150, 10, "2019-03-07"),
    (160, 10, "2019-04-05"),
    (160, 61, "2018-10-05");