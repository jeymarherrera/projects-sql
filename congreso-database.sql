GO
USE MASTER;
GO
DROP DATABASE IF EXISTS Congreso_DB;
GO
CREATE DATABASE Congreso_DB;
GO
USE Congreso_DB;
GO

-- CREANDO TABLA PAIS --
CREATE TABLE Pais(
	id_pais INT IDENTITY
		CONSTRAINT PK_Pais_id_pais PRIMARY KEY,
	nombre_pais VARCHAR(50) NOT NULL
);

-- CREANDO TABLA PROVINCIA --
CREATE TABLE Provincia(
	id_provincia INT IDENTITY
		CONSTRAINT PK_Provincia_id_provincia PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL		
);

-- CREANDO TABLA OCUPACION --
CREATE TABLE Ocupacion(
	id_ocupacion INT IDENTITY
		CONSTRAINT PK_Ocupacion_id_ocupacion PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL
);

-- CREANDO TABLA ENTIDAD --
CREATE TABLE Entidad(
	id_entidad INT IDENTITY
		CONSTRAINT PK_Entidad_id_entidad PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL
);

-- CREANDO TABLA IEEE --
CREATE TABLE IEEE(
	cod_IEEE INT IDENTITY (1000,1)
		CONSTRAINT PK_IEEE_cod_IEEE PRIMARY KEY, 
	descuento INT NOT NULL DEFAULT (0)
);

-- CREANDO TABLA WPA --
CREATE TABLE WPA(
	cod_WPA INT IDENTITY (3000,1)
		CONSTRAINT PK_WPA_cod_WPA PRIMARY KEY, 
	descuento INT NOT NULL DEFAULT (0)
);

-- CREANDO TABLA AREA --
CREATE TABLE Area(
	id_area INT IDENTITY
		CONSTRAINT PK_Area_id_area PRIMARY KEY, 
	nombre VARCHAR (200) NOT NULL
);

-- CREANDO TABLA TIPO --
CREATE TABLE Tipo(
	id_tipo INT IDENTITY
		CONSTRAINT PK_Tipo_id_tipo PRIMARY KEY, 
	tipo VARCHAR (50) NOT NULL,
	monto MONEY NOT NULL
);

-- CREANDO TABLA PAGO --
CREATE TABLE Pago(
	id_pago INT IDENTITY
		CONSTRAINT PK_Pago_id_pago PRIMARY KEY, 
	fecha DATETIME NOT NULL,
	id_tipo INT NOT NULL
	CONSTRAINT FK_Pago_id_tipo FOREIGN KEY
		REFERENCES Tipo(id_tipo),
	metodo VARCHAR (50) NOT NULL,
	descuento MONEY NOT NULL DEFAULT (0),
	cena MONEY NOT NULL,
	comision MONEY NOT NULL,
	comision_pago MONEY NOT NULL,
	monto_total MONEY NOT NULL,
	estado CHAR(1) NULL,
	monto MONEY NOT NULL,
);

-- CREANDO TABLA SALA --
CREATE TABLE Sala(
	id_sala INT IDENTITY
		CONSTRAINT PK_Sala_id_sala PRIMARY KEY, 
	num_sala VARCHAR(10) NOT NULL,
	cantidad_asientos INT NOT NULL
);

-- CREANDO TABLA CONGRESO --
CREATE TABLE Congreso(
	id_congreso INT IDENTITY
		CONSTRAINT PK_Congreso_id_congreso PRIMARY KEY, 
	titulo VARCHAR(50) NOT NULL,
	cantidad_boletos INT NOT NULL,
	horas_minimas INT NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL
);


-- CREANDO TABLA CONFERENCIA --
CREATE TABLE Conferencia(
	id_conferencia INT IDENTITY
		CONSTRAINT PK_Conferencia_id_conferencia PRIMARY KEY, 
	titulo VARCHAR(50) NOT NULL,
	cantidad_ponencias INT NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	id_sala INT NOT NULL
		CONSTRAINT FK_Conferencia_id_sala FOREIGN KEY
			REFERENCES Sala(id_sala),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Conferencia_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso)
);

-- CREANDO TABLA CONFERENCIA_AREA --
CREATE TABLE Conferencia_Area(
	id_conferencia INT NOT NULL
		CONSTRAINT FK_Conferencia_Area_id_conferencia FOREIGN KEY
			REFERENCES Conferencia(id_conferencia),
	id_area INT NOT NULL
		CONSTRAINT FK_Conferencia_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Conferencia_Area_id_conferencia_id_area PRIMARY KEY(id_conferencia, id_area),
);


