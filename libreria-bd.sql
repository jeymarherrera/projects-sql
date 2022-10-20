-- DATABASE LIBRERIA
--1-	Cree la base de datos LAB_2.  Y a proceda a crear dentro de ésta, la tabla llamada libros que contiene los siguientes atributos:
--cod_lib (entero) defina el código como llave primaria 
--espec (cadena 15)
--titulo (cadena de 30 caracteres de longitud y no nulo) 
--autor (cadena de 20), 
--editorial (cadena de 15)  y 
--precio (float)

CREATE DATABASE Lab_2

CREATE TABLE Libro
(
	cod_libro INT 
		CONSTRAINT COD_LIBRO_PK PRIMARY KEY (cod_libro),
	espec VARCHAR(15),
	titulo VARCHAR(30) NOT NULL,
	autor VARCHAR(20),
	editorial VARCHAR(15),
	precio FLOAT
);

--2-	Ingrese los siguientes datos a la tabla
INSERT INTO Libro
VALUES
(100, 'sistemas', 'Fundamentos de Base de Datos', 'Elmarsi', 'McGraw Hill', 45.00),
(101, 'sistemas', 'Sistemas de Base de Datos', 'Connolly', 'Pearson', 30),
(302, 'literatura', 'Cervantes y el Quijote', 'Borges', 'Elmerce', 25),
(204, 'matemáticas', 'Calculo Diferencial e Integral', 'Hernández', 'Pearson', 35.25),
(106, 'literatura', 'Aprenda Sql ya', 'Riordan', 'McGraw Hill', 90.99)

SELECT * 
FROM Libro

--3- Modifique el registro cuyo autor sea igual  a "Connolly", por "Connolly y Begg" .  Muestre  como realizo el cambio y como quedo ahora su tabla.
UPDATE Libro
SET autor = 'Connolly y Begg'
WHERE autor = 'Connolly'

SELECT *
FROM Libro
 
 --4.	 Nuevamente se detecta un error en los datos que requiere modificación. El libro con código 106 es del área de sistemas y se registró como de literatura.  Muestre como realiza el cambio  y como quedan ahora sus datos en la tabla
UPDATE Libro
SET espec = 'sistemas'
WHERE cod_libro = 106

--5. Actualice el precio del libro de "Borges " a 27  dólares.  Muestre como hizo el cambio y muestre los datos
UPDATE Libro
SET precio = 27
WHERE autor = 'Borges'

SELECT *
FROM Libro

--6- Actualice todos los registros que contengan en el campo editorial el valor  "McGraw Hill" por MGH.  Muestre como realizo la actualización y la tabla resultante.
UPDATE Libro
SET editorial = 'MGH'
WHERE editorial = 'McGraw Hill'

SELECT *
FROM Libro

--7.	  Primero crearemos la tabla de Editoriales, que contendrá un código de editorial y el nombre de la editorial.  Seguir instrucciones detalladas en párrafo siguiente, para tal fin
CREATE TABLE Editoriales
(
	codigo_editorial INT IDENTITY
		CONSTRAINT CODIGO_EDITORIAL_PK PRIMARY KEY (codigo_editorial),
	nombre_editorial VARCHAR(15)
);

INSERT INTO Editoriales(nombre_editorial)
SELECT DISTINCT editorial
FROM Libro

SELECT *
FROM Editoriales

--8 - Ahora proceda a crear la tabla de especialidades.  Esta tabla tendrá un código de especialidad (generado automáticamente con IDENTITY) y el nombre de la especialidad.  
CREATE TABLE Especialidades
(
	codigo_especialidad INT IDENTITY
		CONSTRAINT CODIGO_ESPECIALIDAD_PK PRIMARY KEY (codigo_especialidad),
	nombre_especialidad VARCHAR(15)
);

INSERT INTO Especialidades(nombre_especialidad)
SELECT DISTINCT espec
FROM Libro

SELECT *
FROM Especialidades

--9 -  Ahora debemos incorporar a la tabla libro los códigos que permiten hacer la conexión a las tablas especialidad y editorial respectivamente
ALTER TABLE Libro
ADD cod_editorial INT, cod_espec INT

UPDATE Libro
SET cod_editorial = CASE editorial
WHEN 'Elmerce' THEN 1
WHEN 'MGH' THEN 2
WHEN 'Pearson' THEN 3
END 

