CREATE DOMAIN Calificacion_Pelicula VARCHAR(10)
    CHECK (VALUE IN ('1.0', '2.0', '3.0', '4.0', '5.0'));

CREATE DOMAIN Idioma_Pelicula VARCHAR(50)
    CHECK (VALUE IN ('Inglés', 'Español', 'Francés', 'Alemán', 'Italiano', 'Japonés', 'Mandarín', 'Coreano', 'Ruso', 'Otros'));

CREATE TABLE Calificacion (
    ID_Calificacion SERIAL PRIMARY KEY,
    Valor VARCHAR(10) UNIQUE
);

SELECT * FROM Calificacion;

CREATE TABLE Idioma (
    ID_Idioma SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) UNIQUE
);

SELECT * FROM idioma;

CREATE TABLE Persona (
    ID_Persona SERIAL PRIMARY KEY,
    Nombre VARCHAR(255),
    Fecha_Nacimiento DATE,
    Nacionalidad VARCHAR(100)
);

SELECT * FROM Persona;

CREATE TABLE Pelicula (
    ID_Pelicula INT PRIMARY KEY,
    Titulo VARCHAR(255),
    Anio_Lanzamiento INT,
    Genero VARCHAR(100),
    Sinopsis TEXT,
    Director_ID INT,
    Pais_Origen VARCHAR(100),
    Duracion INT,
    ID_Calificacion INT,
    ID_Idioma INT,
    FOREIGN KEY (Director_ID) REFERENCES Persona(ID_Persona),
    FOREIGN KEY (ID_Calificacion) REFERENCES Calificacion(ID_Calificacion),
    FOREIGN KEY (ID_Idioma) REFERENCES Idioma(ID_Idioma)
);

SELECT * FROM Actor;
UPDATE Actor set genero = 'Femenino' WHERE genero = 'Masculino';
INSERT INTO Pelicula (id_pelicula, titulo, anio_lanzamiento, genero, sinopsis, Director_ID, Pais_Origen, Duracion, ID_Calificacion, ID_Idioma) VALUES 
						(6,'Interestellar', 2014, 'Ciencia ficcion', 'gran pelicula the best', 4,'Estados Unidos', 230, 5, 1);

DELETE FROM Pelicula WHERE id_pelicula = 6;

UPDATE nacionalidad SET nombre = 'Colombia' WHERE id_nacionalidad = 3;

CREATE TABLE Actor (
    ID_Persona INT PRIMARY KEY,
    Genero VARCHAR(50),
    Experiencia VARCHAR(255),
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID_Persona)
);

SELECT * FROM Actor AS Di LEFT JOIN Persona AS Pe ON Di.id_persona = Pe.id_persona;

SELECT * FROM Produccion;

CREATE TABLE Director (
    ID_Persona INT PRIMARY KEY,
    Premios VARCHAR(50),
    Estilo_direccion VARCHAR(255),
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID_Persona)
);

SELECT * FROM Director AS Di LEFT JOIN Persona AS Pe ON Di.id_persona = Pe.id_persona;


CREATE TABLE Direccion (
    Pelicula_ID INT,
    Director_ID INT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    PRIMARY KEY (Pelicula_ID, Director_ID),
    FOREIGN KEY (Pelicula_ID) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (Director_ID) REFERENCES Persona(ID_Persona)
);

SELECT * FROM Direccion;

CREATE TABLE Nacionalidad (
    ID_Nacionalidad SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) UNIQUE
);

SELECT * FROM Nacionalidad;
TRUNCATE TABLE Nacionalidad; 

CREATE TABLE Actor_Nacionalidad (
    ID_Persona INT,
    ID_Nacionalidad INT,
	ID_Nacionalidad_2 INT,
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID_Persona),
    FOREIGN KEY (ID_Nacionalidad) REFERENCES Nacionalidad(ID_Nacionalidad),
    PRIMARY KEY (ID_Persona, ID_Nacionalidad)
);

DELETE FROM Actor_Nacionalidad;

ALTER TABLE Actor_Nacionalidad
ADD COLUMN ID_Nacionalidad_2 INT;

ALTER TABLE Pelicula ALTER COLUMN Director_ID SET NOT NULL;

INSERT INTO Actor_Nacionalidad (ID_Persona,ID_Nacionalidad,ID_Nacionalidad_2) 
VALUES
(1, 1, 1),
(2, 1, 3),
(5, 1, 1),
(3, 1, 2),
(4, 1, 1);

