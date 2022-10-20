DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;
USE tienda;

--fabricante
CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

--producto
CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

--fabricante-producto
CREATE TABLE fabricante_productos (
  nombre_fabricante VARCHAR(100) NOT NULL,
  nombre_producto VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL
);

--inserts fabricante
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO fabricante VALUES(10, 'LG');
INSERT INTO fabricante (nombre) VALUES('Apple');

--insert producto
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);
INSERT INTO producto VALUES(12, 'Smartphone LG K92 5G', 155, 10);
INSERT INTO producto (nombre, precio, codigo_fabricante) VALUES('Iphone 7SE', 230, 11);

--insert fabricante-producto
INSERT INTO fabricante_productos VALUES
('Seagate', 'Disco duro SATA3 1TB', 86.99),
('Crucial', 'Memoria RAM DDR4 8GB', 120),
('Samsung', 'Disco SSD 1 TB', 150.99),
('Gigabyte', 'GeForce GTX 1050Ti', 185),
('Crucial', 'GeForce GTX 1080 Xtreme', 755),
('Asus', 'Monitor 24 LED Full HD', 202),
('Asus', 'Monitor 27 LED Full HD', 245.99),
('Lenovo', 'Portátil Yoga 520', 559),
('Lenovo', 'Portátil Ideapd 320', 444),
('Hewlett-Packard', 'Impresora HP Deskjet 3720', 59.99),
('Hewlett-Packard', 'Impresora HP Laserjet Pro M26nw', 180),
('LG', 'Smartphone LG K92 5G', 155),
('Apple','Smartphone LG Wing', 230);

--vista
CREATE VIEW vista_fabricante_productos 
AS SELECT nombre_fabricante, nombre_producto, precio
FROM tienda.fabricante_productos;

--DELETE FROM fabricante WHERE codigo = 1;

--DELETE FROM fabricante WHERE codigo = 9;

--pruebas
UPDATE fabricante 
SET codigo = 20
WHERE codigo = 2;

--pruebas
UPDATE fabricante 
SET codigo = 30
WHERE codigo = 8;

--pruebas
UPDATE producto 
SET precio = precio + 5;

--pruebas
DELETE FROM producto WHERE precio < 200 AND codigo_fabricante = 3;


