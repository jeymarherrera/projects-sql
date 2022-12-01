GO
USE MASTER;
GO
DROP DATABASE IF EXISTS Congreso_UTP_V2;
GO
CREATE DATABASE Congreso_UTP_V2;
GO
USE Congreso_UTP_V2;
GO

-- CREANDO TABLA PAIS --
CREATE TABLE Pais(
	id_pais INT IDENTITY
		CONSTRAINT PK_Pais_id_pais PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

-- CREANDO TABLA CIUDAD --
CREATE TABLE Ciudad(
	id_ciudad INT IDENTITY
		CONSTRAINT PK_Ciudad_id_ciudad PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL,
	id_pais INT NOT NULL
	CONSTRAINT FK_Pais_id_pais FOREIGN KEY
		REFERENCES Pais(id_pais)
);

-- CREANDO TABLA ENTIDAD --
CREATE TABLE Entidad(
	id_entidad INT IDENTITY
		CONSTRAINT PK_Entidad_id_entidad PRIMARY KEY, 
	nombre VARCHAR (50) NOT NULL
);

-- CREANDO TABLA OCUPACION --
CREATE TABLE Ocupacion(
	id_ocupacion INT IDENTITY
		CONSTRAINT PK_Ocupacion_id_ocupacion PRIMARY KEY, 
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

-- CREANDO TABLA SALA --
CREATE TABLE Sala(
	id_sala INT IDENTITY
		CONSTRAINT PK_Sala_id_sala PRIMARY KEY, 
	num_sala VARCHAR(10) NOT NULL,
	cantidad_asientos INT NOT NULL
);

-- CREANDO TABLA TARIFA --
CREATE TABLE Tarifa(
	id_tarifa INT IDENTITY
		CONSTRAINT PK_Tarifa_id_tarifa PRIMARY KEY, 
	tipo_usuario VARCHAR (50) NOT NULL,
	monto MONEY NOT NULL
);

-- CREANDO TABLA USUARIO --
CREATE TABLE Usuario(
	id_usuario VARCHAR(20) NOT NULL
		CONSTRAINT PK_Usuario_id_usuario PRIMARY KEY,	
    tipo_usuario VARCHAR(20) NOT NULL,
    cod_estudiante VARCHAR(50) NULL,    
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NULL,
	sexo CHAR(2)
		CONSTRAINT CK_Usuario_sexo CHECK(sexo IN ('F', 'M')),		
	gafete VARCHAR(255) NULL,
	id_ciudad INT NULL
		CONSTRAINT FK_Usuario_id_ciudad FOREIGN KEY
			REFERENCES Ciudad(id_ciudad),
	id_ocupacion INT NOT NULL
		CONSTRAINT FK_Usuario_id_ocupacion FOREIGN KEY
			REFERENCES Ocupacion(id_ocupacion),
	id_entidad INT NULL
		CONSTRAINT FK_Usuario_id_entidad FOREIGN KEY
			REFERENCES Entidad(id_entidad),
    cod_ieee INT NULL
		CONSTRAINT FK_Usuario_cod_ieee FOREIGN KEY
			REFERENCES IEEE(cod_ieee),
	cod_wpa INT NULL
		CONSTRAINT FK_Usuario_cod_wpa FOREIGN KEY
			REFERENCES WPA(cod_wpa),        
);

-- CREANDO TABLA USUARIO_AREA --
CREATE TABLE Usuario_Area(
	id_usuario VARCHAR(20) NOT NULL
		CONSTRAINT FK_Usuario_Area_id_usuario FOREIGN KEY
			REFERENCES Usuario(id_usuario),
	id_area INT NOT NULL
		CONSTRAINT FK_Usuario_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Usuario_Area_id_usuario_id_area PRIMARY KEY(id_usuario, id_area),
);

-- CREANDO TABLA CREDENCIAL--
CREATE TABLE Credencial(
	id_credencial INT IDENTITY
		CONSTRAINT PK_Credencial_id_credencial PRIMARY KEY, 
	correo VARCHAR (50) NOT NULL
        CONSTRAINT CK_Credencial_correo CHECK (correo LIKE '%@%')
            CONSTRAINT UQ_Credencial_cedula UNIQUE, 
    contrasena VARCHAR (100) NOT NULL,
    id_usuario VARCHAR(20) NULL
	CONSTRAINT FK_Credenciales_id_usuario FOREIGN KEY
		REFERENCES Usuario(id_usuario)
);

-- CREANDO TABLA PAGO --
CREATE TABLE Pago(
	id_pago INT IDENTITY
		CONSTRAINT PK_Pago_id_pago PRIMARY KEY, 
	fecha DATETIME NOT NULL,
	metodo VARCHAR (50) NOT NULL,
	descuento MONEY NOT NULL DEFAULT (0),
	cena MONEY NOT NULL,
	comision MONEY NOT NULL,
	comision_pago MONEY NOT NULL,
	monto_total MONEY NOT NULL,
	estado CHAR(1) NULL,
    id_tarifa INT NULL
	CONSTRAINT FK_Pago_id_tarifa FOREIGN KEY
		REFERENCES Tarifa(id_tarifa),
    id_usuario VARCHAR(20) NULL
	CONSTRAINT FK_Pago_id_usuario FOREIGN KEY
		REFERENCES Usuario(id_usuario)
);

-- CREANDO TABLA ARTICULO --
CREATE TABLE Articulo(
	id_articulo INT IDENTITY,
	cod_aprobado VARCHAR (50) NOT NULL,
	nombre VARCHAR (50) NOT NULL,
	id_usuario VARCHAR(20) NOT NULL
		CONSTRAINT FK_Articulo_id_usuario FOREIGN KEY
			REFERENCES Usuario(id_usuario),
	CONSTRAINT PK_Articulo_id_articulo PRIMARY KEY(id_articulo, cod_aprobado)
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

-- CREANDO TABLA ACTIVIDAD --
CREATE TABLE Actividad(
	id_actividad INT IDENTITY
		CONSTRAINT PK_Actividad_id_actividad PRIMARY KEY, 
    tipo_act VARCHAR(100) NOT NULL,    
	titulo VARCHAR(50) NOT NULL,
    horas_minimas INT NOT NULL,
	cantidad_ponencias INT NULL,
	fecha_inicio DATETIME NULL,
	fecha_fin DATETIME NULL,
	id_sala INT NOT NULL
		CONSTRAINT FK_Actividad_id_sala FOREIGN KEY
			REFERENCES Sala(id_sala),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Actividad_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso)
);

-- CREANDO TABLA ACTIVIDAD_AREA --
CREATE TABLE Actividad_Area(
	id_actividad INT NOT NULL
		CONSTRAINT FK_Actividad_Area_id_actividad FOREIGN KEY
			REFERENCES Actividad(id_actividad),
	id_area INT NOT NULL
		CONSTRAINT FK_Actividad_Area_id_area FOREIGN KEY
			REFERENCES Area(id_area),
	CONSTRAINT PK_Actividad_Area_id_actividad_id_area PRIMARY KEY(id_actividad, id_area),
);

-- CREANDO TABLA CRONOGRAMA --
CREATE TABLE Cronograma(
	id_cronograma INT NOT NULL,
    id_usuario VARCHAR(20) NOT NULL
        	CONSTRAINT FK_Usuario_id_usuario FOREIGN KEY
			REFERENCES Usuario(id_usuario),        
	titulo VARCHAR(50) NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	id_actividad INT NOT NULL
		CONSTRAINT FK_Cronograma_id_actividad FOREIGN KEY
			REFERENCES Actividad(id_actividad),
	CONSTRAINT PK_Cronograma_id_cronograma PRIMARY KEY(id_cronograma, id_usuario, fecha_inicio, fecha_fin)
);

-- CREANDO TABLA ASISTENCIA_ACTIVIDAD --
CREATE TABLE Asistencia_Actividad(
	id_asistencia_actividad INT NOT NULL,
	id_usuario VARCHAR(20) NOT NULL
		CONSTRAINT FK_Asistencia_Actividad_id_usuario FOREIGN KEY
			REFERENCES Usuario(id_usuario),
	id_actividad INT NOT NULL
		CONSTRAINT FK_Asistencia_Actividad_id_actividad FOREIGN KEY
			REFERENCES Actividad(id_actividad),
	CONSTRAINT PK_Asistencia_Actividad_id_asistencia_actividad PRIMARY KEY(id_asistencia_actividad, id_usuario, id_actividad),
	entrada TIMESTAMP NULL,
	salida DATETIME NULL,
);

-- CREANDO TABLA ASISTENCIA_CONGRESO --
CREATE TABLE Asistencia_Congreso(
	id_asistencia_congreso INT NOT NULL,
	id_usuario VARCHAR(20) NOT NULL
		CONSTRAINT FK_Asistencia_Congreso_id_usuario FOREIGN KEY
			REFERENCES Usuario(id_usuario),
	id_congreso INT NOT NULL
		CONSTRAINT FK_Asistencia_Congreso_id_congreso FOREIGN KEY
			REFERENCES Congreso(id_congreso),
	CONSTRAINT PK_Asistencia_Congreso_id_asistencia_congreso PRIMARY KEY(id_asistencia_congreso, id_usuario, id_congreso),
	entrada TIMESTAMP NULL,
	salida DATETIME NULL,
);


--CREANDO TABLA CERTIFICADO_ACTIVIDAD
CREATE TABLE Certificado_Actividad(
    id_certificado_actividad INT IDENTITY PRIMARY KEY,
    id_usuario VARCHAR(20)
        CONSTRAINT FK_Certificado_Actividad_id_usuario FOREIGN KEY 
            REFERENCES Usuario(id_usuario),
    id_actividad INT NOT NULL
        CONSTRAINT FK_Certificado_Actividad_id_actividad FOREIGN KEY 
            REFERENCES Actividad(id_actividad),
    total_horas INT NOT NULL,
    certificado VARCHAR(500) NULL
)

--CREANDO TABLA CERTIFICADO_CONGRESO
CREATE TABLE Certificado_Congreso(
    id_certificado_congreso INT IDENTITY PRIMARY KEY,
    id_usuario VARCHAR(20)
        CONSTRAINT FK_Certificado_Congreso_id_usuario FOREIGN KEY 
            REFERENCES Usuario(id_usuario),
    id_congreso INT NOT NULL
        CONSTRAINT FK_Certificado_Congreso_id_congreso FOREIGN KEY 
            REFERENCES Congreso(id_congreso),
    total_horas INT NOT NULL,
    certificado VARCHAR(500) NULL
)
