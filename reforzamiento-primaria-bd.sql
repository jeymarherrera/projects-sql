--PROYECTO REFORZAMIENTO PRIMARIA
-- CREANDO LA BASE DE DATOS REFORZAMIENTO_PRIMARIA--
CREATE DATABASE Reforzamiento_primaria;

USE Reforzamiento_primaria;

-- CREANDO TABLA MESTRO --
CREATE TABLE Maestro (
	correo_maestro  VARCHAR(50)
		CONSTRAINT CK_Maestro_correo_maestro CHECK (correo_maestro LIKE '%@%')
		CONSTRAINT PK_Maestro_correo_maestro PRIMARY KEY, 
	cedula VARCHAR(20) NOT NULL
		CONSTRAINT CK_Maestro_cedula
			CHECK(cedula LIKE '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]' -- 1-1234-12345 --
			   or cedula LIKE '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12-1234-12345 --
			   or cedula LIKE '[P][E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- PE-1234-12345 --
			   or cedula LIKE '[E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- E-1234-12345 --
			   or cedula LIKE '[N][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- N-1234-12345 --
			   or cedula LIKE '[0][0-9][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1PI-1234-12345 --
			   or cedula LIKE '[1][0-3][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12PI-1234-12345 --
			   or cedula LIKE '[0][0-9][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1AV-1234-12345 --
			   or cedula LIKE '[1][0-3][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')	-- 12AV-1234-12345 --
		CONSTRAINT UQ_Maestro_cedula UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	estud_didact CHAR(2)
		CONSTRAINT CK_Maestro_estud_didact CHECK(estud_didact IN ('Si', 'No'))
);

-- CREANDO TABLA TEMA --
CREATE TABLE Tema (
	cod_tema VARCHAR(7)
		CONSTRAINT CK_Tema_cod_tema CHECK(cod_tema LIKE '[T][C][N][1][0][-][0-9]'
										  OR cod_tema LIKE '[T][C][S][1][0][-][0-9]')
		CONSTRAINT PK_Tema_cod_tema PRIMARY KEY,
	tema VARCHAR(255) NOT NULL,
	contenido_img VARBINARY(MAX) NOT NULL,
	contenido_text TEXT
);

-- CREANDO TABLA GRUPO --
CREATE TABLE Grupo (
	cod_grupo INT IDENTITY
		CONSTRAINT PK_Grupo_cod_grupo PRIMARY KEY,
	nivel INT NOT NULL
		CONSTRAINT CK_Grupo_nivel CHECK (nivel IN ('3', '4', '5')),
	correo_maestro VARCHAR(50) NOT NULL
		CONSTRAINT CK_Grupo_correo_maestro CHECK (correo_maestro LIKE '%@%')
		CONSTRAINT FK_Grupo_correo_maestro FOREIGN KEY
			REFERENCES Maestro(correo_maestro)
);

-- CREANDO TABLA ESTUDIANTE --
CREATE TABLE Estudiante (
	correo_estudiante VARCHAR(50)
		CONSTRAINT CK_Estudiante_correo_estudiante CHECK(correo_estudiante LIKE '%@%')
		CONSTRAINT PK_Estudiante_correo_estudiante PRIMARY KEY,
	cedula VARCHAR(20) NOT NULL
		CONSTRAINT CK_Estudiante_cedula
			CHECK(cedula LIKE '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]' -- 1-1234-12345 --
			   or cedula LIKE '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12-1234-12345 --
			   or cedula LIKE '[P][E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- PE-1234-12345 --
			   or cedula LIKE '[E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- E-1234-12345 --
			   or cedula LIKE '[N][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- N-1234-12345 --
			   or cedula LIKE '[0][0-9][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1PI-1234-12345 --
			   or cedula LIKE '[1][0-3][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12PI-1234-12345 --
			   or cedula LIKE '[0][0-9][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1AV-1234-12345 --
			   or cedula LIKE '[1][0-3][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')	-- 12AV-1234-12345 --
		CONSTRAINT UQ_Estudiante_cedula UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	contraseña VARCHAR(255) NOT NULL,
	cod_grupo INT
		CONSTRAINT FK_Estudiante_cod_grupo FOREIGN KEY
			REFERENCES Grupo(cod_grupo)
);

