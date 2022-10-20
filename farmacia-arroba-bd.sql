/*
	PROYECTO #3

	Farmacias Arroba
*/
--------------------------------------------------------------------------
-- 1. MODELO RELACIONAL

/*
	Cliente(cedula(PK), nombre_cl)
	Deuda(cod_deuda(PK),cedula(FK), monto_total)
	Juguete(cod_juguete, nombre_juguete, cantidad_exist, precio)
	Abono_o_Pago(cod_abono(PK), cod_deuda(FK), monto, fecha)
	Separa_juguetes(cod_juguete(FK)(PK), cod_deuda(FK)(PK), cantidad)
*/
---------------------------------------------------------------------------
-- 2. CREACION DE LAS TABLAS

CREATE DATABASE Farmacias_Arroba;

USE Farmacias_Arroba;

-- TABLA CLIENTE

CREATE TABLE Cliente (
	cedula VARCHAR(20) NOT NULL
		CONSTRAINT PK_Cliente_cedula PRIMARY KEY
		CONSTRAINT CK_Cliente_cedula CHECK(cedula LIKE '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]' -- 1-1234-12345 --
										or cedula LIKE '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12-1234-12345 --
										or cedula LIKE '[P][E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- PE-1234-12345 --
										or cedula LIKE '[E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- E-1234-12345 --
										or cedula LIKE '[N][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- N-1234-12345 --
										or cedula LIKE '[0][0-9][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1PI-1234-12345 --
										or cedula LIKE '[1][0-3][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12PI-1234-12345 --
										or cedula LIKE '[0][0-9][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1AV-1234-12345 --
										or cedula LIKE '[1][0-3][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
	nombre_cl VARCHAR(20) NOT NULL
)

-- TABLA DEUDA

CREATE TABLE Deuda (
	cod_deuda INT IDENTITY
		CONSTRAINT PK_Deuda_cod_deuda PRIMARY KEY,
	cedula VARCHAR(20) NOT NULL
		CONSTRAINT CK_Deuda_cedula CHECK(cedula LIKE '[0][0-9][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]' -- 1-1234-12345 --
										or cedula LIKE '[1][0-3][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12-1234-12345 --
										or cedula LIKE '[P][E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- PE-1234-12345 --
										or cedula LIKE '[E][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- E-1234-12345 --
										or cedula LIKE '[N][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'		-- N-1234-12345 --
										or cedula LIKE '[0][0-9][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1PI-1234-12345 --
										or cedula LIKE '[1][0-3][P][I][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 12PI-1234-12345 --
										or cedula LIKE '[0][0-9][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'	-- 1AV-1234-12345 --
										or cedula LIKE '[1][0-3][A][V][-][0-9][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]')
		CONSTRAINT FK_Deuda_cedula FOREIGN KEY (cedula) REFERENCES Cliente(cedula),
	monto_total MONEY NULL
)

-- TABLA JUGUETE

CREATE TABLE Juguete (
	cod_juguete CHAR(4)
		CONSTRAINT PK_Juguete_cod_juguete PRIMARY KEY,
	nombre_juguete VARCHAR(15) NOT NULL,
	cantidad_exist INT NOT NULL,
	precio MONEY NOT NULL
)

-- TABLA ABONO_O_PAGO

CREATE TABLE Abono_o_Pago (
	cod_abono INT IDENTITY
		CONSTRAINT PK_Abono_o_Pago_cod_abono PRIMARY KEY,
	cod_deuda INT NOT NULL
		CONSTRAINT FK_Abono_o_Pago_cod_deuda FOREIGN KEY (cod_deuda) REFERENCES Deuda(cod_deuda),
	monto MONEY NOT NULL,
	fecha DATE
		CONSTRAINT DF_Abono_o_Pago_fecha DEFAULT GETDATE()
)

-- TABLA SEPARA_JUGUETES

CREATE TABLE Separa_juguetes (
	cod_juguete CHAR(4)
		CONSTRAINT FK_Separa_juguetes_cod_juguete FOREIGN KEY (cod_juguete) REFERENCES Juguete (cod_juguete),
	cod_deuda INT
		CONSTRAINT FK_Separa_juguetes_cod_deuda FOREIGN KEY (cod_deuda) REFERENCES  Deuda (cod_deuda),
	CONSTRAINT PK_Separa_juguetes_cod_juguete_cod_deuda PRIMARY KEY (cod_juguete, cod_deuda),
	cantidad INT NOT NULL
)

-----------------------------------------------------
-- 3. INSERTS OBLIGATORIOS

-- TABLA CLIENTE

INSERT INTO Cliente(cedula, nombre_cl)
	VALUES ('08-0888-08888','Pedro Lopez'),
		   ('09-0999-09999', 'Marta Bethancure'),
		   ('10-0101-01010', 'Luis Rosas'),
		   ('07-0777-07777','Eneida Espinosa'),
		   ('01-0111-01111', 'Juan Perez')

SELECT * FROM Cliente;

-- TABLA JUGUETE

INSERT INTO Juguete (cod_juguete, nombre_juguete, cantidad_exist, precio)
	VALUES ('ju01','barbie',3, 20.95),
		   ('ju02', 'nintendo',5,300.00),
		   ('ju03', 'PS4',2, 500),
		   ('ju04','dron',1,250.00),
		   ('ju05', 'carrito control',5, 15.00),
		   ('ju06', 'bicicleta',2,150.00),
		   ('ju07', 'patines',2, 50),
		   ('ju08','muñeca trapo',1,25.00),
		   ('ju09', 'muñeca pasea',5, 35.00),
		   ('ju10','pelota futball',3, 10.00),
		   ('ju11', 'pelota tenis',5,1.00),
		   ('ju12', 'juego pin pong',2, 25.00),
		   ('ju13','compu personal',5,250.00),
		   ('ju14', 'piano electr',5, 97.95),
		   ('ju15', 'coche barbie',2,15.00)

SELECT * FROM Juguete;

-------------------------------------------------------------
-- 4. TRIGGER INTEGRIDAD TABLA JUGUETES

CREATE TRIGGER trigger_integridad_juguetes
ON Separa_juguetes
INSTEAD OF INSERT
AS
	DECLARE @cod_juguete CHAR(4),
			@cod_deuda INT,
			@cantidad INT

	SELECT @cod_juguete = cod_juguete,
		   @cod_deuda = cod_deuda,
		   @cantidad = cantidad
	FROM inserted

	IF (SELECT cantidad_exist FROM Juguete WHERE cod_juguete = @cod_juguete) >= @cantidad
	BEGIN
		INSERT INTO Separa_juguetes
			VALUES (@cod_juguete, @cod_deuda, @cantidad)

		UPDATE Juguete
		SET cantidad_exist = cantidad_exist - @cantidad
		WHERE cod_juguete = @cod_juguete
	END
	ELSE
		PRINT 'INSERT REVOCADO, LA CANTIDAD EN INVENTARIO ES MENOR A LA SOLICITADA';

-----------------------------------------------------------
--5. PROCEDIMIENTO MONTO DEUDA

CREATE PROCEDURE pa_monto_deuda
	@cod_deuda INT
AS
	DECLARE @cant INT, -- cantidad de juguetes de uno especifico
			@precio MONEY, -- el precio que se suma para el total
			@precio_u MONEY -- para el precio para un juguete especifico

	SET @precio = 0
	-- para poder recorrer uno a uno y multiplicar cada registro
	DECLARE cursor_pa_monto_deuda CURSOR
	FOR
		SELECT a.cantidad, b.precio 
		FROM Separa_juguetes AS a INNER JOIN Juguete AS b ON a.cod_juguete = b.cod_juguete
		WHERE cod_deuda = @cod_deuda

	-- abriendo el cursor
	OPEN cursor_pa_monto_deuda

	FETCH NEXT FROM cursor_pa_monto_deuda
	    INTO @cant, @precio_u

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @precio = @precio + (@cant * @precio_u)

		FETCH NEXT FROM cursor_pa_monto_deuda
	    INTO @cant, @precio_u
	END

	-- CIERRE DEL CURSOR

	CLOSE cursor_pa_monto_deuda
	
	-- LIBERAR RECURSOS

	DEALLOCATE cursor_pa_monto_deuda
	-- UPDATE A LA TABLA DEUDA
	UPDATE Deuda
	SET monto_total = @precio
	WHERE cod_deuda = @cod_deuda;

-----------------------------------------------------------------------------
--6

-- TIGGGER     Actualizar_saldod      
Create trigger Actualizar_saldod   -- --Creacion de tigger 
on Abono_o_Pago
instead of insert
as

declare @MONTO_PROC money   --MONTO procesado          -- --Variables del tigger
		,@suma_montos money -- sumatoria de los pagos
	   ,@MONTO_TEM money    --MONTO temporal
	   ,@tem_deuda int      --Codigo temporal de deuda
	   ,@Abono_tem money    --Abono temporal 
		,@pagos int	--numero de pagos realizados
		,@porcentaje MONEY -- para calcular cuanto es el 10%

select @Abono_tem =  monto, @tem_deuda=cod_deuda  from inserted -- --tabla de abonos
 
SELECT @pagos = COUNT(*) FROM Abono_o_Pago WHERE cod_deuda = @tem_deuda -- contando los pagos

select @MONTO_TEM=d.monto_total from [dbo].[Deuda] d WHERE cod_deuda = @tem_deuda -- --tabla de deudas 

if (@pagos > 0)
	select @suma_montos = SUM(monto) FROM Abono_o_Pago WHERE cod_deuda = @tem_deuda  -- sumando los pagos si al contarlo existian previos
else
	set @suma_montos = 0 -- set cero para evitar que tome valor null en caso de que no habian pagos previos

SET @MONTO_PROC = @MONTO_TEM - (@suma_montos + @Abono_tem) -- calculando deuda

SET @porcentaje = (@MONTO_TEM * 10) /100 -- calculado cuanto es el 10%

if (@pagos = 0) -- verificamos si es el primer pago      
begin
	if(@Abono_tem >= @porcentaje) -- verificamos si el pago es mayor o igual al 10% de la deuda
	begin
		if(@MONTO_PROC>0)                -->Sentecia de Deuda no cancelada
		begin
			INSERT INTO Abono_o_Pago
				VALUES(@tem_deuda, @Abono_tem, GETDATE())
			print 'SALDO PENDIENTE ACTUAL '+cast(@MONTO_PROC as varchar)     -- Saldo pendiente
		end
		else 
		begin
			if(@MONTO_PROC=0)      -->Sentecia para cuando el abono cancela la deuda	   
			begin
				DELETE FROM Abono_o_Pago WHERE cod_deuda = @tem_deuda
				DELETE FROM Separa_juguetes WHERE cod_deuda = @tem_deuda
				DELETE FROM Deuda WHERE cod_deuda = @tem_deuda
				
				print 'DEUDA CANCELADA'
			end
			else -- en caso de el pago fuera mayor a la deuda
				print 'EL ABONO QUE TRATA DE INGRESAR ES MAYOR A LA DEUDA, INSERT CANCELADO'
		end
	end
	else -- en caso de el abono sea menor al 10% de la deuda
		print 'EL PRIMER ABONO DEBE CORRESPONDER AL 10% DE LA DEUDA, INSERT CANCELADO'
end
else -- si existen pagos previos
begin
	if(@MONTO_PROC>0)                -->Sentecia de Deuda no cancelada
	begin
		INSERT INTO Abono_o_Pago
			VALUES(@tem_deuda, @Abono_tem, GETDATE())
		print 'SALDO PENDIENTE ACTUAL '+cast(@MONTO_PROC as varchar)     -- Saldo pendiente
	end
	else 
	begin
		if(@MONTO_PROC=0)      -->Sentecia para cuando el abono cancela la deuda	   
		begin
			DELETE FROM Abono_o_Pago WHERE cod_deuda = @tem_deuda
			DELETE FROM Separa_juguetes WHERE cod_deuda = @tem_deuda
			DELETE FROM Deuda WHERE cod_deuda = @tem_deuda
			print 'DEUDA CANCELADA'
	    end
		else -- si el pago es manyor al total de la deuda
			print 'EL ABONO QUE TRATA DE INGRESAR ES MAYOR A LA DEUDA, INSERT CANCELADO'
	end
end
 -- FIN TIGGER Actualizar_saldod 

-----------------------------------------------------------------------------------------
--7. CURSOR GENERAR REPORTE
DECLARE
	@cliente VARCHAR(20),
	@codigo_deuda INT,
	@monto_deuda MONEY;

DECLARE cursor_generar_reporte CURSOR
	FOR SELECT
		Cliente.nombre_cl,
		Deuda.cod_deuda,
		Deuda.monto_total
	FROM
		Cliente
		INNER JOIN Deuda ON Deuda.cedula = Cliente.cedula

OPEN cursor_generar_reporte;
FETCH NEXT FROM cursor_generar_reporte INTO
	@cliente,
	@codigo_deuda,
	@monto_deuda;

DECLARE
	@anterior VARCHAR(20),
	@actual VARCHAR(20);

SET @anterior = @cliente;
SET @actual = '';

WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @abono_total MONEY;
		SELECT 
			@abono_total = COALESCE(SUM(monto), 0)
		FROM 
			Abono_o_Pago
		WHERE cod_deuda = @codigo_deuda;

		IF @anterior != @actual
			BEGIN
				PRINT '';
				PRINT 'CLIENTE: ' + @cliente;
				PRINT 'DEUDAS:';				
				SET @anterior = @cliente;
			END;
		PRINT '        COD: ' + CAST(@codigo_deuda AS VARCHAR) + '. Monto total: B/. ' + 
			CAST(@monto_deuda AS VARCHAR) + '. SALDO PENDIENTE: ' + CAST(@monto_deuda - @abono_total AS VARCHAR);		
		FETCH NEXT FROM cursor_generar_reporte INTO
			@cliente,
			@codigo_deuda,
			@monto_deuda;
		SET @actual = @cliente;
	END;

CLOSE cursor_generar_reporte;
DEALLOCATE cursor_generar_reporte;

---------------------------------------------------------------------------------
-- PRUEBAS DE INSERT, EJECUCION DE PROCEDIMIENTOS Y TRIGGERS
/*
SELECT * FROM Cliente
SELECT * FROM Juguete
SELECT * FROM Deuda
SELECT * FROM Separa_juguetes
SELECT * FROM Abono_o_Pago
*/

--INSERT INTO Deuda (cedula) -- deudas de prueba
--	VALUES ('01-0111-01111'),
--		   ('07-0777-07777'),
--		   ('07-0777-07777'),
--		   ('10-0101-01010')

--INSERT INTO Separa_juguetes -- juguetes separados de prueba
--	VALUES ('ju07', 4, 2)
--INSERT INTO Separa_juguetes
--	VALUES ('ju01', 1, 2)
--INSERT INTO Separa_juguetes
--	VALUES ('ju02', 1, 1)
--INSERT INTO Separa_juguetes
--	VALUES ('ju04', 2, 3)
--INSERT INTO Separa_juguetes
--	VALUES ('ju03', 2, 2)
--INSERT INTO Separa_juguetes
--	VALUES ('ju08', 3, 1)

--EXECUTE pa_monto_deuda 1 -- ejecucion de procedimiento que calcula el monto total por cada codigo de deuda de prueba
--EXECUTE pa_monto_deuda 2
--EXECUTE pa_monto_deuda 3
--EXECUTE pa_monto_deuda 4

---- PRUEBA DE ABONOS

--INSERT INTO Abono_o_Pago(cod_deuda, monto)
--	VALUES(1, 1) -- no debe entrar

--SELECT * FROM Abono_o_Pago -- verificar

--INSERT INTO Abono_o_Pago(cod_deuda, monto)
--	VALUES(1, 341.90) -- debe eliminar todos los registros en la base de datos ya que se cancela la deuda

--SELECT * FROM Abono_o_Pago -- verificar que no existen registros ya que la deuda se cancelo

--INSERT INTO Abono_o_Pago(cod_deuda, monto)
--	VALUES(2, 1001) -- no debe entrar porque el pago es mayor a la deuda

--SELECT * FROM Abono_o_Pago -- verificar

--INSERT INTO Abono_o_Pago(cod_deuda, monto)
--	VALUES(2, 500) -- debe de entrar sin problemas

--SELECT * FROM Abono_o_Pago -- verificar