-- CREANDO TABLA EVENTO --
CREATE TABLE Evento(
	id_evento INT IDENTITY
		CONSTRAINT PK_Evento_id_evento PRIMARY KEY, 
	titulo VARCHAR(50) NOT NULL,
	horas_minimas INT NOT NULL,
	cantidad_ponencias INT NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	id_sala INT NOT NULL
		CONSTRAINT FK_Evento_id_sala FOREIGN KEY
			REFERENCES Sala(id_sala),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Evento_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso)
);

-- CREANDO TABLA EVENTO_AREA --
CREATE TABLE Evento_Area(
	id_evento INT NOT NULL
		CONSTRAINT FK_Evento_Area_id_evento FOREIGN KEY
			REFERENCES Evento(id_evento),
	id_area INT NOT NULL
		CONSTRAINT FK_Evento_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Evento_Area_id_evento_id_area PRIMARY KEY(id_evento, id_area),
);

--DROP TABLE Administrador
-- CREANDO TABLA ADMINISTRADOR --
CREATE TABLE Administrador (
	id_administrador VARCHAR(20) NOT NULL
		CONSTRAINT PK_Administrador_id_administrador PRIMARY KEY,	
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	sexo CHAR(2) NOT NULL
		CONSTRAINT CK_Administrador_sexo CHECK(sexo IN ('F', 'M')),		
	correo  VARCHAR(50) NOT NULL
		CONSTRAINT CK_Administrador_correo CHECK (correo LIKE '%@%')
		CONSTRAINT UQ_Administrador_correo UNIQUE, 
	contrasena VARCHAR(255) NULL,
	id_pais INT NOT NULL
		CONSTRAINT FK_Administrador_id_pais FOREIGN KEY
			REFERENCES Pais(id_pais),
	ciudad VARCHAR(50) NULL,
	id_provincia INT NULL
		CONSTRAINT FK_Administrador_id_provincia FOREIGN KEY
			REFERENCES Provincia(id_provincia),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Administrador_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NOT NULL
		CONSTRAINT FK_Administrador_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad)
);

-- CREANDO TABLA CONFERENCISTA --
CREATE TABLE Conferencista(
	id_conferencista VARCHAR(20) NOT NULL
		CONSTRAINT PK_Conferencista_id_conferencista PRIMARY KEY,	
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NULL,
	sexo CHAR(2)
		CONSTRAINT CK_Conferencista_sexo CHECK(sexo IN ('F', 'M')),		
	correo  VARCHAR(50)
		CONSTRAINT CK_Conferencista_correo CHECK (correo LIKE '%@%')
		CONSTRAINT UQ_Conferencista_cedula UNIQUE, 
	contrasena VARCHAR(255) NULL,
	gafete VARCHAR(255) NULL,
	id_pais INT NOT NULL
		CONSTRAINT FK_Conferencista_id_pais FOREIGN KEY
			REFERENCES Pais(id_pais),
	ciudad VARCHAR(50) NULL,
	id_provincia INT NULL
		CONSTRAINT FK_Provincia_id_provincia FOREIGN KEY
			REFERENCES Provincia(id_provincia),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Conferencista_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NULL
		CONSTRAINT FK_Conferencista_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad)
);

-- CREANDO TABLA CONFERENCISTA_CONFERENCIA (RELACION) ASISTE A - PONENCIA --
CREATE TABLE Conferencista_Conferencia(
	id_conferencista VARCHAR(20) NOT NULL
		CONSTRAINT FK_Conferencista_Conferencia_id_conferencista FOREIGN KEY
			REFERENCES Conferencista(id_conferencista),
	titulo VARCHAR(50) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	id_conferencia INT NOT NULL
		CONSTRAINT FK_Conferencista_Conferencia_id_conferencia FOREIGN KEY
			REFERENCES Conferencia(id_conferencia),
	CONSTRAINT PK_Conferencista_Conferencia_id_conferencia_id_conferencista_id_conferencia_fecha PRIMARY KEY(id_conferencista, id_conferencia, fecha_inicio, fecha_fin)
);