SELECT * FROM Actor_Nacionalidad;

CREATE TABLE Actuacion (
    Pelicula_ID INT,
    ID_Persona INT,
    Personaje_Interpretado VARCHAR(255),
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    PRIMARY KEY (Pelicula_ID, ID_Persona),
    FOREIGN KEY (Pelicula_ID) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (ID_Persona) REFERENCES Persona(ID_Persona)
);

CREATE TABLE Estudio (
    ID_Estudio INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Pais VARCHAR(100),
    Anio_Fundacion INT,
    Tipo_Estudio VARCHAR(100)
);

CREATE TABLE Produccion (
    ID_Estudio INT,
    ID_Pelicula INT,
    Descripcion VARCHAR(255),
    FOREIGN KEY (ID_Estudio) REFERENCES Estudio(ID_Estudio),
    FOREIGN KEY (ID_Pelicula) REFERENCES Pelicula(ID_Pelicula)
);

CREATE TABLE Critico (
    ID_Critico INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Ocupacion VARCHAR(100),
    Experiencia VARCHAR(100)
);

SELECT * FROM Critico;

CREATE TABLE Critico_Twitter (
    ID_Critico INT,
    Twitter_Handle VARCHAR(100),
    FOREIGN KEY (ID_Critico) REFERENCES Critico(ID_Critico),
    PRIMARY KEY (ID_Critico, Twitter_Handle)
);

SELECT * FROM Critico_Twitter;

CREATE TABLE Critica (
    ID_Critica INT PRIMARY KEY,
    Texto_Critica TEXT,
    Puntuacion DECIMAL(3, 1),
    Fecha_Publicacion DATE,
    Fuente_Critica VARCHAR(255),
    Pelicula_ID INT,
    Critico_ID INT,
    FOREIGN KEY (Pelicula_ID) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (Critico_ID) REFERENCES Critico(ID_Critico)
);

CREATE TABLE Critica_Pelicula (
    ID_Pelicula INT,
    ID_Critica INT,
    Descripcion TEXT,
    FOREIGN KEY (ID_Pelicula) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (ID_Critica) REFERENCES Critica(ID_Critica),
    PRIMARY KEY (ID_Pelicula, ID_Critica)
);

CREATE TABLE RelacionPelicula (
    Pelicula_ID_Anterior INT,
    Pelicula_ID_Siguiente INT,
    Tipo_Relacion VARCHAR(100),
    Descripcion TEXT,
    PRIMARY KEY (Pelicula_ID_Anterior, Pelicula_ID_Siguiente),
    FOREIGN KEY (Pelicula_ID_Anterior) REFERENCES Pelicula(ID_Pelicula),
    FOREIGN KEY (Pelicula_ID_Siguiente) REFERENCES Pelicula(ID_Pelicula),
    CHECK (Tipo_Relacion IN ('Similaridad','Secuela', 'Precuela'))
);

-----------------------------------------Registros de todas las tablas------------------------------

-- Agregar datos a la tabla Calificacion
INSERT INTO Calificacion (ID_Calificacion, Valor) VALUES 
	(1, '1.0'), 
	(2, '3.0'), 
	(3, '4.0'), 
	(4, '2.0'), 
	(5, '5.0');

-- Agregar datos a la tabla Idioma
INSERT INTO Idioma (ID_Idioma, Nombre) VALUES 
	(1, 'Inglés'), 
	(2, 'Español'), 
	(3, 'Francés'), 
	(4, 'Alemán'), 
	(5, 'Italiano');

-- Agregar datos a la tabla Persona (actores y directores)
INSERT INTO Persona (ID_Persona, Nombre, Fecha_Nacimiento, Nacionalidad) VALUES
(1, 'Brad Pitt', '1963-12-18', 'Estados Unidos'),
(2, 'Leonardo DiCaprio', '1974-11-11', 'Estados Unidos'),
(3, 'Quentin Tarantino', '1963-03-27', 'Estados Unidos'),
(4, 'Martin Scorsese', '1942-11-17', 'Estados Unidos'),
(5, 'Scarlett Johansson', '1984-11-22', 'Estados Unidos');

