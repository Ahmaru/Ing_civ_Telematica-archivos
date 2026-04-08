--Peticiones para la base de datos.

-- Check para parte de llenado de datos

SELECT COUNT(*) AS cantidad_empresas FROM empresa;
SELECT COUNT(*) AS cantidad_postulaciones FROM postulacion;
SELECT COUNT(*) AS cantidad_posibles_integrantes FROM integrantes;
SELECT COUNT(*) AS cantidad_etapas FROM etapa;
SELECT COUNT(DISTINCT codigo_interno) AS cantidad_equipos FROM equipo_trabajo;

--parte 1
SELECT 
    postulacion.numero_postulacion, 
    empresa.nombre AS nombre_empresa, 
    a.descripcion AS region_ejecucion, 
    b.descripcion AS region_impacto, 
    sede.descripcion AS sede
FROM ((((postulacion 
    INNER JOIN empresa ON empresa.rut_empresa = postulacion.rut_empresa)
    INNER JOIN regiones AS a ON a.id_regiones = postulacion.id_reg_ejec)
    INNER JOIN regiones AS b ON b.id_regiones = postulacion.id_reg_impc)
    INNER JOIN sede ON sede.id_sede = postulacion.id_sede)
;


-- Peticiones de la parte 5

-- 1. Listado general de postulaciones.
-- Muestra la información básica de cada postulación incluyendo datos de tablas relacionadas.
SELECT 
    p.numero_postulacion AS 'Postulación N°', 
    p.fecha_postulacion AS 'Fecha', 
    ti.descripcion AS 'Tipo de Iniciativa', 
    s.descripcion AS 'Sede', 
    reg_e.descripcion AS 'Región Ejecución', 
    reg_i.descripcion AS 'Región Impacto', 
    emp.nombre AS 'Empresa', 
    p.presupuesto AS 'Presupuesto Total'
FROM postulacion p
JOIN tipo_iniciativa ti ON p.id_tipo_inciativa = ti.id_tipo_in
JOIN sede s ON p.id_sede = s.id_sede
JOIN regiones reg_e ON p.id_reg_ejec = reg_e.id_regiones
JOIN regiones reg_i ON p.id_reg_impc = reg_i.id_regiones
JOIN empresa emp ON p.rut_empresa = emp.rut_empresa;


-- 2. Postulaciones por región.
-- Lista las postulaciones que se ejecutan específicamente en la Región de Valparaíso (ID 5).
SELECT 
    emp.nombre AS 'Empresa', 
    s.descripcion AS 'Sede', 
    p.presupuesto AS 'Presupuesto'
FROM postulacion p
JOIN empresa emp ON p.rut_empresa = emp.rut_empresa
JOIN sede s ON p.id_sede = s.id_sede
JOIN regiones r ON p.id_reg_ejec = r.id_regiones
WHERE r.descripcion = 'Región de Valparaiso';


-- 3. Conteo por tipo de iniciativa.
-- Cuenta cuántas iniciativas existen por cada categoría (Nueva / Existente).
SELECT 
    ti.descripcion AS 'Tipo de Iniciativa', 
    COUNT(p.codigo_interno) AS 'Cantidad'
FROM tipo_iniciativa ti
LEFT JOIN postulacion p ON ti.id_tipo_in = p.id_tipo_inciativa
GROUP BY ti.descripcion;


-- 4. Equipo de trabajo de una postulación.
-- Dado un código interno (ej: 1), muestra a todos los integrantes y sus roles.
SELECT 
    i.rut AS 'RUT', 
    i.nombre AS 'Nombre', 
    tin.descripcion AS 'Tipo', 
    s.descripcion AS 'Sede', 
    i.mail AS 'Email', 
    et.rol AS 'Rol'
FROM equipo_trabajo et
JOIN integrantes i ON et.rut = i.rut
JOIN tipo_integrante tin ON i.id_tipo = tin.id_tipo
JOIN sede s ON i.id_sede = s.id_sede
WHERE et.codigo_interno = 4; -- Puedes cambiar el 1 por cualquier ID