-- CREANDO TABLA PREGUNTA --
CREATE TABLE Pregunta (
	cod_pregunta INT IDENTITY(1001, 1)
		CONSTRAINT PK_Pregunta_cod_pregunta PRIMARY KEY,
	pregunta VARCHAR(255) NOT NULL,
	cod_tema VARCHAR(7)
		CONSTRAINT CK_Pregunta_cod_tema CHECK(cod_tema LIKE '[T][C][N][1][0][-][1-9]'
										OR cod_tema LIKE '[T][C][S][1][0][-][1-9]')
		CONSTRAINT FK_Pregunta_cod_tema FOREIGN KEY
			REFERENCES Tema(cod_tema),
	imagenes VARBINARY(MAX)
);

-- CREANDO TABLA ESTUDIANTE_PREGUNTA --
CREATE TABLE Estudiante_Pregunta (
	correo_estudiante VARCHAR(50) NOT NULL
		CONSTRAINT CK_Estudiante_Pregunta_correo_estudiante CHECK(correo_estudiante LIKE '%@%')
		CONSTRAINT FK_Estudiante_Pregunta_correo_estudiante FOREIGN KEY
			REFERENCES Estudiante(correo_estudiante),
	fecha DATE NOT NULL,
	cod_pregunta INT NOT NULL
		CONSTRAINT FK_Estudiante_Pregunta_cod_pregunta FOREIGN KEY
			REFERENCES Pregunta(cod_pregunta),
	CONSTRAINT PK_Estudiante_Pregunta_correo_estudiante_cod_pregunta_fecha PRIMARY KEY(correo_estudiante, cod_pregunta, fecha),
	puntos_obtenidos INT NOT NULL
);

-- CREANDO TABLA RESPUESTA -- 
CREATE TABLE Respuesta (
	cod_pregunta INT
		CONSTRAINT FK_Respuesta_cod_pregunta FOREIGN KEY
			REFERENCES Pregunta(cod_pregunta),
	ident_opcion CHAR 
		CONSTRAINT CK_Respuesta_ident_opcion CHECK (ident_opcion IN ('A', 'B', 'C', 'D')),
	CONSTRAINT PK_Respuesta_cod_pregunta_ident_opcion PRIMARY KEY(cod_pregunta, ident_opcion),
	opcion_Respuesta VARCHAR(255) NOT NULL,
	respuesta VARCHAR(15) NOT NULL
		CONSTRAINT CK_Respuesta_respuesta CHECK(respuesta IN ('Correcto', 'Incorrecto')),
	retroalimentacion TEXT NOT NULL,
	imagenes VARBINARY(MAX)
);

--INSERT EN LA TABLA MAESTRO
INSERT INTO [dbo].[Maestro]
	VALUES('L.lopez365@gmail.com','01-5958-55647','Luis','Lopez','1uizm43str0','Si'),
		  ('MartaD334@gmail.com','05-8812-00235','Marta','Diaz','m4rt4m43dtr4','No'),
		  ('JosebasP50@gmail.com','03-0156-99751','Josebas','Perez','j0s3b4asm43str0','No'),
		  ('ColsonB19@gmail.com','08-9997-45412','Colson','Baker','c0l50nm43str0','Si'),
		  ('MeganF20@gmail.com','05-3321-01789','Megan','Fisher','m3g4nm43str4','Si'),
		  ('TravisB@gmail.com','07-8551-66314','Travis','Barcker','tr4v1sm43str0','No'),
		  ('NicolasG002@gmail.com','10-8445-66987','Nicolas','Gallo','n1c0l45m43str0','Si'),
		  ('JeffB02@gmail.com','11-2234-45457','Jeff','Bell','j3ffm43str0','Si'),
		  ('PaulaG@gmail.com','13-1789-98712','Paula','Gonu','p4ul4m43str4','Si'),
		  ('IsaiasM100@gmail.com','02-7780-00698','Isaias','Madrigal','154145m43str0','Si');

SELECT * FROM Maestro

