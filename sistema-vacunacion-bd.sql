-- PROYECTO 1 SISTEMA DE VACUNACION --

-- CREACION DE LA BASE DE DATOS --

CREATE DATABASE Sistema_Vacunacion;

USE Sistema_Vacunacion;

-- CREANDO TABLA VACUNA --

CREATE TABLE Vacuna(
	codigo_vac CHAR(3)
		CONSTRAINT PK_Vacuna_codigo_vac PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL
		CONSTRAINT CK_Vacuna_nombre CHECK(nombre IN ('Pfizer-BioNTech', 'Moderna', 'Johnson&Johnson', 'AstraZeneca', 'Sinopharm', 'Sputnik')), --Verifica que solo se ingresen los datos requeridos --
	dias_sd INT,
	num_dosis INT NOT NULL
);

-- CREANDO TABLA PROVINCIA --

CREATE TABLE Provincia(
	codigo_provincia VARCHAR(2)
		CONSTRAINT CK_Provincia_codigo_provincia 
			CHECK (codigo_provincia like '[0][0-9]' -- Verifica que solo pueda introducirse las cifras requeridas --
				   or codigo_provincia like '[1][0-3]')
		CONSTRAINT PK_Provincia_codigo_provincia PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL
);

-- CREANDO TABLA DISTRITO --

CREATE TABLE Distrito(
	codigo_distrito INT IDENTITY
		CONSTRAINT PK_Distrito_codigo_distrito PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	codigo_provincia VARCHAR(2)
		CONSTRAINT CK_Persona_Residencia_codigo_provincia 
			CHECK (codigo_provincia like '[0][0-9]' or
				   codigo_provincia like '[1][0-3]')
		CONSTRAINT DF_Persona_Residencia_codigo_provincia DEFAULT '08' -- Coloca el codigo de Panamá si no se especifica al ingresar --
		CONSTRAINT FK_Persona_Residencia_codigo_provincia FOREIGN KEY
		REFERENCES Provincia(codigo_provincia),
);

-- CREANDO TABLA CORREGIMIENTO --

CREATE TABLE Corregimiento(
	codigo_corregimiento INT IDENTITY
		CONSTRAINT PK_Corregimiento_codigo_corregimiento PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	codigo_distrito INT NOT NULL
		CONSTRAINT FK_Corregimiento_codigo_distrito FOREIGN KEY
		REFERENCES Distrito(codigo_distrito)
);

-- CREANDO TABLA PERSONA --

CREATE TABLE Persona(
	cedula_persona VARCHAR(20)
		CONSTRAINT CK_Persona_cedula_persona
			CHECK(cedula_persona like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_persona like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]') -- Verifica el formato de la cedula --
		CONSTRAINT PK_Persona_cedula_persona PRIMARY KEY,
	primer_nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	fecha_nacimiento DATE NOT NULL
		CONSTRAINT CK_Persona_edad
			CHECK(datepart(year, getdate()) - datepart(year, fecha_nacimiento) <= 110), -- calcula la edad y la compara con 110 --
	codigo_vac CHAR(3)
	    CONSTRAINT FK_Persona_codigo_vac FOREIGN KEY 
		REFERENCES Vacuna(codigo_vac),
	codigo_corregimiento INT NOT NULL
		CONSTRAINT FK_Persona_codigo_corregimiento FOREIGN KEY
		REFERENCES Corregimiento(codigo_corregimiento)
);

-- CREANDO TABLA PERSONA_TELEFONO