UPDATE Libro
SET cod_espec = CASE espec
WHEN 'literatura' THEN 1
WHEN 'matemáticas' THEN 2
WHEN 'sistemas' THEN 3
END 

--10.  Luego de hacer el enlace respectivo, debe borrar de la tabla libros las columnas con el nombre de la  editorial y el nombre de especialidad.( NOTA:  Si lo hace antes, no tendrá forma de poder hacer la conexión).   
ALTER TABLE Libro
DROP COLUMN espec, editorial

SELECT *
FROM Libro

--11.  Realice los enlaces de integridad referencial (unión de tablas PK con FK) a través de un sólo alter que separe con comas (,) los dos constraint adicionados.
ALTER TABLE Libro
	ADD CONSTRAINT COD_EDITORIAL_FK  FOREIGN KEY (cod_editorial) REFERENCES Editoriales (codigo_editorial),
	CONSTRAINT COD_ESPECIALIDAD_FK  FOREIGN KEY (cod_espec) REFERENCES Especialidades (codigo_especialidad)

--12- Proceda a borrar todos los datos de la tabla de editoriales con el DELETE.  Muestre los comandos que fueron necesarios para tal fin y con un select muestre la tabla vacía.
DELETE FROM Editoriales

ALTER TABLE Libro
   NOCHECK  CONSTRAINT COD_EDITORIAL_FK

DELETE FROM Editoriales

SELECT *
FROM Editoriales

ALTER TABLE Libro
   CHECK  CONSTRAINT COD_EDITORIAL_FK

--13- Proceda a insertar los datos Elmerse, MGH y Pearson como nuevas editoriales.  (recuerde que la tabla tiene definida un identity para el código, por lo que no debemos captarlo).  Liste los valores insertados.  Que observa con el dato generado por el identity?
INSERT INTO Editoriales(nombre_editorial)
VALUES ('Elmerse'), ('MGH'), ('Pearson')

SELECT *
FROM Editoriales

--14.  Proceda a borrar todos los datos de la tabla de editoriales con el TRUNCATE TABLE.  Muestre los comandos que  fueron necesarios para tal fin y la tabla vacía.
TRUNCATE TABLE Editoriales

ALTER TABLE Libro
   DROP  CONSTRAINT COD_EDITORIAL_FK

ALTER TABLE Editoriales
   DROP CONSTRAINT CODIGO_EDITORIAL_PK

TRUNCATE TABLE Editoriales

SELECT *
FROM Editoriales

--15. - Proceda a insertar los datos Elmerse, MGH y Pearson como nuevas editoriales.  (recuerde que la tabla tiene definida un identity para el código, por lo que no debemos captarlo).  Liste los valores insertados.  Que observa con el dato generado por el identity?  
INSERT INTO Editoriales(nombre_editorial)
VALUES ('Elmerse'), ('MGH'), ('Pearson')

SELECT *
FROM Editoriales

--16. Que instrucción necesita para borrar la estructura de la tabla.  Borre las tres tablas.  Muestre instrucción necesaria y  capture el  explorador de objetos, mostrando que no existen ya las tabla.
ALTER TABLE Libro
   DROP  CONSTRAINT COD_ESPECIALIDAD_FK

ALTER TABLE Editoriales
   DROP CONSTRAINT CODIGO_ESPECIALIDAD_PK
 
 DROP TABLE Editoriales
 DROP TABLE Especialidades
 DROP TABLE Libro

 --PRUEBA PROCEDURE
 CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
)  ENGINE=INNODB;

DELIMITER $$
CREATE PROCEDURE load_book_data(IN num INT(4))
BEGIN
	DECLARE counter INT(4) DEFAULT 0;
	DECLARE book_title VARCHAR(255) DEFAULT '';

	WHILE counter < num DO
	  SET book_title = CONCAT('Book title #',counter);
	  SET counter = counter + 1;

	  INSERT INTO books(title)
	  VALUES(book_title);
	END WHILE;
END$$

DELIMITER ;

CALL load_book_data(10000);

SELECT * FROM books;

TRUNCATE TABLE books;

--17- Borre la base de datos.  Muestre instrucción y explorador de objetos.
USE master
DROP DATABASE Lab_2

