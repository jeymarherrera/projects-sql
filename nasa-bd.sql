-- PROYECTO NASA
DROP DATABASE Nasa
CREATE DATABASE Nasa
USE Nasa;

--Se creo en orden diferente, para ir creando las FK de otra tablas
--CREANDO TABLA NAVE
CREATE TABLE Nave(
  cod_nave int 
          CONSTRAINT CK_COD_NAVE CHECK(cod_nave like '[1][0-9][0-9][0-9]')
		  CONSTRAINT Cod_nave_PK PRIMARY KEY,	
  año_contruccion date unique          
);

--CREANDO TABLA MISION
CREATE TABLE Mision(

   cod_mision int identity
		CONSTRAINT cod_mision PRIMARY KEY,
   nombre_mision VARCHAR(40) NOT NULL, 
   costo money,
		 CONSTRAINT CK_Costo CHECK(Costo >= 100000 or Costo <=200000 ),
   aterrizaje char
		  CONSTRAINT  Aterrizaje CHECK(aterrizaje like '%S%' or aterrizaje like '%N%'),
   cod_nave  int,
		CONSTRAINT FK_cod_nave FOREIGN KEY (cod_nave) REFERENCES Nave(cod_nave)	
)

--CREANDO TABLA ASTRONAUTA
CREATE TABLE Astronauta(
	codigo_ast VARCHAR
		CONSTRAINT CK_Codigo_ast CHECK(Codigo_ast like '[a-z][a-z][-][0-9][0-9][0-9]') -- Verifica el formato del astronauta --		
		CONSTRAINT Codigo_ast_PK PRIMARY KEY, --PRIMARY KEY
	nombre_ast VARCHAR(25) NOT NULL,
	peso int NOT NULL
		CHECK (peso >= 0), 
	fecha_nac DATE NOT NULL
		CONSTRAINT CK_fecha_nac CHECK(datediff(day,getdate(),fecha_nac)<0),
	cod_mision  int,
		CONSTRAINT FK_cod_mision FOREIGN KEY (cod_mision) REFERENCES Mision(cod_mision)
);

--CREANDO TABLA TAREA
CREATE TABLE Tarea(

   cod_tarea VARCHAR(3)
   CHECK(cod_tarea  like '[T][a-z][a-z]')
   CONSTRAINT cod_tarea  PRIMARY KEY,

   nombre_tarea VARCHAR(70) not null,
   nivel_dificultad INT
   CONSTRAINT CK_Nivel_Dificultad CHECK (nivel_dificultad IN ('1','2','3','4','5'))  
   CONSTRAINT DF_Nivel_Dificultad DEFAULT '1'		
)
--CREANDO TABLA ASTRONAUTA_TAREA
CREATE TABLE Astronauta_tarea(

   codigo_ast Varchar
		CONSTRAINT CK_CODIGO_AT CHECK(Codigo_ast like '[a-z][a-z][-][0-9][0-9][0-9]')
		CONSTRAINT FK_COD_AST  FOREIGN KEY REFERENCES  Astronauta(codigo_ast),
   cod_tarea Varchar(3)
		CONSTRAINT FK_cod_tarea  FOREIGN KEY REFERENCES  tarea(cod_tarea),
   fecha_inicio date, 
   fecha_fin  date, 
		CONSTRAINT PK_Astronauta_Tarea PRIMARY KEY(codigo_ast,cod_tarea)		   					
)

--Elimine de la tabla MISIÓN el atributo aterrizaje
ALTER TABLE Mision --primero debemos eliminar el check de esta tabla
DROP CONSTRAINT  Aterrizaje

ALTER TABLE Mision -- eliminamos el atributo
DROP COLUMN aterrizaje

SELECT *
FROM Mision

--Se ha detectado que hay misiones con nombres más largos de 40 caracteres.  Cambie la longitud del campo nombre_mision tabla (MISION) de 40 a 60 posiciones
ALTER TABLE Mision
ALTER COLUMN nombre_mision VARCHAR(60) -- cambio en la longitud

--INSERTANDO DATOS EXTRAS
INSERT INTO Nave
VALUES(1887,'1991-09-09'),(1897,'1999-12-08'),(1487,'2011-10-20')

SELECT *
FROM Nave

INSERT INTO [dbo].[Mision]
           ([nombre_mision]
           ,[costo]
           ,[cod_nave])
     VALUES ('Oportunity' ,'150000.00' ,1887),
	       ('Community' ,'185000'  ,1897),
        	( 'Challenger' ,'185000'  ,1487),
	       ('Interestellar' ,'185000' ,1487)

SELECT *
FROM Mision

--Inserte en la tabla ASTRONAUTA los datos mostrados en **1 (están después de la tabla de respuesta).  Muestre los insert y un select al final para poder observar lo insertado.
ALTER TABLE Astronauta
ALTER COLUMN codigo_ast char(6) -- cambio en la longitud

INSERT INTO [dbo].[Astronauta]
           ([codigo_ast]
           ,[nombre_ast]
           ,[peso]
           ,[fecha_nac]
           ,[cod_mision])
     VALUES
           ('yg-123','Yuri Gagarin',167,'9-2-1934',1),
		     ('na-108','Neil Armstrong',135,'12-12-1995',2),
			   ('fb-805','Frank Borman II',170,'8-15-1934',3),
			     ('vk-345' ,'Vladímir Komarov',145,'9-27-1934',4)

--Inserte en la tabla TAREA los datos mostrados en **2 (están después de la tabla de respuesta).  Muestre los insert y un select al final para poder observar lo insertado.

--Inserte  3 registros de datos a la tabla  Astronauta_Tarea), indicando que astronauta realizan que tarea.    Invente la combinación (Muestre los insert realizados). Luego de insertar los mismos, muéstrelos con un select.
INSERT INTO [dbo].[Astronauta_tarea]
           ([codigo_ast]
           ,[cod_tarea]
           ,[fecha_inicio]
           ,[fecha_fin])
     VALUES
           ('yg-123' ,'Tmd','7-22-1996','2-27-1997'),
		   ('na-108' ,'Tgo','3-14-1986','9-18-2002'),
		   ('vk-345' ,'Tcr','4-13-1995','7-15-2001'),
		   ('fb-805' ,'Tex','2-2-1983','8-4-1999')

--Realice una consulta en la tabla Astronauta que permita mostrar cuantos astronautas son menores de 40 años. Trabaje con la fecha del sistema. Muestre el nombre del astronauta, la fecha de nacimiento, y la edad calculada

select nombre_ast  as 'Astronautas con mas de  40 años', DATEDIFF(year,fecha_nac,getdate()) as EDAD from [Astronauta];