-- MYFLIX
CREATE DATABASE Myflix;

USE Myflix;

--MIEMBROS
CREATE TABLE miembros (
	numero_socio INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(350) NOT NULL,
    genero VARCHAR(6) NULL, 
    fecha_nacimiento DATE NULL,
    direccion_fisica VARCHAR(255) NULL,
    direccion_postal VARCHAR(255) NULL,
    numero_contacto VARCHAR(75) NULL,
    correo_electronico VARCHAR(255) NULL
    );
 
--PRUEBA ALTER
ALTER TABLE miembros
ADD credit_card_number VARCHAR(25);

--PRUEBA
SHOW COLUMNS FROM miembros;

--PRUEBA
ALTER TABLE miembros
DROP COLUMN credit_card_number;

--PRUEBA
SHOW COLUMNS FROM miembros;