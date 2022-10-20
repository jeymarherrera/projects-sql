--DATABASE EMPRESA
--2. Cree la Base de datos llamada Empresa.  Muestre los comandos que uso para tal fin y su ejecución exitosa.
CREATE DATABASE Empresa

--3. Proceda a crear las tablas que componen la BD Empresa. Muestre los scrip de creación de éstas.
CREATE TABLE Empleado
(
   nss CHAR(9) NOT NULL UNIQUE,
		CONSTRAINT Empleado_NSS_PK PRIMARY KEY (nss),
   nombre VARCHAR(15) NOT NULL,
   inic CHAR(1), 
   apellido VARCHAR(15) NOT NULL, 
   fecha_ncto DATE NOT NULL, 
   direccion VARCHAR(30),
   sexo CHAR(1),
		CONSTRAINT CHECK_SEXO CHECK (sexo = 'F' OR sexo = 'M'),
   salario MONEY,
   nss_superv CHAR(9),
		CONSTRAINT Empleado_NSS_SUPERV_FK FOREIGN KEY (nss_superv) REFERENCES Empleado (nss),
   nd INT NOT NULL
		
)
--DEPARTAMENTO
CREATE TABLE Departamento
(
	numerod INT NOT NULL,
		CONSTRAINT Departamento_NUMEROD_PK PRIMARY KEY (numerod),
	nombred VARCHAR(15) NOT NULL,
	nss_jefe CHAR(9) NOT NULL
		CONSTRAINT Departamento_NSS_JEFE_FK  FOREIGN KEY (nss_jefe) REFERENCES Empleado (nss),
	fecha_inic_jefe DATE
)

--LOCALIDAD
CREATE TABLE Localizacion
(
	numerod INT NOT NULL,
	localizaciond VARCHAR(15) NOT NULL,
		CONSTRAINT Localizacion_NUMEROD_PK PRIMARY KEY (numerod, localizaciond),
		CONSTRAINT Localizacion_NUMEROD_FK  FOREIGN KEY (numerod) REFERENCES Departamento (numerod)
)

--DEPENDIENTE
CREATE TABLE Dependiente
(
	nsse CHAR(9) NOT NULL,
	nombre_dependiente VARCHAR(15),
		CONSTRAINT Dependiente_NSEE_PK PRIMARY KEY (nsse, nombre_dependiente),
		CONSTRAINT Dependiente_NSSE_FK  FOREIGN KEY (nsse) REFERENCES Empleado (nss),
	sexo CHAR(1),
		CONSTRAINT CHECK_SEXO_DEPENDIENTE CHECK (sexo = 'F' OR sexo = 'M'),
	fecha_ncto DATE,
	parentesco VARCHAR(9) NOT NULL
)
--PROYECTO
CREATE TABLE Proyecto
(
	numerop INT NOT NULL UNIQUE, 
		CONSTRAINT Proyecto_NUMEROP_PK PRIMARY KEY (numerop),
	nombrep VARCHAR(15) NOT NULL,
	localizacionp VARCHAR(15),
	numd INT NOT NULL,
		CONSTRAINT Proyecto_NUMD_FK  FOREIGN KEY (numd) REFERENCES Departamento (numerod)
)

-- RELACION TRABAJA EN
CREATE TABLE Trabaja_en
(
	nsse CHAR(9) NOT NULL,
	np INT NOT NULL,
		CONSTRAINT Trabaja_en_NSSE_PK PRIMARY KEY (nsse, np),
		CONSTRAINT Trabaja_en_NSSE_FK  FOREIGN KEY (nsse) REFERENCES Empleado (nss),
		CONSTRAINT Trabaja_en_NP_FK  FOREIGN KEY (np) REFERENCES Proyecto (numerop),
	horas DECIMAL(3,1)
)

--CAMBIO
ALTER TABLE Empleado
ADD CONSTRAINT Empleado_ND_FK FOREIGN KEY (nd) REFERENCES Departamento (numerod)

--5.Inserte los tres primeros registros de la tabla Departamento (Los datos   aparecen al final de la guía).  Muestre los insert realizados
INSERT INTO Departamento
VALUES 
(5,'Investigación','333445555', '1988-05-22'),
(4,'Administración','897654321', '1985-01-01'),
(1,'Dirección','888665555', '1981-06-19')

--6. Ahora  inserte los datos a la tabla Departamento.  Si es necesario BORRE (drop) los constraint que interfieren con la insercion. Muestre todas las instrucciones realizadas para insertar los datos  y realice un select a la tabla para ver su contenido.
ALTER TABLE Departamento
	DROP CONSTRAINT Departamento_NSS_JEFE_FK

INSERT INTO Departamento
VALUES 
(5,'Investigación','333445555', '1988-05-22'),
(4,'Administración','897654321', '1985-01-01'),
(1,'Dirección','888665555', '1981-06-19')

SELECT * 
FROM Departamento


--7. Ahora proceda a insertar las tres primeras tuplas (filas) de datos a la tabla Empleado.  Qué ocurre?  Explique qué pasó.  Si le mando error, presente la captura del error.
INSERT INTO Empleado
VALUES 
('123456789','John', 'B', 'Smith', '1965-01-09', '731 Fondren, Houston, TX', 'H', 30000, '333445555', 5),
('333445555','Franklin', 'T', 'Wong', '1955-12-08', '638 Voss, Houston, TX', 'H', 40000, '888665555', 5),
('999887777','Alicia', 'J', 'Zelaya', '1968-07-19', '3321 Castle, Spring, TX', 'M', 25000, '987654321', 4)

--8. Haga lo necesario para insertar los tres empleados y muestre las instrucciones necesarias y con un select liste los datos.  EXPLIQUE
ALTER TABLE Empleado
	DROP CONSTRAINT CHECK_SEXO

