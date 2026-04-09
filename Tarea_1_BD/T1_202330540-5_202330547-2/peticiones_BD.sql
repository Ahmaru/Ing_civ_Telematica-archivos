--Peticiones para la base de datos.
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

/* Evidencia query 1.
+------------------+------------+--------------------+--------------------------------+-------------------------+-------------------------+-----------------+-------------------+
| Postulación N°   | Fecha      | Tipo de Iniciativa | Sede                           | Región Ejecución        | Región Impacto          | Empresa         | Presupuesto Total |
+------------------+------------+--------------------+--------------------------------+-------------------------+-------------------------+-----------------+-------------------+
| POST-001         | 2026-03-01 | Nueva              | Campus Casa central Valparaiso | Región de Valparaiso    | Región Metropolitana    | TechSol SpA     |       12000000.00 |
| POST-003         | 2026-03-05 | Nueva              | Campus Vitacura                | Región de Coquimbo      | Región de Valparaiso    | DataMinds SA    |        9800000.00 |
| POST-005         | 2026-03-10 | Nueva              | Sede Concepcion                | Región del Biobio       | Región de Coquimbo      | SoftAndina Ltda |       15500000.00 |
| POST-007         | 2026-03-14 | Nueva              | Campus San Joaquin             | Región de Coquimbo      | Región de la Araucania  | TechSol SpA     |       31000000.00 |
| POST-009         | 2026-03-20 | Nueva              | Sede Viña del Mar              | Región de Atacama       | Región del Biobio       | DataMinds SA    |       19400000.00 |
| POST-002         | 2026-03-03 | Existente          | Campus San Joaquin             | Región Metropolitana    | Región del Biobio       | Innovatech Ltda |       18500000.00 |
| POST-004         | 2026-03-07 | Existente          | Sede Viña del Mar              | Región de la Araucania  | Región Metropolitana    | GreenCode SpA   |       22000000.00 |
| POST-006         | 2026-03-12 | Existente          | Campus Casa central Valparaiso | Región Metropolitana    | Región de Valparaiso    | CiberChile SA   |        8200000.00 |
| POST-008         | 2026-03-17 | Existente          | Campus Vitacura                | Región de Valparaiso    | Región Metropolitana    | Innovatech Ltda |        7600000.00 |
| POST-010         | 2026-03-22 | Existente          | Sede Concepcion                | Región Metropolitana    | Región de Atacama       | GreenCode SpA   |       13700000.00 |
+------------------+------------+--------------------+--------------------------------+-------------------------+-------------------------+-----------------+-------------------+
*/

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

/*Evidencia para query 2 con Region de Valparaiso. 
+-----------------+--------------------------------+-------------+
| Empresa         | Sede                           | Presupuesto |
+-----------------+--------------------------------+-------------+
| TechSol SpA     | Campus Casa central Valparaiso | 12000000.00 |
| Innovatech Ltda | Campus Vitacura                |  7600000.00 |
+-----------------+--------------------------------+-------------+
*/

-- 3. Conteo por tipo de iniciativa.
-- Cuenta cuántas iniciativas existen por cada categoría (Nueva / Existente).
SELECT 
    ti.descripcion AS 'Tipo de Iniciativa', 
    COUNT(p.codigo_interno) AS 'Cantidad'
FROM tipo_iniciativa ti
LEFT JOIN postulacion p ON ti.id_tipo_in = p.id_tipo_inciativa
GROUP BY ti.descripcion;

/*Evidencia para query 3
+--------------------+----------+
| Tipo de Iniciativa | Cantidad |
+--------------------+----------+
| Existente          |        5 |
| Nueva              |        5 |
+--------------------+----------+
*/

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
WHERE et.codigo_interno = 3; -- Puedes cambiar el 1 por cualquier ID

/*Evidencia para query 4 con equipo 3.
+------------+--------------------+------------+--------------------+---------------------------+------------------------+
| RUT        | Nombre             | Tipo       | Sede               | Email                     | Rol                    |
+------------+--------------------+------------+--------------------+---------------------------+------------------------+
| 11111111-5 | Ricardo Núñez      | Profesor   | Campus Vitacura    | rnunez@usm.cl             | Jefe de Proyecto       |
| 11111111-6 | Patricia Lagos     | Profesor   | Campus Vitacura    | plagos@usm.cl             | Coordinador Técnico    |
| 11111111-7 | Sebastián Díaz     | Profesor   | Sede Viña del Mar  | sdiaz@usm.cl              | Asesor Metodológico    |
| 22222222-0 | Ignacio Moya       | Estudiante | Campus Vitacura    | imoya@alumnos.usm.cl      | Desarrollador Backend  |
| 22222222-9 | Paula Jiménez      | Estudiante | Campus Vitacura    | pjimenez@alumnos.usm.cl   | Desarrollador Frontend |
| 33333333-1 | Catalina Bravo     | Estudiante | Campus Vitacura    | cbravo@alumnos.usm.cl     | Analista de Datos      |
| 33333333-2 | Rodrigo Sepúlveda  | Estudiante | Campus Vitacura    | rsepulveda@alumnos.usm.cl | Tester QA              |
| 33333333-3 | Isidora Parra      | Estudiante | Sede Viña del Mar  | iparra@alumnos.usm.cl     | Diseñador UX           |
+------------+--------------------+------------+--------------------+---------------------------+------------------------+
*/

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