-- CREANDO TABLA AUTOR --
CREATE TABLE Autor(
	id_autor VARCHAR(20) NOT NULL
		CONSTRAINT PK_Autor_id_autor PRIMARY KEY,	
	tipo_usuario VARCHAR(20) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NULL,
	sexo CHAR(2)
		CONSTRAINT CK_Autor_sexo CHECK(sexo IN ('F', 'M')),		
	correo  VARCHAR(50)
		CONSTRAINT CK_Autor_correo CHECK (correo LIKE '%@%')
		CONSTRAINT UQ_Autor_cedula UNIQUE, 
	contrasena VARCHAR(255) NULL,
	gafete VARCHAR(255) NULL,
	id_pais INT NOT NULL
		CONSTRAINT FK_Autor_id_pais FOREIGN KEY
			REFERENCES Pais(id_pais),
	ciudad VARCHAR(50) NULL,
	id_provincia INT NULL
		CONSTRAINT FK_Autor_id_provincia FOREIGN KEY
			REFERENCES Provincia(id_provincia),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Autor_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NULL
		CONSTRAINT FK_Autor_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad),
	cod_ieee INT NULL
		CONSTRAINT FK_Autor_cod_ieee FOREIGN KEY
			REFERENCES IEEE(cod_ieee),
	cod_wpa INT NULL
		CONSTRAINT FK_Autor_cod_wpa FOREIGN KEY
			REFERENCES WPA(cod_wpa),
	id_pago INT NULL
		CONSTRAINT FK_Autor_id_pago FOREIGN KEY
			REFERENCES Pago(id_pago)
);

-- CREANDO TABLA ARTICULO --
CREATE TABLE Articulo(
	id_articulo INT IDENTITY,
	cod_aprobado VARCHAR (50) NOT NULL,
	nombre VARCHAR (50) NOT NULL,
	id_autor VARCHAR(20) NOT NULL
		CONSTRAINT FK_Articulo_id_autor FOREIGN KEY
			REFERENCES Autor(id_autor),
	CONSTRAINT PK_Articulo_id_articulo_id_cod_aprobado PRIMARY KEY(id_articulo, cod_aprobado)
);

-- CREANDO TABLA AUTOR_EVENTO --
CREATE TABLE Autor_Evento(
	id_autor VARCHAR(20) NOT NULL
		CONSTRAINT FK_Autor_Evento_id_autor FOREIGN KEY
			REFERENCES Autor(id_autor),
	titulo VARCHAR(50) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	id_evento INT NOT NULL
		CONSTRAINT FK_Autor_Evento_id_evento FOREIGN KEY
			REFERENCES Evento(id_evento),
	CONSTRAINT PK_Autor_Evento_id_autor_id_evento_fecha PRIMARY KEY(id_autor, id_evento, fecha_inicio, fecha_fin)
);

-- CREANDO TABLA AUTOR_AREA --
CREATE TABLE Autor_Area(
	id_autor VARCHAR(20) NOT NULL
		CONSTRAINT FK_Autor_Area_id_autor FOREIGN KEY
			REFERENCES Autor(id_autor),
	id_area INT NOT NULL
		CONSTRAINT FK_Autor_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Autor_Area_id_autor_id_area PRIMARY KEY(id_autor, id_area),
);

-- CREANDO TABLA PROFESIONAL --
CREATE TABLE Profesional (
	id_profesional VARCHAR(20) NOT NULL
		CONSTRAINT PK_Profesional_id_profesional PRIMARY KEY,	
	tipo_usuario VARCHAR(20) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NULL,
	sexo CHAR(2)
		CONSTRAINT CK_Profesional_sexo CHECK(sexo IN ('F', 'M')),		
	correo  VARCHAR(50) NOT NULL
		CONSTRAINT CK_Profesional_correo_usuario CHECK (correo LIKE '%@%')
		CONSTRAINT UQ_Profesional_cedula UNIQUE, 
	contrasena VARCHAR(255) NULL,
	gafete VARCHAR(200) NULL,
	id_pais INT NOT NULL
		CONSTRAINT FK_Profesional_id_pais FOREIGN KEY
			REFERENCES Pais(id_pais),
	ciudad VARCHAR(50) NULL,
	id_provincia INT NULL
		CONSTRAINT FK_Profesional_id_provincia FOREIGN KEY
			REFERENCES Provincia(id_provincia),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Profesional_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NULL
		CONSTRAINT FK_Profesional_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad),
	cod_ieee INT NULL
		CONSTRAINT FK_Profesional_cod_ieee FOREIGN KEY
			REFERENCES IEEE(cod_ieee),
	cod_wpa INT NULL
		CONSTRAINT FK_Profesional_cod_wpa FOREIGN KEY
			REFERENCES WPA(cod_wpa),
	id_pago INT NULL
		CONSTRAINT FK_Profesional_id_pago FOREIGN KEY
			REFERENCES Pago(id_pago)
);

-- CREANDO TABLA PROFESIONAL_EVENTO --
CREATE TABLE Profesional_Evento(
	id_profesional_evento INT NOT NULL,
	id_profesional VARCHAR(20) NOT NULL
		CONSTRAINT FK_Profesional_Evento_id_profesional FOREIGN KEY
			REFERENCES Profesional(id_profesional),
	id_evento INT NOT NULL
		CONSTRAINT FK_Profesional_Evento_id_evento FOREIGN KEY
			REFERENCES Evento(id_evento),
	CONSTRAINT PK_Profesional_Evento_id_profesional_evento_id_profesional_id_evento PRIMARY KEY(id_profesional_evento, id_profesional, id_evento),
	entrada TIMESTAMP NULL,
	salida DATETIME NULL,
);