--INSERT EN LA TABLA TEMA
INSERT INTO [dbo].[Tema]
	VALUES('TCS10-1','Espacio geográfico del corregimiento',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1),'El espacio geográfico es el entorno en el que se desenvuelven los grupos de los seres humanos en su interrelación con el medio ambiente, por consiguiente es mano a una construcción social. Es el espacio que usan los seres humanos para su existencia, por los mismos y gracias a ellos, este se forma y evoluciona.'),
		  ('TCS10-2','El corregimiento como parte política del distrito', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1),'Los corregimientos constituyen circunscripciones territoriales que integran un distrito que legalmente le correspondan.'),
		  ('TCS10-3','Los recursos naturales de nuestro corregimiento', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1),'Elementos geográficos naturales : El corregimiento donde vives se asemeja o diferencia de otros por sus características, ríos, lagos, montañas, valles o llanuras.'),
		  ('TCS10-4','Los medios de transporte de, vías y medios de comunicación, y su nivel de desarrollo en el corregimiento',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1), 'Los medios de transporte son vehículos que se utilizan para el traslado de personas o mercancías. ... No obstante, en muchos casos, estos medios de transporte pueden transportar a personas y mercancías al mismo tiempo. Estos vehículos han sido construidos para desplazarse en diversos ambientes.'),
		  ('TCS10-5','Acitividades económicas del corregimiento',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1), 'Actividad económica es toda aquella forma mediante la que se produce, se intermedia y/o se vende un bien o servicio destinado a satisfacer una necesidad o deseo.');

SELECT * FROM Tema

--INSERT DE LA TABLA GRUPO
INSERT INTO Grupo
		VALUES('3','MartaD334@gmail.com'),
			  ('3','ColsonB19@gmail.com'),
			  ('3','L.lopez365@gmail.com'),
			  ('3','JosebasP50@gmail.com'),
			  ('3','MeganF20@gmail.com'),
			  ('3','TravisB@gmail.com'),
			  ('3','NicolasG002@gmail.com'),
			  ('3','MartaD334@gmail.com'),
			  ('3','JeffB02@gmail.com'),
			  ('3','PaulaG@gmail.com');

SELECT * FROM Grupo

--INSERT DE LA TABLA ESTUDIANTE
INSERT INTO Estudiante
		VALUES('AlvaroS21@gmail.com','07-8892-44456','Alvaro','Sánchez','4lv4r03stud14nt3','5'),
			  ('AlinaR22@gmail.com','08-9887-00444','Alina','Rodriguez','4l1n43stud14nt3','5'),
			  ('Esteban23G@gmail.com','09-4475-01236','Esteban','Gonzalez','3st3b4n3stud14nt3','5'),
			  ('MichaelD24@gmail.com','10-1247-88510','Michael','Del Mar','m1ch43l3stud14nt3','5'),
			  ('AlisonT25@gmail.com','11-2234-00587','Alison','Torres','4l1s0n3stud14nt3','5'),
			  ('DaveG26@gmail.com','12-5007-27810','Dave','Ghrol','d4v33stud14nt3','8'),
			  ('TomyL27@gmail.com','02-8899-99887','Tomy','Lee','t0my3stud14nt3','8'),
			  ('MariaC28@gmail.com','04-5554-44455','Maria','Castillo','m4r143stud14nt3','8'),
			  ('JakeP29@gmail.com','09-7788-88773','Jake','Brown','j4k33stu14nt3','8'),
			  ('MarkR30@gmail.com','05-6644-66688','Mark','Ramos','m4rk3stud14nt3','8');

SELECT * FROM Estudiante

--INSERT DE LA TABLA PREGUNTA
INSERT INTO Pregunta (pregunta, cod_tema, imagenes)
		VALUES
			('Calidonia es un corregimiento que pertenece al distrito de...', 'TCS10-1', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Con qué corregimiento limita Calidonia al norte?', 'TCS10-1', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál de estos barrios pertenece a Calidonia?', 'TCS10-1', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Con qué limita Calidona al sur?', 'TCS10-1', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál es la superficie de Calidonia?', 'TCS10-1', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál de estos corregimientos pertenece al distrito de Panamá?', 'TCS10-2', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál es el corregimiento que muestra la imagen?', 'TCS10-2', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál es el corregimiento que muestra la imagen?', 'TCS10-2', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál es el corregimiento que muestra la imagen?', 'TCS10-2', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cuál es el corregimiento que muestra la imagen?', 'TCS10-2', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué es la flora?', 'TCS10-3', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué es la fauna?', 'TCS10-3', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué son los recursos marinos?', 'TCS10-3', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Para qué se necesitan los recursos minerales?', 'TCS10-3', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cómo podemos preservar nuestros recursos naturales?', 'TCS10-3', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Para qué sirven los medios de transporte?', 'TCS10-4',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué medios de transporte se movilizan dentro de tu corregimiento?', 'TCS10-4',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cómo se clasifican los medios de transporte?', 'TCS10-4', (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Para qué sirven los medios de comunicación?', 'TCS10-4',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Cómo se clasifican los medios de comunicación?', 'TCS10-4',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('Actividades económicas más importantes de tu corregimiento', 'TCS10-5',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué es el turismo?', 'TCS10-5',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué actividades puedes realizar para apoyar a tu corregimiento?', 'TCS10-5',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('Un ejemplo de actividad portuaria', 'TCS10-5',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1)),
			('¿Qué es el cooperativismo?', 'TCS10-5',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1));

