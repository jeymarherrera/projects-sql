--BASE DE DATOS CAMPEONATO MUNDIAL
create database Campeonato_Mundial;

use Campeonato_Mundial;
-- drop database Campeonato_Mundial;

-- creacion de las tablas
--EQUIPO
create table equipo(
id_equipo int not null primary key auto_increment,
nombre_equipo varchar(50) not null
);

--PUESTO
create table puesto(
id_puesto int not null primary key auto_increment,
puesto_jugador varchar(50) not null
);

--JUGADOR
create table jugador(
	id_jugador INT not null primary key auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    id_equipo int not null
);

--ESTADIO
create table estadio(
id_estadio int not null primary key auto_increment,
nombre_estadio varchar(50) not null
);

--PARTIDO
create table partido(
id_partido int not null primary key auto_increment,
fecha_partido date not null,
id_estadio int not null
);

--COLEGIADO
create table colegiado(
id_colegiado int not null primary key auto_increment,
nombre_colegiado varchar(50) not null,
apellido_colegiado varchar(50) not null
);

--RELACION CONSULTA-COLEGIADO
create table consulta_colegiado(
id_consulta int not null primary key auto_increment,
id_funcion_consulta int not null,
id_partido_consulta int not null,
id_colegiado int not null
);

--FUNCION
create table funcion(
id_funcion int not null primary key auto_increment,
funcion varchar(60) not null
);

--RELACION JUGADOR PARTIDO
create table consulta_JP(
id_consulta int not null primary key auto_increment,
id_jugador_consulta_JP int not null,
id_puesto_consulta_JP int not null,
id_partido_consulta_JP int not null,
goles int not null,
faltas int not null
);

--RELACION PARTIDO-JUGADOR
create table consulta_EP(
id_consulta_EP int not null primary key auto_increment,
id_partido_consulta_EP int not null,
id_equipo_consulta_EP int not null,
ganado int not null check (ganado in (0,1)),
perdidos int not null check (perdidos in (0,1)),
empatados int not null check (empatados in (0,1))
);

-- indices para las tablas 
-- indice para la tabla jugador
alter table jugador 
add key fk_id_equipo(id_equipo);

alter table partido
add key fk_id_estadio(id_estadio);

alter table consulta_colegiado
	add key fk_id_funcion_consulta(id_funcion_consulta),
    add key fk_id_partido_consulta(id_partido_consulta),
    add key fk_id_colegiado(id_colegiado);

alter table consulta_JP
add key fk_id_jugador_consulta_JP(id_jugador_consulta_JP),
add key fk_id_partido_consulta_JP(id_partido_consulta_JP),
add key fk_id_puesto_consulta_JP(id_puesto_consulta_JP);

alter table consulta_EP
add key fk_id_equipo_consulta_EP(id_equipo_consulta_EP),
add key fk_id_partido_consulta_EP(id_partido_consulta_EP);

-- filtros para las tablas
alter table jugador 
 add constraint fk_id_equipo foreign key (id_equipo) references equipo (id_equipo);

 alter table partido 
 add constraint fk_id_estadio foreign key (id_estadio) references estadio (id_estadio);

 alter table consulta_colegiado
 add constraint fk_id_funcion_consulta foreign key(id_funcion_consulta) references funcion (id_funcion),
 add constraint fk_id_partido_consulta foreign key(id_partido_consulta) references partido(id_partido),
 add constraint fk_id_colegiado foreign key(id_colegiado) references colegiado(id_colegiado);

 alter table consulta_JP
 add constraint fk_id_jugador_consulta_JP foreign key (id_jugador_consulta_JP) references jugador (id_jugador),
 add constraint fk_id_partido_consulta_JP foreign key (id_partido_consulta_JP) references partido (id_partido),
 add constraint fk_id_puesto_consulta_JP foreign key (id_puesto_consulta_JP) references puesto (id_puesto);

 alter table consulta_EP
 add constraint fk_id_equipo_consulta_EP foreign key (id_equipo_consulta_EP) references equipo (id_equipo),
 add constraint fk_id_partido_consulta_EP foreign key (id_partido_consulta_EP) references partido (id_partido);

 -- INSERT LLENADO DE LA BASE DE DATOS

