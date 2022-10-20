-- BASE DE DATOS FUTBOLCLUB
--Creacion de la Base de Datos -----------------------------------------------------------------------------------------------------------
CREATE DATABASE Lab_3_FitClub

--Creacion de la Tabla Instructor --------------------------------------------------------------------------------------------------------
CREATE TABLE Instructor
(
	ced_instructor CHAR(13) NOT NULL,
		CONSTRAINT CED_INSTRUCTOR_CONSTRAINT CHECK (ced_instructor LIKE '[0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
		CONSTRAINT CED_INSTRUCTOR_PK PRIMARY KEY (ced_instructor),
	nom_instructor VARCHAR(30),
	domicilio_instructor VARCHAR(80)
);

--Creacion de la Tabla Socio --------------------------------------------------------------------------------------------------------------
CREATE TABLE Socio
(
	ced_socio CHAR(13) NOT NULL,
		CONSTRAINT CED_SOCIO_CONSTRAINT CHECK (ced_socio LIKE '[0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
		CONSTRAINT CED_SOCIO_PK PRIMARY KEY (ced_socio),
	no_socio INT IDENTITY(1000, 1),
		CONSTRAINT NO_SOCIO_UK UNIQUE (no_socio),
	nom_socio VARCHAR(30),
	domicilio_socio VARCHAR(80)
);

--Creacion de la Tabla Categoria ----------------------------------------------------------------------------------------------------------
CREATE TABLE Categoria
(
	cod_categoria CHAR(5) NOT NULL,
		CONSTRAINT COD_CATEGORIA_PK PRIMARY KEY (cod_categoria),
	nom_categoria VARCHAR(15),
		CONSTRAINT NOM_CATEGORIA_CONSTRAINT CHECK (nom_categoria IN ('maquina', 'baile', 'speeding', 'pesas')),
	dia_asignado VARCHAR(10),
		CONSTRAINT DIA_ASIGNADO_CATEGORIA_CONSTRAINT CHECK (dia_asignado IN ('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado')),
		--CONSTRAINT DIA_ASIGNADO_CATEGORIA_DEFAULT DEFAULT 'sábado',
	instructor CHAR(13),
		CONSTRAINT INSTRUCTOR_FK FOREIGN KEY (instructor) REFERENCES Instructor (ced_instructor) ON DELETE CASCADE
);

--Creacion de la Tabla Instcripcion -------------------------------------------------------------------------------------------------------
CREATE TABLE Inscripcion
(
	ced_socio CHAR(13) NOT NULL,
	cod_categoria CHAR(5) NOT NULL,
		CONSTRAINT CED_SOCIO_INSCRIPCION_CONSTRAINT CHECK (ced_socio LIKE '[0-9][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
		CONSTRAINT CED_AND_COD_INSCRIPCION_PK PRIMARY KEY (ced_socio, cod_categoria),
		CONSTRAINT CED_INSCRIPCION_FK FOREIGN KEY (ced_socio) REFERENCES Socio (ced_socio) ON DELETE CASCADE,
		CONSTRAINT COD_INSCRIPCION_FK FOREIGN KEY (cod_categoria) REFERENCES Categoria (cod_categoria),
	estado_matricula VARCHAR(15),
		CONSTRAINT ESTADO_MATRICULA_CONSTRAINT CHECK (estado_matricula = 's' OR estado_matricula = 'n'),
		--CONSTRAINT ESTADO_MATRICULA_DEFAULT DEFAULT 'n',
	monto_matricula MONEY,
		CONSTRAINT MONTO_MATRICULA_CONSTRAINT CHECK (monto_matricula >= 0)
);

--Solucion de Asignacion de Default de la Tabla Categoria ---------------------------------------------------------------------------------
ALTER TABLE Categoria
	ADD CONSTRAINT DIA_ASIGNADO_CATEGORIA_DEFAULT DEFAULT 'sábado' FOR dia_asignado

 --Solucion de Asignacion de Default de la Tabla Inscripcion -------------------------------------------------------------------------------
ALTER TABLE Inscripcion
	ADD CONSTRAINT ESTADO_MATRICULA_DEFAULT DEFAULT 'n' FOR estado_matricula

 --Insercion de datos a la Tabla Socio -----------------------------------------------------------------------------------------------------
 INSERT INTO Socio (ced_socio, nom_socio, domicilio_socio)
 VALUES 
	('08-0987-09876', 'Andrés Araúz', 'Avenida 111'),
	('09-0076-06554', 'Bertina Bustamante', 'Balboa 222'),
	('07-0987-98769', 'Carlos Camarena', 'Colon 333'),
	('08-1111-22222', 'Luis Cortés', 'Villa Lucre'),
	('09-7777-00023', 'Pedro Jaen', 'Don Bosco'),
	('08-9999-34343', 'Rosa Filos', 'La Castallena')

SELECT *
FROM Socio

 --Insercion de datos a la Tabla Instructor -----------------------------------------------------------------------------------------------
 INSERT INTO Instructor(ced_instructor, nom_instructor, domicilio_instructor)
 VALUES 
	('08-0775-02222', 'Ana López', 'Paical 2345'),
	('04-9555-98989', 'Lorenzo González', 'San Miguelito 4'),
	('07-3333-12345', 'Ernesto Arosemena', 'La Castallena')

SELECT *
FROM Instructor

 --Insercion de datos a la Tabla Categoria -----------------------------------------------------------------------------------------------
 INSERT INTO Categoria
 VALUES 
	('1', 'Maquina', 'lunes', '07-3333-12345'),
	('2', 'Baile', null, '08-0775-02222'),
	('3', 'Speeding', 'miércoles', '04-9555-98989'),
	('4', 'Pesas', 'viernes', '07-3333-12345')

--Default Tabla Categoria
INSERT INTO Categoria (cod_categoria,nom_categoria, instructor)
VALUES ('5', 'Maquina', '07-3333-12345')

SELECT *
FROM Categoria

 --Insercion de datos a la Tabla Inscripcion -----------------------------------------------------------------------------------------------
 INSERT INTO Inscripcion
 VALUES ('08-0987-09876','1', 's', '0')

 --pago negativo - solucion: pago positivo
 INSERT INTO Inscripcion
 VALUES ('09-0076-06554','1', 'n', '15')

 -- valor de matricula invalido - solucion: arreglo de matricula
 INSERT INTO Inscripcion
 VALUES ('07-0987-98769','2', 's', '100')

 INSERT INTO Inscripcion
 VALUES ('08-1111-22222','4', 's', '150')

 INSERT INTO Inscripcion
 VALUES ('09-7777-00023','3', 's', '75')

 INSERT INTO Inscripcion
 VALUES ('07-0987-98769','1', 'n', '35')

 INSERT INTO Inscripcion
 VALUES ('08-0987-09876','2', 's', '100')
 
 --socio no existente - solucion: cedula de socio existente
 INSERT INTO Inscripcion
 VALUES ('08-9999-34343','1', 's', '150')

 INSERT INTO Inscripcion
 VALUES ('07-0987-98769','5', 's', '100')

 --repeticion de llaves - solucion: cambio de categoria
 INSERT INTO Inscripcion
 VALUES ('08-0987-09876','3', 's', '145')

 SELECT * 
 FROM Inscripcion

--El instructor Lorenzo González ha renunciado.  En su lugar tendremos a: -----------------------------------------------------------
--Modificacion de Constraint 
ALTER TABLE Categoria
	DROP CONSTRAINT INSTRUCTOR_FK 

ALTER TABLE Categoria
	ADD CONSTRAINT INSTRUCTOR_FK FOREIGN KEY (instructor) REFERENCES Instructor (ced_instructor) ON DELETE CASCADE ON UPDATE CASCADE 
 
 --Opcion ON DELETE
 /* DELETE FROM Instructor
 WHERE nom_instructor = 'Lorenzo González'*/

 UPDATE Instructor
 SET 
	 ced_instructor = '03-3333-33333', 
	 nom_instructor = 'Carlos Gómez', 
	 domicilio_instructor = 'Villa Verónica'
 WHERE 
	 nom_instructor = 'Lorenzo González'

SELECT *
FROM Instructor

SELECT *
FROM Categoria

--El  socio 08-0987-09876 se retiró del gimnasio --------------------------------------------------------------------------------------------
DELETE FROM Socio
	WHERE ced_socio = '08-0987-09876'

SELECT *
FROM Socio

SELECT *
FROM Inscripcion