-- CREANDO TABLA PROFESIONAL_CONGRESO --
CREATE TABLE Profesional_Congreso(
	id_profesional_congreso INT NOT NULL,
	id_profesional VARCHAR(20) NOT NULL
		CONSTRAINT FK_Profesional_Congreso_id_profesional FOREIGN KEY
			REFERENCES Profesional(id_profesional),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Profesional_Congreso_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso),
	CONSTRAINT PK_Profesional_Congreso_id_profesional_congreso_id_profesional_id_congreso PRIMARY KEY(id_profesional_congreso, id_profesional, id_congreso),
	entrada TIMESTAMP NULL,
	salida DATETIME NULL,
);

-- CREANDO TABLA PROFESIONAL_AREA --
CREATE TABLE Profesional_Area(
	id_profesional VARCHAR(20) NOT NULL
		CONSTRAINT FK_Profesional_Area_id_profesional FOREIGN KEY
			REFERENCES Profesional(id_profesional),
	id_area INT NOT NULL
		CONSTRAINT FK_Profesional_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Profesional_Area_id_profesional_id_area PRIMARY KEY(id_profesional, id_area),
);

-- CREANDO TABLA ESTUDIANTE --
CREATE TABLE Estudiante (
	id_estudiante VARCHAR(20) NOT NULL
		CONSTRAINT PK_Estudiante_id_estudiante PRIMARY KEY,	
	cod_estudiante VARCHAR(20) NULL,
	tipo_usuario VARCHAR(20) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NULL,
	sexo CHAR(2)
		CONSTRAINT CK_Estudiante_sexo CHECK(sexo IN ('F', 'M')),		
	correo VARCHAR(50)
		CONSTRAINT CK_Estudiante_correo CHECK (correo LIKE '%@%')
		CONSTRAINT UQ_Estudiante_cedula UNIQUE, 
	contrasena VARCHAR(255) NULL,
	gafete VARCHAR(200) NULL,
	id_pais INT NOT NULL
		CONSTRAINT FK_Estudiante_id_pais FOREIGN KEY
			REFERENCES Pais(id_pais),
	ciudad VARCHAR (50) NULL,
	id_provincia INT NULL
		CONSTRAINT FK_Estudiante_id_provincia FOREIGN KEY
			REFERENCES Provincia(id_provincia),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Estudiante_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NULL
		CONSTRAINT FK_Estudiante_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad),
	cod_ieee INT NULL
		CONSTRAINT FK_Estudiante_cod_ieee FOREIGN KEY
			REFERENCES IEEE(cod_ieee),
	cod_wpa INT NULL
		CONSTRAINT FK_Estudiante_cod_wpa FOREIGN KEY
			REFERENCES WPA(cod_wpa),
	id_pago INT NULL
		CONSTRAINT FK_Estudiante_id_pago FOREIGN KEY
			REFERENCES Pago(id_pago)

);

-- CREANDO TABLA ESTUDIANTE_CONGRESO --
CREATE TABLE Estudiante_Congreso(
	id_estudiante_congreso INT NOT NULL,
	id_estudiante VARCHAR(20) NOT NULL
		CONSTRAINT FK_Estudiante_Congreso_id_estudiante FOREIGN KEY
			REFERENCES Estudiante(id_estudiante),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Estudiante_Congreso_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso),
	CONSTRAINT PK_PEstudiante_Congreso_id_estudiante_congreso_id_estudiante_id_congreso PRIMARY KEY(id_estudiante_congreso, id_estudiante, id_congreso),
	entrada TIMESTAMP NULL,
	salida DATETIME NULL
);

-- CREANDO TABLA ESTUDIANTE_EVENTO --
CREATE TABLE Estudiante_Evento(
	id_estudiante_evento INT NOT NULL,
	id_estudiante VARCHAR(20) NOT NULL
		CONSTRAINT FK_Estudiante_Evento_id_estudiante FOREIGN KEY
			REFERENCES Estudiante(id_estudiante),
	id_evento INT NOT NULL
		CONSTRAINT FK_Estudiante_Evento_id_evento FOREIGN KEY
			REFERENCES Evento(id_evento),
	CONSTRAINT PK_Estudiante_Evento_id_estudiante_evento_id_estudiante_id_evento PRIMARY KEY(id_estudiante_evento, id_estudiante, id_evento),
	entrada TIMESTAMP NOT NULL,
	salida DATETIME NOT NULL
);