/*Evidencia para query 5.
+-----------------+---------------+----------+------------------------+
| Empresa         | Tamaño        | Convenio | Cantidad Postulaciones |
+-----------------+---------------+----------+------------------------+
| GreenCode SpA   | Micro-empresa | No       |                      2 |
| TechSol SpA     | Micro-empresa | Sí       |                      2 |
| DataMinds SA    | Grande        | Sí       |                      2 |
| Innovatech Ltda | Mediana       | No       |                      2 |
| CiberChile SA   | Grande        | No       |                      1 |
| SoftAndina Ltda | Mediana       | Sí       |                      1 |
+-----------------+---------------+----------+------------------------+
*/

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

/*Evidencia para query 6.
+------------------+-----------------+-------------------+
| Postulación N°   | Empresa         | Presupuesto Total |
+------------------+-----------------+-------------------+
| POST-007         | TechSol SpA     |       31000000.00 |
| POST-004         | GreenCode SpA   |       22000000.00 |
| POST-009         | DataMinds SA    |       19400000.00 |
| POST-002         | Innovatech Ltda |       18500000.00 |
+------------------+-----------------+-------------------+
*/

-- 7. Cantidad de integrantes por postulación y tipo.
-- Desglosa la cantidad de profesores y alumnos por cada proyecto.
SELECT 
    p.numero_postulacion,
    COUNT(CASE WHEN e.id_tipo = 2 THEN 1 END) AS estudiantes,
    COUNT(CASE WHEN e.id_tipo = 1 THEN 1 END) AS profes,
    COUNT(et.rut) AS total 
FROM equipo_trabajo et 
    JOIN postulacion p ON p.codigo_interno = et.codigo_interno 
    JOIN integrantes e ON e.rut = et.rut
GROUP BY p.numero_postulacion
;

/*Evidencia para query 7.
+--------------------+-------------+--------+-------+
| numero_postulacion | estudiantes | profes | total |
+--------------------+-------------+--------+-------+
| POST-001           |           5 |      3 |     8 |
| POST-002           |           5 |      3 |     8 |
| POST-003           |           5 |      3 |     8 |
| POST-004           |           5 |      3 |     8 |
| POST-005           |           5 |      3 |     8 |
| POST-006           |           5 |      3 |     8 |
| POST-007           |           5 |      3 |     8 |
| POST-008           |           5 |      3 |     8 |
| POST-009           |           5 |      3 |     8 |
| POST-010           |           5 |      3 |     8 |
+--------------------+-------------+--------+-------+
*/

-- 8. Postulaciones que no cumplen el mínimo de equipo.
-- Identifica proyectos con menos de 3 profesores o menos de 5 estudiantes.
SELECT 
    p.numero_postulacion AS 'Postulación N°',
    SUM(CASE WHEN i.id_tipo = 1 THEN 1 ELSE 0 END) AS 'Cant_Profesores',
    SUM(CASE WHEN i.id_tipo = 2 THEN 1 ELSE 0 END) AS 'Cant_Estudiantes'
FROM equipo_trabajo et
JOIN postulacion p ON et.codigo_interno = p.codigo_interno
JOIN integrantes i ON et.rut = i.rut
GROUP BY p.numero_postulacion
HAVING Cant_Profesores < 3 OR Cant_Estudiantes < 5;

/*Evidencia para query 8.
+------------------+-----------------+------------------+
| Postulación N°   | Cant_Profesores | Cant_Estudiantes |
+------------------+-----------------+------------------+
| POST-001         |               3 |                4 |
+------------------+-----------------+------------------+
*/

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

/*Evidencia para query 9
+-----------+------------+---------------+
| Empresa   | RUT        | Tamaño        |
+-----------+------------+---------------+
| Agua .com | 76543221-1 | Micro-empresa |
+-----------+------------+---------------+
*/

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

/*Evidencia query 10
+------------------+-----------------+--------------+---------------+
| Postulación N°   | Código Interno  | Total Etapas | Total Semanas |
+------------------+-----------------+--------------+---------------+
| POST-001         |               1 |            3 |            55 |
+------------------+-----------------+--------------+---------------+
*/