use campeonato_mundial;

-- TABLA EQUIPOS

INSERT INTO equipo (nombre_equipo)
VALUES 
	('Francia'),
	('Croacia'),
    ('Bélgica'),
    ('Inglaterra'),
    ('Uruguay'),
    ('Brasil');
    
-- TABLA PUESTO

INSERT INTO puesto (puesto_jugador)
VALUES 
	('Portero'),
	('Defensa'),
    ('Mediocampista'),
    ('Delantero');
    
-- TABLA FUNCION

INSERT INTO funcion (funcion)
VALUES 
	('Árbitro Principal'),
	('Juez de Línea'),
    ('Cuarto Árbitro'),
    ('Juez de Área');
    
-- TABLA ESTADIO

INSERT INTO estadio (nombre_estadio)
VALUES 
	('Estadio Luzhniki'),
	('Otkrytie Arena'),
    ('Estadio de San Petersburgo'),
    ('Estadio de Kaliningrado'),
	('Kazán Arena'),
    ('Estadio de Nizhni Nóvgorod'),
    ('Samara Arena'),
    ('Estadio Fisht'),
    ('Rostov Arena'),
    ('Mordovia Arena');
    
-- TABLA PARTIDO

INSERT INTO partido (fecha_partido, id_estadio)
VALUES 
	('2018-06-14', '9'),
    ('2018-06-14', '1'),
    ('2018-06-14', '8'),
    ('2018-06-14', '2'),
    ('2018-06-15', '7'),
    ('2018-06-15', '3'),
    ('2018-06-15', '6'),
    ('2018-06-15', '4'),
    ('2018-06-19', '5'),
    ('2018-06-19', '10');
    
    
    
-- TABLA COLEGIADO

INSERT INTO colegiado (nombre_colegiado, apellido_colegiado)
VALUES 
	('Joel', 'Aguilar'),
    ('Mark', 'Geiger'),
    ('Jair', 'Marrufo'),
    ('Ricardo', 'Montero'),
    ('John', 'Pittí'),
    ('César', 'Ramos'),
    ('Julio', 'Bascuñán'),
    ('Enrique', 'Cáceres'),
    ('Andrés', 'Cunha'),
    ('Néstor', 'Pitana'),
    ('Sandro', 'Ricci'),
    ('Wilmar', 'Roldán'),
    ('Matt', 'Conger'),
    ('Norbert', 'Hauata'),
    ('Felix', 'Brych'),
    ('Alireza', 'Faghani'),
    ('Ghead', 'Grisha');
    
-- TABLA JUGADOR