-- Agregar datos a la tabla Pelicula
INSERT INTO Pelicula (ID_Pelicula, Titulo, Anio_Lanzamiento, Genero, Sinopsis, Director_ID, Pais_Origen, Duracion, ID_Calificacion, ID_Idioma) VALUES
(1, 'Pulp Fiction', 1994, 'Crimen, Drama', 'Historias interrelacionadas en el bajo mundo de Los Ángeles.', 3, 'Estados Unidos', 154, 1, 1),
(2, 'Inception', 2010, 'Acción, Ciencia Ficción', 'Un ladrón es capaz de entrar en los sueños de otros.', 4, 'Estados Unidos', 148, 5, 1),
(3, 'Goodfellas', 1990, 'Crimen, Drama', 'La vida de un gánster italoamericano en Nueva York.', 4, 'Estados Unidos', 146, 4, 1),
(4, 'Lost in Translation', 2003, 'Drama', 'Un actor y una mujer casada se encuentran en Tokio.', 4, 'Estados Unidos', 102, 3, 2),
(5, 'Avengers: Endgame', 2019, 'Acción, Aventura', 'Los Vengadores intentan revertir el daño causado por Thanos.', 5, 'Estados Unidos', 181, 5, 1);

-- Agregar datos a la tabla Actor
INSERT INTO Actor (ID_Persona, Genero, Experiencia) VALUES
(1, 'Masculino', '30 años de experiencia en la industria cinematográfica.'),
(2, 'Masculino', 'Reconocido actor con múltiples premios.'),
(5, 'Femenino', 'Conocida por sus roles en películas de acción y drama.');

-- Agregar datos a la tabla Director
INSERT INTO Director (ID_Persona, Premios, Estilo_direccion) VALUES
(3, 'Oscar al Mejor Guion Original', 'Estilo único y característico.'),
(4, 'Oscar al Mejor Director', 'Maestro del cine moderno.');

INSERT INTO Director (ID_Persona, Premios, Estilo_direccion) VALUES
(6, 'Oscar ', 'Estilo único .'),

INSERT INTO Direccion (Pelicula_ID, Director_ID, Fecha_Inicio, Fecha_Fin) VALUES
(1, 3, '1993-05-10', '1993-09-10'),
(2, 4, '2009-06-15', '2009-12-20'),
(3, 4, '1989-10-01', '1990-03-15'),
(4, 4, '2002-08-25', '2003-01-15'),
(5, 5, '2017-01-10', '2017-07-15');

-- Agregar datos a la tabla Nacionalidad
INSERT INTO Nacionalidad (ID_Nacionalidad, Nombre) VALUES 
	(1, 'Estados Unidos'), 
	(2, 'Francia'), 
	(3, 'Alemania');

-- Agregar datos a la tabla Actor_Nacionalidad
INSERT INTO Actor_Nacionalidad (ID_Persona, ID_Nacionalidad) VALUES
(1, 1), (2, 1), (5, 1), (3, 1), (4, 1);

-- Agregar datos a la tabla Actuacion
INSERT INTO Actuacion (Pelicula_ID, ID_Persona, Personaje_Interpretado, Fecha_Inicio, Fecha_Fin) VALUES
(2, 2, 'Dom Cobb', '2009-06-15', '2009-12-20'),
(3, 1, 'Tommy DeVito', '1989-10-01', '1990-03-15'),
(5, 5, 'Natasha Romanoff / Black Widow', '2017-01-10', '2017-07-15');

-- Agregar datos a la tabla Estudio
INSERT INTO Estudio (ID_Estudio, Nombre, Pais, Anio_Fundacion, Tipo_Estudio) VALUES
(1, 'Miramax Films', 'Estados Unidos', 1979, 'Estudio de cine independiente'),
(2, 'Universal Pictures', 'Estados Unidos', 1912, 'Estudio de cine y televisión'),
(3, 'Paramount Pictures', 'Estados Unidos', 1912, 'Estudio de cine y televisión');

-- Agregar datos a la tabla Produccion
INSERT INTO Produccion (ID_Estudio, ID_Pelicula, Descripcion) VALUES
(1, 1, 'Producida por Quentin Tarantino y Lawrence Bender.'),
(2, 2, 'Producida por Christopher Nolan y Emma Thomas.'),
(3, 3, 'Producida por Martin Scorsese y Irwin Winkler.'),
(3, 4, 'Producida por Sofia Coppola y Ross Katz.'),
(2, 5, 'Producida por Kevin Feige.');