-- 5. Empresas con postulaciones y convenio.
-- Muestra el resumen de postulaciones por empresa y si tienen convenio, ordenado por cantidad.
SELECT 
    emp.nombre AS 'Empresa', 
    te.descripcion AS 'Tamaño', 
    IF(emp.convenio_USM = 1, 'Sí', 'No') AS 'Convenio', 
    COUNT(p.codigo_interno) AS 'Cantidad Postulaciones'
FROM empresa emp
JOIN tamaño_empresa te ON emp.id_tamaño_empresa = te.id_tamaño
LEFT JOIN postulacion p ON emp.rut_empresa = p.rut_empresa
GROUP BY emp.rut_empresa
ORDER BY COUNT(p.codigo_interno) DESC;


-- 6. Postulaciones con presupuesto sobre el promedio.
-- Lista las postulaciones que piden más dinero que el promedio de todas las solicitudes.
SELECT 
    p.numero_postulacion AS 'Postulación N°', 
    emp.nombre AS 'Empresa', 
    p.presupuesto AS 'Presupuesto Total'
FROM postulacion p
JOIN empresa emp ON p.rut_empresa = emp.rut_empresa
WHERE p.presupuesto > (SELECT AVG(presupuesto) FROM postulacion)
ORDER BY p.presupuesto DESC;


-- 7. Cantidad de integrantes por postulación y tipo.
-- Desglosa la cantidad de profesores y alumnos por cada proyecto.
SELECT 
    p.numero_postulacion AS 'Postulación N°', 
    ti.descripcion AS 'Tipo Integrante', 
    COUNT(et.rut) AS 'Cantidad'
FROM equipo_trabajo et
JOIN postulacion p ON et.codigo_interno = p.codigo_interno
JOIN integrantes i ON et.rut = i.rut
JOIN tipo_integrante ti ON i.id_tipo = ti.id_tipo
GROUP BY p.numero_postulacion, ti.descripcion;


-- 8. Postulaciones que no cumplen el mínimo de equipo.
-- Identifica proyectos con menos de 3 profesores o menos de 5 estudiantes.
-- (Nota: Con tus datos actuales, todos cumplen, para probarla deberías borrar a alguien de una postulación).
SELECT 
    p.numero_postulacion AS 'Postulación N°',
    SUM(CASE WHEN i.id_tipo = 1 THEN 1 ELSE 0 END) AS 'Cant_Profesores',
    SUM(CASE WHEN i.id_tipo = 2 THEN 1 ELSE 0 END) AS 'Cant_Estudiantes'
FROM equipo_trabajo et
JOIN postulacion p ON et.codigo_interno = p.codigo_interno
JOIN integrantes i ON et.rut = i.rut
GROUP BY p.numero_postulacion
HAVING Cant_Profesores < 3 OR Cant_Estudiantes < 5;


-- 9. Empresas sin postulaciones registradas.
-- Encuentra empresas que están en el sistema pero no han mandado ningún proyecto.
SELECT 
    emp.nombre AS 'Empresa', 
    emp.rut_empresa AS 'RUT', 
    te.descripcion AS 'Tamaño'
FROM empresa emp
JOIN tamaño_empresa te ON emp.id_tamaño_empresa = te.id_tamaño
LEFT JOIN postulacion p ON emp.rut_empresa = p.rut_empresa
WHERE p.codigo_interno IS NULL;


-- 10. Postulaciones que exceden el plazo máximo.
-- Suma las semanas de las etapas y muestra las que duran más de 36 semanas.
SELECT 
    p.numero_postulacion AS 'Postulación N°', 
    p.codigo_interno AS 'Código Interno', 
    COUNT(etapa.id_etapa) AS 'Total Etapas', 
    SUM(etapa.semanas_plazo) AS 'Total Semanas'
FROM etapa
JOIN postulacion p ON etapa.codigo_interno_e = p.codigo_interno
GROUP BY p.codigo_interno
HAVING SUM(etapa.semanas_plazo) > 36
ORDER BY SUM(etapa.semanas_plazo) DESC;