CREATE TABLE Persona_Telefono(
	cedula_persona VARCHAR(20)
		CONSTRAINT CK_Persona_Telefono_cedula_persona
			CHECK(cedula_persona like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_persona like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Persona_Telefono_cedula_persona FOREIGN KEY 
		REFERENCES Persona(cedula_persona),
	telefono VARCHAR(20),
	CONSTRAINT PK_Persona_Telefono_cedula_persona_telefono PRIMARY KEY (cedula_persona, telefono)
	
);

-- CREANDO TABLA VACUNA_PERSONA --

CREATE TABLE Vacuna_Persona(
	codigo_vac CHAR(3)
		CONSTRAINT FK_Vacuna_Persona_codigo_vac FOREIGN KEY
		REFERENCES Vacuna(codigo_vac),
	cedula_persona VARCHAR(20)
		CONSTRAINT CK_Vacuna_Persona_cedula_persona
			CHECK(cedula_persona like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_persona like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Vacuna_Persona_cedula_persona FOREIGN KEY
		REFERENCES Persona(cedula_persona),
	CONSTRAINT PK_Vacuna_Persona_codigo_vac_cedula_persona PRIMARY KEY (codigo_vac, cedula_persona),
	fecha_pd DATE,
	num_dosis INT
		CONSTRAINT CK_Vacuna_Persona_num_dosis CHECK (num_dosis IN ('1','2')) -- Verifica que solo pueda ingresar 1 o 2 dosis --
);
  
-- CREANDO TABLA CENTRO_DE_VACUNACION --

CREATE TABLE Centro_de_Vacunacion(
	codigo_cv VARCHAR(13)
		CONSTRAINT CK_Centro_de_Vacunacion_codigo_cv CHECK(codigo_cv like '[C][V][-][0-9][0-9][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][0-9][0-9][-][H][O][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][H][O][-][0-9][0-9][0-9][0-9]'or
														   codigo_cv like '[C][V][-][0-9][0-9][-][C][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][C][S][-][0-9][0-9][0-9][0-9]') -- Verifica el formato del codigo del centro de vacunacion --
		CONSTRAINT PK_Centro_de_Vacunacion_codigo_cv PRIMARY KEY,
	nombre CHAR(40) NOT NULL,
	codigo_corregimiento INT
		CONSTRAINT FK_Centro_de_Vacunacion_codigo_corregimiento FOREIGN KEY
		REFERENCES Corregimiento(codigo_corregimiento)
);

-- CREANDO TABLA CENTRO_VACUNACION_PERSONA --

CREATE TABLE Centro_Vacunacion_Persona(
	cedula_persona VARCHAR(20)
		CONSTRAINT CK_Centro_Vacunacion_Persona_cedula_persona
			CHECK(cedula_persona like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_persona like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Centro_Vacunacion_Persona_cedula_persona FOREIGN KEY
		REFERENCES Persona(cedula_persona),
	codigo_cv VARCHAR(13)
		CONSTRAINT CK_Centro_Vacunacion_Persona_codigo_cv CHECK(codigo_cv like '[C][V][-][0-9][0-9][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][0-9][0-9][-][H][O][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][H][O][-][0-9][0-9][0-9][0-9]'or
														   codigo_cv like '[C][V][-][0-9][0-9][-][C][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][C][S][-][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Centro_Vacunacion_Persona_codigo_cv FOREIGN KEY
		REFERENCES Centro_de_Vacunacion(codigo_cv),
	CONSTRAINT PK_Centro_Vacunacion_Persona_cedula_persona_codigo_cv PRIMARY KEY(cedula_persona, codigo_cv),
	fecha_cita DATE
		CONSTRAINT CK_Centro_Vacunacion_Persona_fecha_cita CHECK(datediff(day,getdate(),fecha_cita)>0) -- VERIFICA QUE LA FECHA ASIGNADA NO SEA MENOR QUE LA ACTUAL 
);

-- CREANDO TABLA INSTITUCION --

CREATE TABLE Institucion(
	codigo_inst INT IDENTITY(1000, 1)
		CONSTRAINT PK_Institucion_codigo_inst PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL
);

-- CREANDO TABLE PERSONAL --

CREATE TABLE Personal(
	cedula_personal VARCHAR(20)
		CONSTRAINT CK_Personal_cedula_personal
			CHECK(cedula_personal like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_personal like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT PK_Personal_cedula_personal PRIMARY KEY,
	primer_nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	rol CHAR
		CONSTRAINT CK_Personal_rol CHECK (rol IN ('D', 'E', 'A')) -- Verifica que solo pueda ingresarse los caracteres D E o A
		CONSTRAINT DF_Personal_rol DEFAULT 'A', -- Si no se especifica se coloca A
	codigo_cv VARCHAR(13)
		CONSTRAINT CK_Personal_codigo_cv CHECK(codigo_cv like '[C][V][-][0-9][0-9][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][0-9][0-9][-][H][O][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][H][O][-][0-9][0-9][0-9][0-9]'or
														   codigo_cv like '[C][V][-][0-9][0-9][-][C][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][C][S][-][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Personal_codigo_cv FOREIGN KEY
		REFERENCES Centro_de_Vacunacion(codigo_cv),
	codigo_inst INT
		CONSTRAINT FK_Personal_codigo_inst FOREIGN KEY
		REFERENCES Institucion(codigo_inst)
);

-- CREANDO TABLA PERSONAL_CENTRO_VACUNACION --

CREATE TABLE Personal_Centro_Vacunacion(
	cedula_personal VARCHAR(20)
		CONSTRAINT CK_Personal_Centro_Vacunacion_cedula_personal
			CHECK(cedula_personal like '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'
			   or cedula_personal like '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Personal_Centro_Vacunacion_cedula_personal FOREIGN KEY
		REFERENCES Personal(cedula_personal),
	codigo_cv VARCHAR(13)
		CONSTRAINT CK_Personal_Centro_Vacunacion_codigo_cv CHECK(codigo_cv like '[C][V][-][0-9][0-9][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][E][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][0-9][0-9][-][H][O][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][H][O][-][0-9][0-9][0-9][0-9]'or
														   codigo_cv like '[C][V][-][0-9][0-9][-][C][S][-][0-9][0-9][0-9][0-9]' or
														   codigo_cv like '[C][V][-][1][0-3][-][C][S][-][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Personal_Centro_Vacunacion_codigo_cv FOREIGN KEY
		REFERENCES Centro_de_Vacunacion(codigo_cv),
	fecha_asistencia DATE,
	CONSTRAINT PK_Personal_Centro_Vacunacion_cedula_personal_fecha_asistencia PRIMARY KEY(cedula_personal, fecha_asistencia)
);

-- INSERTANDO DATOS TABLA VACUNA --

INSERT INTO [dbo].[Vacuna]
		VALUES(upper(substring('Pfizer-BioNTech',1,3)),'Pfizer-BioNTech', 21, 2),
			  (upper(substring('Moderna',1,3)),'Moderna',28, 2),
              (upper(substring('Johnson&Johnson',1,3)),'Johnson&Johnson', NULL, 1),	
			  (upper(substring('AstraZeneca',1,3)),'AstraZeneca', 56, 2),
			  (upper(substring('Sinopharm',1,3)),'Sinopharm', 21, 2),
			  (upper(substring('Sputnik',1,3)),'Sputnik', 21, 2);

SELECT * FROM [dbo].[Vacuna];

-- INSERTANDO DATOS TABLA INSTITUCION --

INSERT INTO [dbo].[Institucion]
	VALUES('Ministerio de Salud'),
		  ('Caja de Seguro Social'),
		  ('Benemérito Cuerpo de Bomberos de la República de Panamá'),
		  ('Sistema Nacional de Protección Civil'),
		  ('Cruz Roja'),
		  ('Club Activo 20-30'),
		  ('Gobiernos Municipales '),
		  ('Policía Nacional');

SELECT * FROM [dbo].[Institucion];

-- INSERTANDO DATOS TABLA PROVINCIA --

INSERT INTO [dbo].[Provincia] 
	VALUES ('01', 'Bocas del Toro'),
		   ('02', 'Coclé'),
		   ('03', 'Colón'),
		   ('04', 'Chiriquí'),
		   ('05', 'Darién'),
		   ('06', 'Herrera'),
		   ('07', 'Los Santos'),
		   ('08', 'Panamá'),
		   ('09', 'Veraguas'),
		   ('10', 'Guna Yala, Madugandí y Wargandí'),
		   ('11', 'Emberá Wounan'),
		   ('12', 'Ngäbe-Buglé'),
		   ('13', 'Panamá Oeste');

SELECT * FROM [dbo].[Provincia];

-- INSERTANDO DATOS TABLA DISTRITO --

INSERT INTO [dbo].[Distrito]
	VALUES ('Panamá','08'),
		   ('Aguadulce','02'),
		   ('Atalaya','09'),
		   ('San Miguelito','08'),
		   ('Arraiján','13'),
		   ('Chepo','08'),
		   ('Antón','02'),
		   ('David','04'),
		   ('Changuinola','01'),
		   ('Donoso','03'),
		   ('Penonomé', '02'),
		   ('Chagres', '03'),
		   ('Colón', '03'),
		   ('Barú', '04');

SELECT * FROM [dbo].[Distrito];

-- INSERTANDO DATOS TABLA CORREGIMIENTO --

INSERT INTO [dbo].[Corregimiento]
	VALUES ('24 de Diciembre',1),
		   ('Don Bosco',1),
		   ('Atalaya',3),
		   ('Belisario Porras',4),
		   ('Burunga',5),
		   ('Chepo',6),
		   ('Antón', 7),
		   ('Cabuya', 7),
		   ('Changuinola', 9),
		   ('Gobea', 10),
		   ('El Chorrillo', 1),
		   ('Betania', 1),
		   ('Cañaveral', 11),
		   ('Palmas Bellas',12),
		   ('Barrio Norte',13),
		   ('Puerto Armuelles', 14);

SELECT * FROM [dbo].[Corregimiento];

-- INSERTANDO DATOS TABLA PERSONA --

INSERT INTO [dbo].[Persona]
		VALUES('13-5690-12678','Matt','Mullins','1998-05-19','AST', 10),
			  ('04-8971-23018','Karen','Navarro','1986-10-30','SPU', 4),
			  ('12-1123-33287','Elias','González','2000-07-06','JOH', 9),
			  ('08-0822-01234','Jimmy','Sullivan','2002-02-01','SIN', 6),
			  ('01-0089-08971','Juan','Pérez','1975-01-17','MOD', 1),
			  ('05-9899-77892','Michelle','Smith','1954-08-19','PFI', 5),
			  ('11-9987-55997','Mauro','Flores','1971-06-04','PFI', 8),
			  ('09-8770-01879','Karelys','Sánchez','2001-08-15','AST', 7),
			  ('03-6666-65597','Natalia','Rodríguez','1986-11-05','PFI', 3),
			  ('02-0466-04433','Luis','Lopéz','1997-12-08','MOD', 2);

SELECT * FROM [dbo].[Persona];

-- INSERTANDO DATOS TABLA CENTROS_DE_VACUNACION --

INSERT INTO [dbo].[Centro_de_Vacunacion]
	VALUES('CV-08-ES-0001', 'IPT Don Bosco', 2),
		  ('CV-08-ES-0002', 'C.E.B.G. Villa Catalina', 2),
		  ('CV-08-ES-0003', 'ESC. Manuel José Hurtado', 11),
		  ('CV-08-ES-0004', 'Instituto América', 12),
		  ('CV-02-ES-0001', 'ESC. Rúben Dario Carles', 9),
		  ('CV-02-ES-0002', 'ESC. Santos George', 13),
		  ('CV-01-HO-0001', 'Hospital de Changuinola', 9),
		  ('CV-03-CS-0001', 'C. DE S. Palmas Bellas', 14),
		  ('CV-03-CS-0002', 'C. DE S. Patricia Duncan', 15),
		  ('CV-04-HO-0001', 'Hospital Dionisio Arrocha', 16);

SELECT * FROM [dbo].[Centro_de_Vacunacion];

-- INSERTANDO DATOS TABLA PERSONAL --

INSERT INTO [dbo].[Personal]
	VALUES('12-5689-12677', 'Ruben', 'Vergara', 'D', 'CV-01-HO-0001', '1000'),
		  ('03-8970-23017', 'Daniel', 'Lopez', 'E', 'CV-08-ES-0004', '1000'),
		  ('11-1122-33286', 'Michael', 'Rodriguez', 'A', 'CV-02-ES-0001', '1007'),
		  ('07-0821-01233', 'Camilo', 'Hurtado', 'A', 'CV-08-ES-0003', '1002'),
		  ('01-0088-08970', 'Esteban', 'Ramirez', 'E', 'CV-02-ES-0002', '1004'),
		  ('04-9898-77891', 'Ariel', 'Pineda', 'D', 'CV-03-CS-0001', '1001'),
		  ('10-9986-55996', 'Fernando', 'Contreras', 'D', 'CV-01-HO-0001', '1001'),
		  ('08-8769-01878', 'Susan', 'Castillo', 'D', 'CV-03-CS-0001', '1001'),
		  ('02-6665-65596', 'Daniela', 'Rodriguez', 'E', 'CV-08-ES-0002', '1004'),
		  ('01-0465-04432', 'Sofia', 'Martinez', 'A', 'CV-03-CS-0002', '1003');

SELECT * FROM [dbo].[Personal];

-- INSERTANDO DATOS TABLA CENTRO_VACUNACION_PERSONA --

INSERT INTO [dbo].[Centro_Vacunacion_Persona]
	VALUES ('13-5690-12678','CV-01-HO-0001',dateadd(day, 10, getdate())),
		   ('12-1123-33287','CV-02-ES-0002',dateadd(day, 15, getdate())),
		   ('11-9987-55997','CV-04-HO-0001',dateadd(day, 5, getdate())),
		   ('08-0822-01234','CV-04-HO-0001',dateadd(day, 12, getdate())),
		   ('05-9899-77892','CV-08-ES-0001',dateadd(day, 10, getdate())),
		   ('09-8770-01879','CV-03-CS-0001',dateadd(day, 13, getdate())),
		   ('04-8971-23018','CV-08-ES-0003',dateadd(day, 7, getdate())),
		   ('03-6666-65597','CV-04-HO-0001',dateadd(day, 3, getdate())),
		   ('02-0466-04433','CV-02-ES-0002',dateadd(day, 5, getdate())),
		   ('01-0089-08971','CV-01-HO-0001',dateadd(day, 14, getdate()));

SELECT * FROM [dbo].[Centro_Vacunacion_Persona];


-- INSERTANDO DATOS TABLA TELEFONO --

INSERT INTO [dbo].[Persona_Telefono]
	VALUES ('01-0089-08971', '64241720'),
		   ('01-0089-08971', '98745621'),
		   ('02-0466-04433', '15687985'),
		   ('03-6666-65597', '14785236'),
		   ('08-0822-01234', '60518476'),
		   ('11-9987-55997', '78451236'),
		   ('11-9987-55997', '96857432'),
		   ('13-5690-12678', '60953221'),
		   ('13-5690-12678', '60003545'),
		   ('09-8770-01879', '60947785');

SELECT * FROM [dbo].[Persona_Telefono];

-- INSERTANDO DATOS TABLA PERSONAL_CENTRO_VACUNACION --

INSERT INTO [dbo].[Personal_Centro_Vacunacion]
	VALUES ('01-0088-08970', 'CV-02-ES-0002', '2021-10-11'),
	       ('01-0465-04432', 'CV-03-CS-0002', '2021-10-02'),
		   ('02-6665-65596', 'CV-08-ES-0002', '2021-09-30'),
		   ('03-8970-23017', 'CV-08-ES-0004', '2021-10-11'),
		   ('04-9898-77891', 'CV-03-CS-0001', '2021-10-10'),
		   ('07-0821-01233', 'CV-08-ES-0004', '2021-10-05'),
		   ('08-8769-01878', 'CV-03-CS-0001', '2021-10-10'),
		   ('10-9986-55996', 'CV-01-HO-0001', '2021-10-12'),
		   ('11-1122-33286', 'CV-02-ES-0001', '2021-10-02'),
		   ('12-5689-12677', 'CV-01-HO-0001', '2021-10-10'),
		   ('12-5689-12677', 'CV-08-ES-0003', '2021-10-11'),
		   ('10-9986-55996', 'CV-08-ES-0004', '2021-10-11'),
		   ('07-0821-01233', 'CV-08-ES-0003', '2021-10-04'),
		   ('03-8970-23017', 'CV-01-HO-0001', '2021-10-04'),
		   ('01-0088-08970', 'CV-02-ES-0001', '2021-10-02');

SELECT * FROM [dbo].[Personal_Centro_Vacunacion];

-- INSERTANDO DATOS TABLA VACUNA_PERSONA --

INSERT INTO [dbo].[Vacuna_Persona]
	VALUES('MOD', '01-0089-08971', '2021-10-11', '1'),
		  ('MOD', '02-0466-04433', '2021-10-02', '1'),
		  ('PFI', '03-6666-65597', '2021-09-30', '1'),
		  ('SPU', '04-8971-23018', '2021-10-04', '1'),
		  ('PFI', '05-9899-77892', '2021-10-07', '1'),
		  ('SIN', '08-0822-01234', '2021-10-09', '1'),
		  ('AST', '09-8770-01879', '2021-10-10', '2'),
		  ('PFI', '11-9987-55997', '2021-10-02', '2'),
		  ('JOH', '12-1123-33287', '2021-10-12', '1'),
		  ('AST', '13-5690-12678', '2021-10-07', '1');

SELECT * FROM [dbo].[Vacuna_Persona];


