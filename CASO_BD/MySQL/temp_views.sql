CREATE VIEW IF NOT EXISTS vista_gestion_post AS
SELECT
p.numero_postulacion,
empresa.nombre,
s.descripcion AS Sede,
re.descripcion AS region_ejecucion,
ri.descripcion AS region_impacto,
ti.descripcion AS tipo_iniciativa,
empresa.convenio_USM AS convenio,
p.presupuesto AS presupuesto,
p.fecha_postulacion AS fecha_postulacion
FROM (((((postulacion p JOIN empresa ON (empresa.rut_empresa = p.rut_empresa))
JOIN regiones re ON ( re.id_regiones = p.id_reg_ejec))
JOIN regiones ri ON (ri.id_regiones = p.id_reg_impc))
JOIN sede s ON (s.id_sede = p.id_sede))
JOIN tipo_iniciativa ti ON (ti.id_tipo_in = p.id_tipo_iniciativa))
ORDER BY p.numero_postulacion;

-- Select de chequeo --
SELECT * FROM vista_gestion_post
WHERE (
	nombre IS NULL OR
    Sede IS NULL OR
    region_ejecucion IS NULL OR
    region_impacto IS NULL OR
    tipo_iniciativa IS NULL OR
    convenio IS NULL OR
    presupuesto IS NULL OR
    fecha_postulacion IS NULL)
;

CREATE VIEW IF NOT EXISTS vista_gestion_teamplay AS
SELECT
p.numero_postulacion,
integrantes.nombre AS integrante,
tipo_integrante.descripcion AS tipo_integrante,
sede.descripcion AS Sede,
equipo_trabajo.rol AS ROL
FROM ((((postulacion p JOIN equipo_trabajo ON(equipo_trabajo.codigo_interno = p.codigo_interno))
JOIN integrantes ON (integrantes.rut = equipo_trabajo.rut))
JOIN tipo_integrante ON (tipo_integrante.id_tipo = integrantes.id_tipo))
JOIN sede ON (sede.id_sede = integrantes.id_sede))
ORDER BY p.numero_postulacion;