-- Agregar datos a la tabla Critico
INSERT INTO Critico (ID_Critico, Nombre, Ocupacion, Experiencia) VALUES
(1, 'Roger Ebert', 'Crítico de cine', '45 años de experiencia en la crítica cinematográfica.'),
(2, 'Peter Travers', 'Periodista', 'Editor en jefe de la revista Rolling Stone.'),
(3, 'A.O. Scott', 'Crítico de cine', 'Crítico en The New York Times durante más de 20 años.'),
(4, 'Lisa Schwarzbaum', 'Crítica de cine', 'Ha trabajado en Entertainment Weekly durante más de 25 años.'),
(5, 'Kenneth Turan', 'Crítico de cine', 'Autor y crítico de cine en Los Angeles Times desde 1991.');

-- Agregar datos a la tabla Critico_Twitter
INSERT INTO Critico_Twitter (ID_Critico, Twitter_Handle) VALUES
(1, '@ebertchicago'), (2, '@petertravers'), (3, '@aoscott'), (4, '@lisaschwarzbaum'), (5, '@KennethTuran');

-- Agregar datos a la tabla Critica
INSERT INTO Critica (ID_Critica, Texto_Critica, Puntuacion, Fecha_Publicacion, Fuente_Critica, Pelicula_ID, Critico_ID) VALUES
(1, 'Una obra maestra del cine independiente.', 4.5, '1994-10-14', 'Chicago Sun-Times', 1, 1),
(2, 'Una de las mejores películas de ciencia ficción de la década.', 4.8, '2010-07-16', 'Rolling Stone', 2, 2),
(3, 'Una visión auténtica del crimen organizado en los años 80.', 4.2, '1990-09-21', 'The New York Times', 3, 3),
(4, 'Una película emotiva con actuaciones sobresalientes.', 4.3, '2003-09-12', 'The New York Times', 4, 4),
(5, 'Una conclusión épica para la saga de los Vengadores.', 4.7, '2019-04-26', 'The Hollywood Reporter', 5, 5);

INSERT INTO Critica_Pelicula (ID_Pelicula, ID_Critica, Descripcion) VALUES
(1, 1, 'Ganadora de la Palma de Oro en el Festival de Cannes.'),
(2, 2, 'Nominada al Premio de la Academia a la Mejor Película.'),
(3, 3, 'Ganadora del Premio BAFTA a la Mejor Película.'),
(4, 4, 'Nominada a 4 Premios de la Academia, incluyendo Mejor Actor y Actriz de Reparto.'),
(5, 5, 'La película más taquillera de todos los tiempos.');

INSERT INTO RelacionPelicula (Pelicula_ID_Anterior, Pelicula_ID_Siguiente, Tipo_Relacion, Descripcion) VALUES
(1, 2, 'Secuela', 'Inception es una secuela espiritual de Pulp Fiction.'),
(3, 4, 'Precuela', 'Lost in Translation es una precuela no oficial de Goodfellas.'),
(4, 5, 'Secuela', 'Avengers: Endgame es la secuela directa de Lost in Translation.');

SELECT * FROM Persona;
SELECT * FROM actuacion;
SELECT * FROM actor_nacionalidad;
SELECT * FROM nacionalidad;
SELECT * FROM Calificacion;
SELECT * FROM idioma;
SELECT * FROM Calificacion;
SELECT * FROM Actor;
---------Listar o seleccionar registros------

SELECT * FROM Persona WHERE id_persona = 1;
SELECT * FROM Persona WHERE nombre = 'Brad Pitt';
SELECT * FROM Persona Where nombre = 'Leonardo DiCaprio' AND nacionalidad = 'Estados Unidos';


-----------ACTUALIZAR REGISTROS--------------

UPDATE Persona SET nombre = 'Alejandro Pitt' WHERE id_persona = 1;

---------INSERTAR DATOS-------------------
ALTER tabla Persona MODIFY COLUMN id_Persona int auto_incment

INSERT INTO Persona (nombre, fecha_nacimiento, nacionalidad) VALUES
					('Jennifer Aniston','1985','Estados Unidos');

------------------BORRAR REGISTROS-------------------
DELETE FROM Persona WHERE id_persona = 4;


---------------SEELECCIONAR COLUMNA DE MISMA TABLA-----
SELECT id_persona, nombre FROM Persona;
----------CAMBIAR NOMBRE DE LAS COLUMNAS------------------
SELECT id_persona, nombre AS names_personas FROM Persona;
-----------RENOMBRAR TABLAS--------------------
RENAME TABLA Persona to Persons;

------------SELECCIONAR COlUMNAS CON DIFERENTES TABLAS-----
SELECT p.id_persona, p.nombre, a.genero FROM Persona p LEFT JOIN Actor a on p.id_persona = a.id_persona;