-- CREANDO TABLA ESTUDIANTE_AREA --
CREATE TABLE Estudiante_Area(
	id_estudiante VARCHAR(20) NOT NULL
		CONSTRAINT FK_Estudiante_Area_id_estudiante FOREIGN KEY
			REFERENCES Estudiante(id_estudiante),
	id_area INT NOT NULL
		CONSTRAINT FK_Estudiante_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Estudiante_Area_id_estudiante_id_area PRIMARY KEY(id_estudiante, id_area),
);

CREATE TABLE Certificado_Prof_C(
    id_certificado INT IDENTITY PRIMARY KEY,
    id_profesional VARCHAR(20)
        CONSTRAINT FK_CPC FOREIGN KEY REFERENCES Profesional(id_profesional),
    id_congreso INT
        CONSTRAINT FK_PC FOREIGN KEY REFERENCES Congreso(id_congreso),
    total_horas INT,
    certificado VARCHAR(500)
)

CREATE TABLE Certificado_Prof_E(
    id_certificado INT IDENTITY PRIMARY KEY,
    id_profesional VARCHAR(20)
        CONSTRAINT FK_CPE FOREIGN KEY REFERENCES Profesional(id_profesional),
    id_evento INT
        CONSTRAINT FK_PE FOREIGN KEY REFERENCES Evento(id_evento),
    total_horas INT,
    certificado VARCHAR(500)
)

CREATE TABLE Certificado_Est_C(
    id_certificado INT IDENTITY PRIMARY KEY,
    id_estudiante  VARCHAR(20)
        CONSTRAINT FK_CEC FOREIGN KEY REFERENCES Estudiante(id_estudiante),
    id_congreso INT
        CONSTRAINT FK_EC FOREIGN KEY REFERENCES Congreso(id_congreso),
    total_horas INT,
    certificado VARCHAR(500)
)

CREATE TABLE Certificado_Est_E(
    id_certificado INT IDENTITY PRIMARY KEY,
    id_estudiante VARCHAR(20)
        CONSTRAINT FK_CEE FOREIGN KEY REFERENCES Estudiante(id_estudiante),
    id_evento INT
        CONSTRAINT FK_EE FOREIGN KEY REFERENCES Evento(id_evento),
    total_horas INT,
    certificado VARCHAR(500)
)
--INSERTS


-- INSERTANDO DATOS TABLA OCUPACION --
INSERT INTO Ocupacion
	VALUES ('Estudiante'),
		   ('Docente'),
		   ('Investigador'),
		   ('Profesional'),
		   ('Administrativo'),
		   ('Otro');


-- INSERTANDO DATOS TABLA ENTIDAD --
INSERT INTO Entidad
	VALUES ('Universidad Tecnologica de Panama'),
		  ('Universidad de Panama'),
		  ('Pede Cum Associates'),
		  ('Molestie Pharetra Nibh Company'),
		  ('Dapibus Gravida LLC'),
		  ('Dolor Donec Limited'),
		  ('Sociis Natoque Institute');

-- INSERTANDO DATOS TABLA TIPO --
INSERT INTO Tipo
	VALUES ('Autor', 350),
		   ('Estudiante UTP', 75),
		   ('Funcionario UTP', 225),
		   ('Estudiantes Nacional',75),
		   ('Profesional Nacional',225),
		   ('Estudiante Internacional',150),
		   ('Profesional Internacional',300),
		   ('Estudiante Miembro WPA',150),
		   ('Profesional Miembro WPA',300);


-- INSERTANDO DATOS TABLA PAIS --