ALTER TABLE Empleado
	DROP CONSTRAINT Empleado_ND_FK

ALTER TABLE Empleado
	DROP CONSTRAINT Empleado_NSS_SUPERV_FK

INSERT INTO Empleado
VALUES 
('123456789','John', 'B', 'Smith', '1965-01-09', '731 Fondren, Houston, TX', 'H', 30000, '333445555', 5),
('333445555','Franklin', 'T', 'Wong', '1955-12-08', '638 Voss, Houston, TX', 'H', 40000, '888665555', 5),
('999887777','Alicia', 'J', 'Zelaya', '1968-07-19', '3321 Castle, Spring, TX', 'M', 25000, '987654321', 4)

SELECT *
FROM Empleado

--9. Ahora incluya a todos los supervisores (faltan Jennifer y James).  Muestre los insert realizados y todos los datos que en este momento tiene la tabla
INSERT INTO Empleado
VALUES 
('987654321','Jennifer', 'S', 'Wallace', '1941-06-20', '291 Berry, Bellaire, TX', 'M', 43000, '888665555', 4),
('888665555','James', 'E', 'Borg', '1937-11-10', '450 Stone, Houston, TX', 'H', 55000, null, 1)

SELECT *
FROM Empleado

--10. Si para insertar quitó o deshabilitó algún constraint, vuelva a activarlo o ponerlo

ALTER TABLE Departamento
	ADD CONSTRAINT Departamento_NSS_JEFE_FK FOREIGN KEY (nss_jefe) REFERENCES Empleado (nss)

ALTER TABLE Empleado
	ADD CONSTRAINT Empleado_NSS_SUPERV_FK FOREIGN KEY (nss_superv) REFERENCES Empleado (nss)
	
ALTER TABLE Empleado
	ADD CONSTRAINT Empleado_ND_FK FOREIGN KEY (nd) REFERENCES Departamento (numerod)

--11. Muestre todos los constraint de la tabla empleados 
Sp_helpconstraint Empleado

--12. Si  el empleado John Smith renuncia por motivos personales, usted debe borrarlo de la tabla empleado.  Realice esta operación.  Qué ocurre?  Muestre sus resultados
DELETE FROM Empleado
WHERE nombre = 'John' AND  apellido = 'Smith'

SELECT *
FROM Empleado

--13. Qué ocurre si ahora borramos al empleado ‘Franklin’? Muestre sus resultados
DELETE FROM Empleado
WHERE nombre = 'Franklin' AND  apellido = 'Wong'

SELECT *
FROM Empleado

--14. Inserte los datos que hacen falta a las tablas creadas en el punto 3 de este laboratorio.  En caso de presentar problemas con las restricciones, en lugar de borrarlo, deshabilítelo usando: el nocheck constraint 

INSERT INTO Empleado
VALUES
('666884444','Ramesh', 'K', 'Narayan', '1962-09-15', '975 Fire Oak, Humble, TX', 'H', 38000, '333445555', 5),
('453453453','Joyce', 'A', 'English', '1972-07-31', '5631 Rice, Houston, TX', 'M', 25000, '333445555', 5),
('987987987','Ahmad', 'V', 'Jabbar', '1969-03-29', '980 Dallas, Houston, TX', 'H', 25000, '987654321', 4)


INSERT INTO Localizacion
VALUES(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston')


ALTER TABLE Trabaja_en
        NOCHECK  CONSTRAINT Trabaja_en_NSSE_FK

INSERT INTO Trabaja_en
VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, null)

INSERT INTO Proyecto
VALUES
(1, 'ProductX', 'Bellaire', 5),
(2, 'ProductY', 'Sugarland', 5),
(3, 'ProductZ', 'Houston', 5),
(10, 'Automatización', 'Stanfford', 4),
(20, 'Reorganización', 'Houston', 1),
(30, 'NvosBeneficios', 'Stanfford', 4)

ALTER TABLE Dependiente
        NOCHECK  CONSTRAINT CHECK_SEXO_DEPENDIENTE
ALTER TABLE Dependiente
        NOCHECK  CONSTRAINT Dependiente_NSSE_FK
INSERT INTO Dependiente
VALUES
('333445555', 'Alice', 'M', '1986-04-05', 'HIJA'),
('333445555', 'Theodore', 'H', '1983-10-25', 'HIJ0'),
('333445555', 'Joy', 'M', '1958-05-03', 'ESPOSA'),
('987654321', 'Abner', 'H', '1942-02-28', 'ESPOSA'),
('123456789', 'Michael', 'H', '1988-01-04', 'HIJO'),
('123456789', 'Alice', 'M', '1988-12-30', 'HIJA'),
('123456789', 'Elizabeth', 'M', '1967-05-05', 'ESPOSA')

ALTER TABLE Trabaja_en
        CHECK CONSTRAINT Trabaja_en_NSSE_FK

--15. Adicione a la tabla Dependiente una nueva columna llamada tipo_sangre.  Muestre como modificó la tabla y además realice un select a la tabla.
ALTER TABLE Dependiente
ADD tipo_sangre CHAR(2)

SELECT *
FROM Dependiente

--16.Incremente el salario de los empleados que ganan entre 25,000 y 30,000 (inclusive), en un 10%.  Muestre con un select los datos iniciales, la instrucción utilizada para modificar los datos  y con la ayuda de otro select, los datos modificados
SELECT *
FROM Empleado
WHERE (salario >= 25000 AND salario <= 30000)

UPDATE Empleado
	SET salario = salario + (salario * 0.10)
	WHERE (salario >= 25000 AND salario <= 30000)

SELECT *
FROM Empleado


