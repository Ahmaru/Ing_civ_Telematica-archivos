--ola aqui para crear la view.

CREATE OR REPLACE VIEW postulaciones_vista_academic AS 
SELECT 
    p.numero_postulacion AS 'N° Postulacion', 
    empresa.nombre AS 'Nombre empresa', 
    a.descripcion AS 'Region ejecucion', 
    b.descripcion AS 'Region impacto', 
    sede.descripcion AS Sede,
    ti.descripcion AS Iniciativa,
    p.presupuesto AS Presupuesto,
    es.descripcion AS Estado,
    et.rol AS 'Mi rol',
    et.rut AS 'Responsable'
FROM (((((((postulacion AS p
    INNER JOIN empresa ON empresa.rut_empresa = p.rut_empresa)
    INNER JOIN regiones AS a ON a.id_regiones = p.id_reg_ejec)
    INNER JOIN regiones AS b ON b.id_regiones = p.id_reg_impc)
    INNER JOIN sede ON sede.id_sede = p.id_sede)
    INNER JOIN tipo_iniciativa ti ON ti.id_tipo_in = p.id_tipo_iniciativa)
    INNER JOIN estado_postulacion es ON es.id_estado = p.id_estado_postulacion)
    INNER JOIN equipo_trabajo et ON (et.codigo_interno = p.codigo_interno AND et.es_responsable = 1))
;


--Segunda view pa lo que no es academic UwU