INSERT INTO jugador (nombre, apellido, id_equipo)
VALUES 
	('Hugo', 'Lloris', '1'),
    ('Benjamin', 'Pavard', '1'),
    ('Presnel', 'Kimpembe', '1'),
    ('Raphael', 'Varane', '1'),
    ('Clement', 'Lenglet', '1'),
    ('Paul', 'Pogba', '1'),
    ('Thomas', 'Lemar', '1'),
    ('Corentin', 'Tolisso', '1'),
    ('Antoine', 'Griezmann', '1'),
    ('Olivier', 'Giroud', '1'),
    ('Kylian', 'Mbappé', '1'),
    ('Dominik', 'Livakovic', '2'),
    ('Šime', 'Vrsaljko', '2'),
    ('Borna', 'Barišić', '2'),
    ('Duje', 'Ćaleta-Car', '2'),
    ('Mateo', 'Kovačić', '2'),
    ('Luka', 'Modrić', '2'),
    ('Nikola', 'Vlašić', '2'),
    ('Ivan', 'Perišić', '2'),
    ('Josip', 'Brekalo', '2'),
    ('Ante', 'Budimir', '2'),
    ('Mislav', 'Oršić', '2'),
    ('Thibaut', 'Courtois', '3'),
    ('Toby', 'Alderweireld', '3'),
    ('Thomas', 'Vermaelen', '3'),
    ('Dedryck', 'Boyata', '3'),
    ('Jan', 'Vertonghen', '3'),
    ('Axel', 'Witsel', '3'),
    ('Kevin', 'De Bruyne', '3'),
    ('Youri', 'Tielemans', '3'),
    ('Romelu', 'Lukaku', '3'),
    ('Eden', 'Hazard', '3'),
    ('Dries', 'Mertens', '3'),
    ('Jordan', 'Pickford', '4'),
    ('Kyle', 'Walker', '4'),
    ('Luke', 'Shaw', '4'),
    ('John', 'Stones', '4'),
    ('Harry', 'Maguire', '4'),
    ('Declan', 'Rice', '4'),
    ('Jordan', 'Henderson', '4'),
    ('Kalvin', 'Phillips', '4'),
    ('Mason', 'Mount', '4'),
    ('Jack', 'Grealish', '4'),
    ('Harry', 'Kane', '4'),
    ('Fernando', 'Muslera', '5'),
    ('José María', 'Giménez', '5'),
    ('Diego', 'Godín', '5'),
    ('Ronald', 'Araújo', '5'),
    ('Camilo', 'Cándido', '5'),
    ('Giovanni', 'González', '5'),
    ('Matías', 'Viña', '5'),
    ('Rodrigo', 'Bentancur', '5'),
    ('Nahitan', 'Nández', '5'),
    ('Luis', 'Suárez', '5'),
    ('Maximiliano', 'Gómez', '5'),
    ('Alisson', 'Becker', '6'),
    ('Thiago', 'Silva', '6'),
    ('Danilo Luiz', 'da Silva', '6'),
    ('Alex', 'Sandro', '6'),
    ('Felipe', 'Augusto', '6'),
    ('Éverton', 'Ribeiro', '6'),
    ('Lucas', 'Paquetá', '6'),
    ('Gabriel', 'Jesus', '6'),
    ('Neymar', 'Santos Júnior', '6'),
    ('Vinícius', 'Júnior', '6'),
    ('Roberto', 'Firmino', '6');
    
-- TABLA CONSULTA_COLEGIADO
-- Esta tabla fue creada para evitar redundancia en la tabla colegiados pues se repetian los arbitros dependiendo de sus puestos y partidos

INSERT INTO consulta_colegiado (id_colegiado, id_funcion_consulta, id_partido_consulta)
VALUES 
	('1', '1', '1'),
    ('5', '1', '2'),
    ('9', '1', '3'),
    ('13', '1', '4'),
    ('17', '1', '5'),
    ('4', '1', '6'),
    ('8', '1', '7'),
    ('12', '1', '8'),
    ('16', '1', '9'),
    ('3', '1', '10'),
    ('2', '2', '1'),
    ('6', '2', '2'),
    ('10', '2', '3'),
    ('14', '2', '4'),
    ('1', '2', '5'),
    ('5', '2', '6'),
    ('9', '2', '7'),
    ('13', '2', '8'),
    ('17', '2', '9'),
    ('4', '2', '10'),
    ('3', '3', '1'),
    ('7', '3', '2'),
    ('11', '3', '3'),
    ('15', '3', '4'),
    ('2', '3', '5'),
    ('6', '3', '6'),
    ('10', '3', '7'),
    ('14', '3', '8'),
    ('1', '3', '9'),
    ('5', '3', '10'),
    ('4', '4', '1'),
    ('8', '4', '2'),
    ('12', '4', '3'),
    ('16', '4', '4'),
    ('3', '4', '5'),
    ('7', '4', '6'),
    ('11', '4', '7'),
    ('15', '4', '8'),
    ('2', '4', '9'),
    ('6', '4', '10');
    
-- TABLA CONSULTA_EP
-- ganado, perdido, empatados aceptan 1 o 0 y al realizar la consulta se cuentan los que sean 1, asi calcular los ganados perdidos o empatados

INSERT INTO consulta_ep (id_equipo_consulta_EP, id_partido_consulta_EP, ganado, perdidos, empatados)
VALUES 
	('1', '2', '1', '0', '0'),
    ('1', '6', '1', '0', '0'),
    ('2', '1', '0', '0', '1'),
    ('2', '2', '0', '1', '0'),
    ('3', '6', '0', '1', '0'),
    ('3', '1', '0', '0', '1'),
    ('4', '10', '1', '0', '0'),
    ('4', '3', '0', '1', '0'),
    ('5', '10', '0', '1', '0'),
    ('6', '3', '1', '0', '0');
    
