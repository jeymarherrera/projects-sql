CREATE DATABASE ControlStock;
USE ControlStock;

CREATE TABLE Producto(
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
descripcion VARCHAR(255),
cantidad INT NOT NULL DEFAULT 0,
PRIMARY KEY(id)
) ENGINE=InnoDB ;

INSERT INTO Producto (nombre, descripcion, cantidad)
VALUES ('Mesa', 'Mesa de 4 Lugares', 10);

INSERT INTO Producto (nombre, descripcion, cantidad)
VALUES ('Celular', 'Celular Samsung', 50);

SELECT * FROM Producto;