SELECT * FROM Pregunta;

--INSERT DE LA TABLA ESTUDIANTE_PREGUNTA
INSERT INTO Estudiante_Pregunta(correo_estudiante, cod_pregunta, puntos_obtenidos, fecha)
VALUES
	('AlvaroS21@gmail.com', 1001, 1, '2021-10-09'),
	('AlvaroS21@gmail.com', 1002, -2, '2021-10-09'),
	('AlvaroS21@gmail.com', 1003, -2, '2021-10-09'),
	('AlvaroS21@gmail.com', 1004, 1, '2021-10-09'),
	('MichaelD24@gmail.com', 1005, 1, '2021-10-04'),
	('MichaelD24@gmail.com', 1006, 1, '2021-10-04'),
	('MichaelD24@gmail.com', 1007, -2, '2021-10-04'),
	('MichaelD24@gmail.com', 1008, 1, '2021-10-04'),
	('MariaC28@gmail.com', 1011, 1, '2021-08-04'),
	('MariaC28@gmail.com', 1012, -2, '2021-08-04'),
	('MariaC28@gmail.com', 1013, 1, '2021-08-04'),
	('MariaC28@gmail.com', 1014, 1, '2021-08-04'),
	('JakeP29@gmail.com', 1021, -2, '2021-09-06'),
	('JakeP29@gmail.com', 1022, -2, '2021-09-06'),
	('JakeP29@gmail.com', 1023, 1, '2021-09-06'),
	('JakeP29@gmail.com', 1024, 1, '2021-09-06');

SELECT * FROM Estudiante_Pregunta;