-- TABLA CONSULTA_JP
-- se añadio el id puesto y se elimino respectivamente de la tabla jugador para evitar la misma redundacia generada en colegiados

INSERT INTO consulta_jp (id_jugador_consulta_JP, id_puesto_consulta_JP, id_partido_consulta_JP, goles, faltas)
VALUES 
	('1', '1', '2', '0', '0'),
    ('2', '2', '2', '0', '0'),
    ('3', '2', '2', '0', '1'),
    ('4', '2', '2', '0', '0'),
    ('5', '2', '2', '0', '0'),
    ('6', '3', '2', '0', '1'),
    ('7', '3', '2', '0', '0'),
    ('8', '4', '2', '1', '0'),
    ('9', '4', '2', '2', '0'),
    ('10', '4', '2', '0', '0'),
    ('11', '3', '2', '0', '0'),
    ('1', '1', '6', '0', '0'),
    ('2', '2', '6', '0', '2'),
    ('3', '2', '6', '0', '0'),
    ('4', '2', '6', '0', '0'),
    ('5', '2', '6', '0', '1'),
    ('6', '2', '6', '0', '0'),
    ('7', '3', '6', '0', '1'),
    ('8', '3', '6', '2', '2'),
    ('9', '3', '6', '0', '0'),
    ('10', '4', '6', '3', '0'),
    ('11', '4', '6', '0', '0'),
    ('12', '1', '1', '0', '1'),
    ('13', '2', '1', '0', '0'),
    ('14', '2', '1', '0', '0'),
    ('15', '3', '1', '0', '1'),
    ('16', '3', '1', '0', '1'),
    ('17', '3', '1', '0', '0'),
    ('18', '3', '1', '1', '0'),
    ('19', '3', '1', '0', '2'),
    ('20', '4', '1', '0', '0'),
    ('21', '4', '1', '0', '0'),
    ('22', '4', '1', '0', '1'),
    ('12', '1', '2', '0', '1'),
    ('13', '2', '2', '1', '0'),
    ('14', '2', '2', '0', '0'),
    ('15', '2', '2', '0', '3'),
    ('16', '2', '2', '0', '0'),
    ('17', '2', '2', '0', '0'),
    ('18', '4', '2', '0', '0'),
    ('19', '4', '2', '0', '0'),
    ('20', '3', '2', '0', '0'),
    ('21', '3', '2', '0', '0'),
    ('22', '3', '2', '0', '2'),
    ('23', '1', '6', '0', '1'),
    ('24', '2', '6', '0', '0'),
    ('25', '2', '6', '0', '0'),
    ('26', '2', '6', '0', '1'),
    ('27', '2', '6', '0', '0'),
    ('28', '2', '6', '0', '3'),
    ('29', '3', '6', '0', '0'),
    ('30', '3', '6', '1', '0'),
    ('31', '4', '6', '0', '0'),
    ('32', '4', '6', '0', '1'),
    ('33', '4', '6', '0', '1'),
    ('23', '1', '1', '0', '1'),
    ('24', '2', '1', '1', '0'),
    ('25', '2', '1', '0', '2'),
    ('26', '2', '1', '0', '1'),
    ('27', '2', '1', '0', '0'),
    ('28', '2', '1', '0', '0'),
    ('29', '3', '1', '0', '3'),
    ('30', '3', '1', '0', '0'),
    ('31', '3', '1', '0', '0'),
    ('32', '3', '1', '0', '0'),
    ('33', '4', '1', '0', '1'),
    ('34', '1', '10', '0', '1'),
    ('35', '2', '10', '0', '0'),
    ('36', '2', '10', '0', '3'),
    ('37', '3', '10', '0', '1'),
    ('38', '3', '10', '0', '0'),
    ('39', '3', '10', '0', '0'),
    ('40', '4', '10', '2', '0'),
    ('41', '4', '10', '2', '0'),
    ('42', '4', '10', '0', '0'),
    ('43', '4', '10', '0', '1'),
    ('44', '4', '10', '0', '1'),
    ('34', '1', '3', '0', '1'),
    ('35', '2', '3', '0', '0'),
    ('36', '2', '3', '0', '0'),
    ('37', '2', '3', '0', '1'),
    ('38', '2', '3', '0', '0'),
    ('39', '2', '3', '0', '0'),
    ('40', '2', '3', '0', '0'),
    ('41', '2', '3', '0', '0'),
    ('42', '4', '3', '0', '0'),
    ('43', '4', '3', '1', '0'),
    ('44', '3', '3', '0', '1'),
    ('45', '1', '10', '0', '1'),
    ('46', '2', '10', '0', '0'),
    ('47', '2', '10', '0', '0'),
    ('48', '2', '10', '0', '1'),
    ('49', '2', '10', '0', '0'),
    ('50', '3', '10', '0', '0'),
    ('51', '3', '10', '0', '3'),
    ('52', '3', '10', '0', '0'),
    ('53', '4', '10', '1', '0'),
    ('54', '4', '10', '0', '0'),
    ('55', '4', '10', '0', '1'),
    ('56', '1', '3', '0', '1'),
    ('57', '2', '3', '0', '0'),
    ('58', '2', '3', '0', '0'),
    ('59', '2', '3', '0', '1'),
    ('60', '2', '3', '0', '0'),
    ('61', '2', '3', '0', '0'),
    ('62', '3', '3', '2', '0'),
    ('63', '3', '3', '0', '0'),
    ('64', '4', '3', '0', '0'),
    ('65', '4', '3', '3', '0'),
    ('66', '4', '3', '0', '1');

