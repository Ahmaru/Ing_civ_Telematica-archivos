--solicitud N°1--
SELECT nombre FROM ingenieros WHERE numero_solicitudes_activas>5;

--solicitud N°2--
SELECT e.titulo,e.fecha_publicacion,u.nombre
FROM solicitudes_errores e
JOIN usuarios u
ON e.autor=u.rut
WHERE e.fecha_publicacion<CURRENT_DATE
ORDER BY e.fecha_publicacion ASC
LIMIT 10;

--solicitud N°3--
SELECT f.titulo,t.nombre,u.nombre
FROM solicitudes_funcionalidad f
JOIN topicos t ON f.topico_id=t.id
JOIN usuarios u ON f.solicitante=u.rut
WHERE f.ambiente_desarrollo = 'Movil';

--solicitud N°4--
SELECT t.nombre,COUNT(e.topico_id) AS cantida FROM topicos t
JOIN solicitudes_errores e ON e.topico_id=t.id
GROUP BY t.nombre
HAVING COUNT(e.topico_id)>=10;

--solicitud N°5--
SELECT f.titulo,u.nombre,e.titulo FROM solicitudes_funcionalidad f
JOIN solicitudes_errores e ON f.solicitante=e.autor
JOIN usuarios u ON f.solicitante=u.rut
WHERE f.topico_id=e.topico_id AND f.fecha_solicitud>e.fecha_publicacion;

--solicitud N°6--
UPDATE public.solicitudes_errores
SET estado = 'Archivado'
WHERE fecha_publicacion < '2022-01-01';

--solicitud N°7--
SELECT i.nombre,t.nombre FROM ingenieros i
JOIN topicos t ON (i.especialidad_1=t.id OR i.especialidad_2=t.id)
WHERE t.nombre='Backend';

--solicitud N°8--
SELECT COUNT(f.id_caso) AS funcionalidad ,COUNT(e.id_caso) AS errores ,u.nombre 
FROM usuarios u
JOIN solicitudes_funcionalidad f ON f.solicitante=u.rut
JOIN solicitudes_errores e ON e.autor=u.rut
GROUP BY u.nombre;

--solicitud N°9--

WITH conteos AS (
SELECT t.nombre AS especialidad, COUNT(*) AS total, t.id
FROM (
SELECT especialidad_1 AS espec FROM ingenieros
UNION ALL
SELECT especialidad_2 FROM ingenieros
) sub
JOIN (
VALUES (1,'Backend'),(2,'Seguridad'),(3,'UX/UI')) AS t(id,nombre)
ON sub.espec=t.id
GROUP BY t.id, t.nombre)
SELECT string_agg(especialidad || ': ' || total, ', ' ORDER BY id)
AS resumen FROM conteos;

--solicitud N°10--
DELETE FROM public.solicitudes_errores
WHERE fecha_publicacion < '2021-01-01';