--INSERT DE LA TABLA RESPUESTAS
INSERT INTO Respuesta 
VALUES               
 (1001,'A','San Miguelito','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1001,'B','Tonosí'        ,'Incorrecto'  ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1001,'C','Santa María	'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1001,'D','Santa Fe'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
                  
,(1002,'A','Océano Pacífico','Incorrecto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1002,'B','Curundú'        ,'Incorrecto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1002,'C','Bella Vista'    ,'Correcto'    ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1002,'D','Santa Ana'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la C'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1003,'A','Monagrillo ,El Casco Viejo , San Miguel y San Felipe ','Incorrecto','Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1003,'B','Calidonia, Marañón, San Miguel, La Exposición y Perejil','Correcto'  ,'Felicidades respuesta correcta',         (SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1003,'C','Bella Vista , Obarrio, Paitilla, Punta Pacifica y Marbella','Incorrecto','Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1003,'D','San Francisco,Alto del Golf, El cangrejo, La Exposición y Perejil','Incorrecto','Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
                   
,(1004,'A','Océano Pacífico','Incorrecto' ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1004,'B','Curundú'        ,'Incorrecto' ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1004,'C','Bella Vista'    ,'Incorrecto' ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1004,'D','Santa Ana'     ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1005,'A','	4.9 km²'   ,'Incorrecto' ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1005,'B','	1.6 km²'   ,'Correcto' ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1005,'C','	7.3 km²'   ,'Incorrecto' ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1005,'D','	9.1 km²'   ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1006,'A','Calidonia','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1006,'B','Almirante '        ,'Incorrecto'  ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1006,'C','Santa María	'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1006,'D','Santa Fe'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1007,'A','Calidonia','Incorrecto'  ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1007,'B','Ancon '        ,'Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1007,'C','Santa María	'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1007,'D','Miraflores'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1008,'A','Belisario Porras ','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1008,'B','José Domingo Espinar'        ,'Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1008,'C','Omar Torrijos'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1008,'D','Las_Cumbres'      ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   	   
,(1009,'A','Almirante','Incorrecto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1009,'B','José Domingo Espinar' ,'Incorrecto','Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1009,'C','Pedregal'    ,'Correcto'    ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1009,'D','Barrio Francés'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la C'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1010,'A','24_de_diciembre','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1010,'B','José Domingo Espinar' ,'Incorrecto','Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1010,'C','Pedregal'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1010,'D','Barrio Francés'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1011,'A','Cada unidad ecológica en que se divide la biosfera atendiendo a un conjunto de factores climáticos y geológicos que determinan el tipo de vegetación y fauna','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1011,'B','Conjunto de personas que frecuentan un lugar o realizan una determinada actividad, especialmente si son variopintas o peculiares' ,'Incorrecto','Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1011,'C','Conjunto de todas las especies animales, generalmente con referencia a un lugar, clima, tipo, medio o período geológico concretos.'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1011,'D','El término flora se refiere al conjunto de plantas, nativas o introducidas, de una región geográfica.'      ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1012,'A','Cada unidad ecológica en que se divide la biosfera atendiendo a un conjunto de factores climáticos y geológicos que determinan el tipo de vegetación y fauna','Incorrecto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1012,'B','Conjunto de personas que frecuentan un lugar o realizan una determinada actividad, especialmente si son variopintas o peculiares' ,'Incorrecto','Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1012,'C','Conjunto de todas las especies animales, generalmente con referencia a un lugar, clima, tipo, medio o período geológico concretos.'    ,'Correcto'    ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1012,'D','El término flora se refiere al conjunto de plantas, nativas o introducidas, de una región geográfica.'      ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la C'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   

,(1013,'A','Cada unidad ecológica en que se divide la biosfera atendiendo a un conjunto de factores climáticos y geológicos que determinan el tipo de vegetación y fauna','Incorrecto'  ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1013,'B','Los recursos marinos son el conjunto de elementos, considerando seres vivos y elementos no vivos, que pueden encontrarse en los mares y océanos .'    ,'Correcto','Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1013,'C','Conjunto de todas las especies animales, generalmente con referencia a un lugar, clima, tipo, medio o período geológico concretos.'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1013,'D','El término flora se refiere al conjunto de plantas, nativas o introducidas, de una región geográfica.'                                ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1014,'A','Los océanos sirven como la mayor fuente de proteínas del mundo.','Incorrecto'  ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1014,'B','Necesitamos los productos minerales para fabricar el jabón con que lavamos la ropa, para la loza, los cubiertos y los vasos para comer y beber, para tener productos cosméticos, en fin, para casi todo'    ,'Correcto','Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1014,'C','Actualmente, los recursos naturales son aprovechados por el ser humano para satisfacer sus necesidades de subsistencia'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1014,'D','La tierra es un recurso natural esencial tanto para la sobrevivencia y la prosperidad de la humanidad como para el mantenimiento de todo el ecosistema terrestre. '  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
, (1015,'A','Autobus','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1015,'B','Helicoptero'    ,'Incorrecto','Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1015,'C','Barco'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1015,'D','Aviones'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))

,(1016,'A','Para autosustentar nuetra vida social','Incorrecto'  ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1016,'B','Para tranportarno de un lugar a otro '    ,'Correcto','Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1016,'C','Para aportar al medio ambiente'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1016,'D','Para localizar a otras personas'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))		   

,(1017,'A','Autobus','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1017,'B','Helicoptero'    ,'Incorrecto','Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1017,'C','Barco'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1017,'D','Aviones'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		  
,(1018,'A','Vertebrados y invetebrados','Incorrecto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1018,'B','Mamiferos , cefalopodos , branqueolos'    ,'Incorrecto','Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1018,'C','Terrestres , aereos , acuaticos'    ,'Correcto'    ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1018,'D','Carnivoros y vegetarianos'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la C'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1019,'A','Para colocar objetos a distancias diferentes','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1019,'B','Para reparar autos '    ,'Incorrecto','Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1019,'C','Para tener contactovisual con otros planeta'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1019,'D','Para comunicarse con otras personas a distancias diferentes'  ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
, (1020,'A','Vertebrados y invetebrados','Correcto'  ,'Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1020,'B','Mamiferos , cefalopodos , branqueolos'    ,'Incorrecto','Fallastes, la respuesta correcta es la C',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1020,'C','La televisio , radio ,medios impresos , digitales'    ,'Correcto'    ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1020,'D','Carnivoros y vegetarianos'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la C'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1021,'A','Agricultura','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1021,'B','Industria'    ,'Incorrecto','Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1021,'C','Pesca'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1021,'D','Transporte'  ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		       
,(1022,'A','Es una actividad que consite en cultivar productos','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1022,'B','Es una actividad que fabrica todo tipo de maquinas'    ,'Incorrecto','Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1022,'C','Es la actividad que depende del mar'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1022,'D','Es la actividad que consite en viajar y visitir lugar en otros paises'  ,'Correcto'   ,'Felicidades respuesta correcta'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
, (1023,'A','Agricultura','Incorrecto'  ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1023,'B','Industria'    ,'Correcto','Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1023,'C','Pesca'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la B',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1023,'D','Transporte'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la B'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
, (1024,'A','Portacontenedores','Correcto'  ,'Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1024,'B','Industria'    ,'Incorrecto','Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1024,'C','Pesca'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la A',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1024,'D','Transporte'  ,'Incorrecto'   ,'Fallastes, la respuesta correcta es la A'          ,(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
		   
,(1025,'A','Es una actividad que consite en cultivar productos','Incorrecto'  ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1025,'B','Es una actividad que fabrica todo tipo de maquinas'    ,'Incorrecto','Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1025,'C','Es la actividad que depende del mar'    ,'Incorrecto'    ,'Fallastes, la respuesta correcta es la D',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1))
,(1025,'D','es el movimiento social o doctrina que determina la cooperación de sus integrantes en el rango económico y social como medio para lograr que los productores y consumidores,'  ,'Correcto','Felicidades respuesta correcta',(SELECT * FROM OPENROWSET(BULK N'C:\Users\lueun\Downloads\Panama_Panama_location_map.svg.png', SINGLE_BLOB)AS T1));

SELECT *
FROM Respuesta;

-------------------------------------------------------------------------------------------------------------------------
-- 2

-- VISTA QUE CONTENGA LOS ESTUDIANTES
CREATE VIEW v_Estudiantes_x_Grupo
	AS
		SELECT apellido AS APELLIDO, nombre AS NOMBRE, cedula AS CEDULA, cod_grupo AS GRUPO
		FROM Estudiante;

-- PROCEDIMIENTO QUE TOME EL GRUPO A MOSTRAR
CREATE PROCEDURE pa_Estudiantes_x_Grupo
	@cod_grupo INT
AS
	SELECT APELLIDO, NOMBRE, CEDULA
	FROM v_Estudiantes_x_Grupo
	WHERE GRUPO = @cod_grupo
	ORDER BY APELLIDO;

-- LLAMADO AL PROCEDIMIENTO
EXECUTE pa_Estudiantes_x_Grupo 5;

-------------------------------------------------------------------------------------------------------------------------
-- 3

-- TRIGGER PARA VERIFICAR SI YA EXISTE LA CEDULA EN LOS ESTUDIANTES
CREATE TRIGGER t_Verficar_Nuevo_Estudiante
ON Estudiante
INSTEAD OF INSERT
AS
	DECLARE @correo VARCHAR(50),
		    @cedula VARCHAR(20),
			@nombre VARCHAR(50),
			@apellido VARCHAR(50),
			@contraseña VARCHAR(255),
			@grupo INT

	SELECT @correo = correo_estudiante,
		   @cedula = cedula,
		   @nombre = nombre,
		   @apellido = apellido,
		   @contraseña = contraseña,
		   @grupo = cod_grupo
	FROM inserted

	IF EXISTS(SELECT * FROM Estudiante WHERE cedula = @cedula)
		PRINT 'EL USUARIO YA SE ENCUENTRA REGISTRADO'
	ELSE
	BEGIN 
		INSERT INTO Estudiante
			VALUES(@correo, @cedula, @nombre, @apellido, @contraseña, @grupo)
	END;

-- TRIGGER PARA VERIFICAR SI YA EXISTE LA CEDULA EN LOS MAESTROS
CREATE TRIGGER t_Verficar_Nuevo_Maestro
ON Maestro
INSTEAD OF INSERT
AS
	DECLARE @correo VARCHAR(50),
		    @cedula VARCHAR(20),
			@nombre VARCHAR(50),
			@apellido VARCHAR(50),
			@contraseña VARCHAR(255),
			@didact CHAR(2)

	SELECT @correo = correo_maestro,
		   @cedula = cedula,
		   @nombre = nombre,
		   @apellido = apellido,
		   @contraseña = contraseña,
		   @didact = estud_didact
	FROM inserted

	IF EXISTS(SELECT * FROM Maestro WHERE cedula = @cedula)
		PRINT 'EL USUARIO YA SE ENCUENTRA REGISTRADO'
	ELSE
	BEGIN 
		INSERT INTO Maestro
			VALUES(@correo, @cedula, @nombre, @apellido, @contraseña, @didact)
	END;

-------------------------------------------------------------------------------------------------------------------------
-- 4

-- Procedimiento para validar las respuesta

CREATE PROCEDURE pa_Validar_Respuesta
	@correo VARCHAR(50),
	@cod_pregunta INT,
	@opcion CHAR(1)
AS
	DECLARE @correcta CHAR(1)

	SELECT @correcta = ident_opcion
	FROM Respuesta
	WHERE cod_pregunta = @cod_pregunta AND respuesta = 'Correcto'

	IF (@opcion = @correcta)
	BEGIN
		INSERT INTO Estudiante_Pregunta
			VALUES(@correo, GETDATE(), @cod_pregunta, 1)
	END
	ELSE
	BEGIN
		INSERT INTO Estudiante_Pregunta
			VALUES(@correo, GETDATE(), @cod_pregunta, -2)
	END;

--EXECUTE pa_Validar_Respuesta 'AlvaroS21@gmail.com', 1025, 'A'

-------------------------------------------------------------------------------------------------------------------------
-- 5

-- Cursor Puntaje de los estudiantes x pregunta y x tema de un grupo especifico

CREATE PROCEDURE pa_Seguimiento_Estudiantes
	@cod_grupo INT
AS
	DECLARE @apellido VARCHAR(50),
			@nombre VARCHAR(50),
			@cedula VARCHAR(20),
			@cedula_ant VARCHAR(20),
			@tema VARCHAR(255),
			@tema_ant VARCHAR(255),
			@pregunta VARCHAR(255),
			@puntos INT

	DECLARE cursor_Seguimiento_Estudiantes CURSOR
	FOR
		SELECT a.apellido, a.nombre, a.cedula, d.tema, c.pregunta, b.puntos_obtenidos
		FROM Estudiante AS a INNER JOIN Estudiante_Pregunta AS b ON a.correo_estudiante = b.correo_estudiante
							 INNER JOIN Pregunta AS c ON b.cod_pregunta = c.cod_pregunta
							 INNER JOIN Tema AS d ON c.cod_tema = d.cod_tema
		WHERE a.cod_grupo = @cod_grupo

	OPEN cursor_Seguimiento_Estudiantes

	FETCH NEXT FROM cursor_Seguimiento_Estudiantes
		INTO @apellido, @nombre, @cedula, @tema, @pregunta, @puntos

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Estudiante: '+@apellido+', '+@nombre
		PRINT 'Cedula: '+@cedula
		SET @cedula_ant = @cedula
		WHILE(@cedula = @cedula_ant) AND (@@FETCH_STATUS = 0)
		BEGIN
			PRINT SPACE(5)+'Tema: '+@tema
			SET @tema_ant = @tema
			WHILE(@tema = @tema_ant) AND (@@FETCH_STATUS = 0)
			BEGIN
				PRINT SPACE(15)+@pregunta+SPACE(5)+'PUNTOS= '+CAST(@puntos AS VARCHAR)
				FETCH NEXT FROM cursor_Seguimiento_Estudiantes
					INTO @apellido, @nombre, @cedula, @tema, @pregunta, @puntos
			END
		END
		PRINT '-------------------------------------------------------'
	END

	CLOSE cursor_Seguimiento_Estudiantes
	
	DEALLOCATE cursor_Seguimiento_Estudiantes;
	
EXECUTE pa_Seguimiento_Estudiantes 5