-- CONSULTAS MINIMAS
-- Consultar todos los partidos jugados con el resultado de cada partido.

use campeonato_mundial;

select
	a.id_partido, a.fecha_partido, d.nombre_estadio, b.nombre_equipo as Ganador_Empate
from 
	partido a,
	equipo b,
	consulta_ep c,
    estadio d
where
	a.id_partido=c.id_partido_consulta_EP
	and c.id_equipo_consulta_EP = b.id_equipo
    and a.id_estadio = d.id_estadio
	and (c.ganado=1 or c.empatados=1);
    
-- Los jugadores que participaron en un partido determinado.

select
	distinct d.nombre, d.apellido, a.fecha_partido
from 
	partido a,
	equipo b,
	consulta_jp c,
    jugador d
where
	a.id_partido=c.id_partido_consulta_JP
	and c.id_jugador_consulta_JP = d.id_jugador
	and a.id_partido = 1;

-- Las estadísticas de cada jugador en cada partido.

select
	a.id_partido, a.fecha_partido, d.nombre, d.apellido, c.goles, c.faltas
from 
	partido a,
	consulta_jp c,
    jugador d
where
	a.id_partido=c.id_partido_consulta_JP
    and c.id_jugador_consulta_JP = d.id_jugador
    
order by id_partido asc;
    
-- El número de partidos jugados por un determinado jugador.

select 
	count(a.id_jugador_consulta_JP) as PARTIDOS_JUGADOS
from
	consulta_jp a,
    jugador b
where
	a.id_jugador_consulta_JP = b.id_jugador
    and (b.nombre = 'Benjamin' and b.apellido = 'Pavard');
    
-- El número de partidos ganados, perdidos o empatados.

select
	count(ganado) as PARTIDOS_GANADOS_TOTAL
    -- count(perdidos) as PARTIDOS_PERDIDOS_TOTAL
    -- count(empatados)/2 as PARTIDOS_EMPATADOS_TOTAL
from 
	consulta_ep a
where
	a.ganado = 1;
    -- a.perdidos = 1;
    -- a.empatados = 1;
    
-- Consultar los nombres de los equipos contrarios con los cuales jugo nuestro equipo, con la información de la fecha, lugar del encuentro y el resultado del partido.

select 
	b.nombre_equipo, c.fecha_partido, d.nombre_estadio, a.ganado as GANO, a.perdidos as PERDIO, a.empatados  as EMPATÓ
from
	consulta_ep a,
    equipo b, 
    partido c,
    estadio d
where
	a.id_equipo_consulta_EP = b.id_equipo
	and b.nombre_equipo <> 'Francia' -- NUESTRO EQUIPO
    and a.id_partido_consulta_EP = '2' -- El PARTIDO ESPECIFICO
    and a.id_partido_consulta_EP = c.id_partido
    and c.id_estadio = d.id_estadio;