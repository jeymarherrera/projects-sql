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