INSERT INTO Pais VALUES('Afganistán');
INSERT INTO Pais VALUES('Islas Gland');
INSERT INTO Pais VALUES('Albania');
INSERT INTO Pais VALUES('Alemania');
INSERT INTO Pais VALUES('Andorra');
INSERT INTO Pais VALUES('Angola');
INSERT INTO Pais VALUES('Anguilla');
INSERT INTO Pais VALUES('Antártida');
INSERT INTO Pais VALUES('Antigua y Barbuda');
INSERT INTO Pais VALUES('Antillas Holandesas');
INSERT INTO Pais VALUES('Arabia Saudí');
INSERT INTO Pais VALUES('Argelia');
INSERT INTO Pais VALUES('Argentina');
INSERT INTO Pais VALUES('Armenia');
INSERT INTO Pais VALUES('Aruba');
INSERT INTO Pais VALUES('Australia');
INSERT INTO Pais VALUES('Austria');
INSERT INTO Pais VALUES('Azerbaiyán');
INSERT INTO Pais VALUES('Bahamas');
INSERT INTO Pais VALUES('Bahréin');
INSERT INTO Pais VALUES('Bangladesh');
INSERT INTO Pais VALUES('Barbados');
INSERT INTO Pais VALUES('Bielorrusia');
INSERT INTO Pais VALUES('Bélgica');
INSERT INTO Pais VALUES('Belice');
INSERT INTO Pais VALUES('Benin');
INSERT INTO Pais VALUES('Bermudas');
INSERT INTO Pais VALUES('Bhután');
INSERT INTO Pais VALUES('Bolivia');
INSERT INTO Pais VALUES('Bosnia y Herzegovina');
INSERT INTO Pais VALUES('Botsuana');
INSERT INTO Pais VALUES('Isla Bouvet');
INSERT INTO Pais VALUES('Brasil');
INSERT INTO Pais VALUES('Brunéi');
INSERT INTO Pais VALUES('Bulgaria');
INSERT INTO Pais VALUES('Burkina Faso');
INSERT INTO Pais VALUES('Burundi');
INSERT INTO Pais VALUES('Cabo Verde');
INSERT INTO Pais VALUES('Islas Caimán');
INSERT INTO Pais VALUES('Camboya');
INSERT INTO Pais VALUES('Camerún');
INSERT INTO Pais VALUES('Canadá');
INSERT INTO Pais VALUES('República Centroafricana');
INSERT INTO Pais VALUES('Chad');
INSERT INTO Pais VALUES('República Checa');
INSERT INTO Pais VALUES('Chile');
INSERT INTO Pais VALUES('China');
INSERT INTO Pais VALUES('Chipre');
INSERT INTO Pais VALUES('Isla de Navidad');
INSERT INTO Pais VALUES('Ciudad del Vaticano');
INSERT INTO Pais VALUES('Islas Cocos');
INSERT INTO Pais VALUES('Colombia');
INSERT INTO Pais VALUES('Comoras');
INSERT INTO Pais VALUES('República Democrática del Congo');
INSERT INTO Pais VALUES('Congo');
INSERT INTO Pais VALUES('Islas Cook');
INSERT INTO Pais VALUES('Corea del Norte');
INSERT INTO Pais VALUES('Corea del Sur');
INSERT INTO Pais VALUES('Costa de Marfil');
INSERT INTO Pais VALUES('Costa Rica');
INSERT INTO Pais VALUES('Croacia');
INSERT INTO Pais VALUES('Cuba');
INSERT INTO Pais VALUES('Dinamarca');
INSERT INTO Pais VALUES('Dominica');
INSERT INTO Pais VALUES('República Dominicana');
INSERT INTO Pais VALUES('Ecuador');
INSERT INTO Pais VALUES('Egipto');
INSERT INTO Pais VALUES('El Salvador');
INSERT INTO Pais VALUES('Emiratos Árabes Unidos');
INSERT INTO Pais VALUES('Eritrea');
INSERT INTO Pais VALUES('Eslovaquia');
INSERT INTO Pais VALUES('Eslovenia');
INSERT INTO Pais VALUES('España');
INSERT INTO Pais VALUES('Islas ultramarinas de Estados Unidos');
INSERT INTO Pais VALUES('Estados Unidos');
INSERT INTO Pais VALUES('Estonia');
INSERT INTO Pais VALUES('Etiopía');
INSERT INTO Pais VALUES('Islas Feroe');
INSERT INTO Pais VALUES('Filipinas');
INSERT INTO Pais VALUES('Finlandia');
INSERT INTO Pais VALUES('Fiyi');
INSERT INTO Pais VALUES('Francia');
INSERT INTO Pais VALUES('Gabón');
INSERT INTO Pais VALUES('Gambia');
INSERT INTO Pais VALUES('Georgia');
INSERT INTO Pais VALUES('Islas Georgias del Sur y Sandwich del Sur');
INSERT INTO Pais VALUES('Ghana');
INSERT INTO Pais VALUES('Gibraltar');
INSERT INTO Pais VALUES('Granada');
INSERT INTO Pais VALUES('Grecia');
INSERT INTO Pais VALUES('Groenlandia');
INSERT INTO Pais VALUES('Guadalupe');
INSERT INTO Pais VALUES('Guam');
INSERT INTO Pais VALUES('Guatemala');
INSERT INTO Pais VALUES('Guayana Francesa');
INSERT INTO Pais VALUES('Guinea');
INSERT INTO Pais VALUES('Guinea Ecuatorial');
INSERT INTO Pais VALUES('Guinea-Bissau');
INSERT INTO Pais VALUES('Guyana');
INSERT INTO Pais VALUES( 'Haití');
INSERT INTO Pais VALUES( 'Islas Heard y McDonald');
INSERT INTO Pais VALUES( 'Honduras');
INSERT INTO Pais VALUES( 'Hong Kong');
INSERT INTO Pais VALUES( 'Hungría');
INSERT INTO Pais VALUES( 'India');
INSERT INTO Pais VALUES( 'Indonesia');
INSERT INTO Pais VALUES( 'Irán');
INSERT INTO Pais VALUES( 'Iraq');
INSERT INTO Pais VALUES( 'Irlanda');
INSERT INTO Pais VALUES( 'Islandia');
INSERT INTO Pais VALUES( 'Israel');
INSERT INTO Pais VALUES( 'Italia');
INSERT INTO Pais VALUES( 'Jamaica');
INSERT INTO Pais VALUES( 'Japón');
INSERT INTO Pais VALUES( 'Jordania');
INSERT INTO Pais VALUES( 'Kazajstán');
INSERT INTO Pais VALUES( 'Kenia');
INSERT INTO Pais VALUES( 'Kirguistán');
INSERT INTO Pais VALUES( 'Kiribati');
INSERT INTO Pais VALUES( 'Kuwait');
INSERT INTO Pais VALUES( 'Laos');
INSERT INTO Pais VALUES( 'Lesotho');
INSERT INTO Pais VALUES( 'Letonia');
INSERT INTO Pais VALUES( 'Líbano');
INSERT INTO Pais VALUES( 'Liberia');
INSERT INTO Pais VALUES( 'Libia');
INSERT INTO Pais VALUES( 'Liechtenstein');
INSERT INTO Pais VALUES( 'Lituania');
INSERT INTO Pais VALUES( 'Luxemburgo');
INSERT INTO Pais VALUES( 'Macao');
INSERT INTO Pais VALUES( 'ARY Macedonia');
INSERT INTO Pais VALUES( 'Madagascar');
INSERT INTO Pais VALUES( 'Malasia');
INSERT INTO Pais VALUES( 'Malawi');
INSERT INTO Pais VALUES( 'Maldivas');
INSERT INTO Pais VALUES( 'Malí');
INSERT INTO Pais VALUES( 'Malta');
INSERT INTO Pais VALUES( 'Islas Malvinas');
INSERT INTO Pais VALUES( 'Islas Marianas del Norte');
INSERT INTO Pais VALUES( 'Marruecos');
INSERT INTO Pais VALUES( 'Islas Marshall');
INSERT INTO Pais VALUES( 'Martinica');
INSERT INTO Pais VALUES( 'Mauricio');
INSERT INTO Pais VALUES( 'Mauritania');
INSERT INTO Pais VALUES( 'Mayotte');
INSERT INTO Pais VALUES( 'México');
INSERT INTO Pais VALUES( 'Micronesia');
INSERT INTO Pais VALUES( 'Moldavia');
INSERT INTO Pais VALUES( 'Mónaco');
INSERT INTO Pais VALUES( 'Mongolia');
INSERT INTO Pais VALUES( 'Montserrat');
INSERT INTO Pais VALUES( 'Mozambique');
INSERT INTO Pais VALUES( 'Myanmar');
INSERT INTO Pais VALUES( 'Namibia');
INSERT INTO Pais VALUES( 'Nauru');
INSERT INTO Pais VALUES( 'Nepal');
INSERT INTO Pais VALUES( 'Nicaragua');
INSERT INTO Pais VALUES( 'Níger');
INSERT INTO Pais VALUES( 'Nigeria');
INSERT INTO Pais VALUES( 'Niue');
INSERT INTO Pais VALUES( 'Isla Norfolk');
INSERT INTO Pais VALUES( 'Noruega');
INSERT INTO Pais VALUES( 'Nueva Caledonia');
INSERT INTO Pais VALUES( 'Nueva Zelanda');
INSERT INTO Pais VALUES( 'Omán');
INSERT INTO Pais VALUES( 'Países Bajos');
INSERT INTO Pais VALUES( 'Pakistán');
INSERT INTO Pais VALUES( 'Palau');
INSERT INTO Pais VALUES( 'Palestina');
INSERT INTO Pais VALUES( 'Panamá');
INSERT INTO Pais VALUES( 'Papúa Nueva Guinea');
INSERT INTO Pais VALUES( 'Paraguay');
INSERT INTO Pais VALUES( 'Perú');
INSERT INTO Pais VALUES( 'Islas Pitcairn');
INSERT INTO Pais VALUES( 'Polinesia Francesa');
INSERT INTO Pais VALUES( 'Polonia');
INSERT INTO Pais VALUES( 'Portugal');
INSERT INTO Pais VALUES( 'Puerto Rico');
INSERT INTO Pais VALUES( 'Qatar');
INSERT INTO Pais VALUES( 'Reino Unido');
INSERT INTO Pais VALUES( 'Reunión');
INSERT INTO Pais VALUES( 'Ruanda');
INSERT INTO Pais VALUES( 'Rumania');
INSERT INTO Pais VALUES( 'Rusia');
INSERT INTO Pais VALUES( 'Sahara Occidental');
INSERT INTO Pais VALUES( 'Islas Salomón');
INSERT INTO Pais VALUES( 'Samoa');
INSERT INTO Pais VALUES( 'Samoa Americana');
INSERT INTO Pais VALUES( 'San Cristóbal y Nevis');
INSERT INTO Pais VALUES( 'San Marino');
INSERT INTO Pais VALUES( 'San Pedro y Miquelón');
INSERT INTO Pais VALUES( 'San Vicente y las Granadinas');
INSERT INTO Pais VALUES( 'Santa Helena');
INSERT INTO Pais VALUES( 'Santa Lucía');
INSERT INTO Pais VALUES( 'Santo Tomé y Príncipe');
INSERT INTO Pais VALUES( 'Senegal');
INSERT INTO Pais VALUES( 'Serbia y Montenegro');
INSERT INTO Pais VALUES( 'Seychelles');
INSERT INTO Pais VALUES( 'Sierra Leona');
INSERT INTO Pais VALUES( 'Singapur');
INSERT INTO Pais VALUES( 'Siria');
INSERT INTO Pais VALUES( 'Somalia');
INSERT INTO Pais VALUES( 'Sri Lanka');
INSERT INTO Pais VALUES( 'Suazilandia');
INSERT INTO Pais VALUES( 'Sudáfrica');
INSERT INTO Pais VALUES( 'Sudán');
INSERT INTO Pais VALUES( 'Suecia');
INSERT INTO Pais VALUES( 'Suiza');
INSERT INTO Pais VALUES( 'Surinam');
INSERT INTO Pais VALUES( 'Svalbard y Jan Mayen');
INSERT INTO Pais VALUES( 'Tailandia');
INSERT INTO Pais VALUES( 'Taiwán');
INSERT INTO Pais VALUES( 'Tanzania');
INSERT INTO Pais VALUES( 'Tayikistán');
INSERT INTO Pais VALUES( 'Territorio Británico del Océano Índico');
INSERT INTO Pais VALUES( 'Territorios Australes Franceses');
INSERT INTO Pais VALUES( 'Timor Oriental');
INSERT INTO Pais VALUES( 'Togo');
INSERT INTO Pais VALUES( 'Tokelau');
INSERT INTO Pais VALUES( 'Tonga');
INSERT INTO Pais VALUES( 'Trinidad y Tobago');
INSERT INTO Pais VALUES( 'Túnez');
INSERT INTO Pais VALUES( 'Islas Turcas y Caicos');
INSERT INTO Pais VALUES( 'Turkmenistán');
INSERT INTO Pais VALUES( 'Turquía');
INSERT INTO Pais VALUES( 'Tuvalu');
INSERT INTO Pais VALUES( 'Ucrania');
INSERT INTO Pais VALUES( 'Uganda');
INSERT INTO Pais VALUES( 'Uruguay');
INSERT INTO Pais VALUES( 'Uzbekistán');
INSERT INTO Pais VALUES( 'Vanuatu');
INSERT INTO Pais VALUES( 'Venezuela');
INSERT INTO Pais VALUES( 'Vietnam');
INSERT INTO Pais VALUES( 'Islas Vírgenes Británicas');
INSERT INTO Pais VALUES( 'Islas Vírgenes de los Estados Unidos');
INSERT INTO Pais VALUES( 'Wallis y Futuna');
INSERT INTO Pais VALUES( 'Yemen');
INSERT INTO Pais VALUES( 'Yibuti');
INSERT INTO Pais VALUES( 'Zambia');
INSERT INTO Pais VALUES( 'Zimbabue');

-- INSERTANDO DATOS TABLA CIUDAD --
INSERT INTO Ciudad
	VALUES ('Panam�'),
		   ('Col�n'),
		   ('Chiriqu�'),
		   ('David'),
		   ('Santiago de Veraguas'),
		   ('Las Cumbres');

-- INSERTANDO DATOS TABLA PROVINCIA --
INSERT INTO Provincia
	VALUES ('Bocas del Toro'),
		   ('Cocl�'),
		   ('Col�n'),
		   ('Chiriqu�'),
		   ('Dari�n'),
		   ('Herrera'),
		   ('Los Santos'),
		   ('Panam�'),
		   ('Veraguas'),
		   ('Guna Yala, Madugand� y Wargand�'),
		   ('Ember� Wounan'),
		   ('Ng�be-Bugl�'),
		   ('Panam� Oeste');

