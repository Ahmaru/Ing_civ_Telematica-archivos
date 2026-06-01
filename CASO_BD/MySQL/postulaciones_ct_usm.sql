-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2026 a las 04:51:36
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `postulaciones_ct_usm`
--

--
-- Volcado de datos para la tabla `credenciales`
--

INSERT INTO `credenciales` (`id_usr`, `rut`, `password`, `id_tipo`) VALUES
(1, '11111111-1', '$2y$10$YLILR7bbRjTJUCCY8Y63e.roYwEuBg7nPmow5eC3N7M3PRZQognf2', 1),
(2, '11111111-2', '$2y$10$evaeJ3RVAARpQSJXQCvWouEfqtkh08YvMX.9mx8AlFuAg2l9cVRme', 2),
(3, '11111111-3', '$2y$10$9ctDubZ11wrUDmNna2aVmeCXaSfostsaYLfcQduy2ezth6.BedWZy', 2),
(4, '11111111-4', '$2y$10$LdBCzs8J1Dx0ZLAeh8TQSet9HvxnziJk1edGd2pyEH2jMa72206vy', 2),
(5, '11111111-5', '$2y$10$AxyWxakEnqfRMFDN6e93x.KK7Np2Q7bgVsoa.lekwRMUk39wUQTlm', 2),
(6, '11111111-6', '$2y$10$0qV9bcSjUfB02cGUl8SI4uSKzW6P2unYjFxhOeAqdy5yO.vksojn.', 2),
(7, '11111111-7', '$2y$10$cgS4Vl54PmZ/n4KZQd/m8e/e9ToDRk0fAb./qKy8M2ZavCC1gLQ1W', 2),
(8, '11111111-8', '$2y$10$6eqcW56OnYwnvSym9FSez.T4FGbzdLWLBgP9rEWhSq2Xm93J263/y', 2),
(9, '11111111-9', '$2y$10$A5RXtixxyl7iVNmEnA6CpOpxVrJBpzmCS9k9FaFKkkXwRHNcwVfDC', 2),
(10, '11111111-0', '$2y$10$9tTPS74Q8lvU8.hvQT0oQuut8fS4jfTY7sSTkXH.gEZMM9ySWdIR2', 2),
(11, '22222222-1', '$2y$10$Id1kjrBg8TFMCcwbcCpjPuHP1uJl5Ln8jId.LVXAusp8.cv3XN28y', 3),
(12, '22222222-2', '$2y$10$uSGZGzxcOSablR8vzmRXP.iii0TrGQIOYS82GdXp3Tw6GrIWaeFEG', 3),
(13, '22222222-3', '$2y$10$EwZ4dav5aR4fqjBt0NPqRenE6/BhoitshT19AiYPZOJmfrSpYKGai', 3),
(14, '22222222-4', '$2y$10$kr4W/P6hq52rfX2PWh6Qje/ETsxpj7PS8xuy4KaOwx2RJUfQuERdS', 3),
(15, '22222222-5', '$2y$10$u7Ql0Jss3UEEBoK115RB/OTqmhhxH9bsbdNqWwcm3/0t74x1DCXSC', 3),
(16, '33333333-1', '$2y$10$VWxOMT8Ofv6IsZNhcBQkfOb7DVGu8iIQLande25fBbihAklJNv5ja', 3),
(17, '33333333-2', '$2y$10$hJ0lEnat9jrkQcPXY4DWy.w/0OK/tTCBOJWGG/Wo7eZKwJD9bKSgO', 3),
(18, '44444444-1', '$2y$10$aNgKw3AawRwBYRY57dOGCuLlz3QsU9.jZdpGHKZyfGlmfTwJUy3.G', 3),
(19, '44444444-2', '$2y$10$EctXPX7t2uCWr9iAlJ7Mbe52T5zXumlvWZJBFZXaWHhjGXluCh4qi', 3);

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`rut_empresa`, `nombre`, `nombre_representante`, `mail_representante`, `telefono_representante`, `convenio_USM`, `id_tamaño_empresa`) VALUES
('12345678-9', 'Tech Solutions SpA', 'Juan Pérez', 'juan@tech.cl', '+56912345678', 1, 2),
('76123456-1', 'TechSol SpA', 'Ana Martínez', 'ana@techsol.cl', '912345601', 1, 1),
('76234567-2', 'Innovatech Ltda', 'Pedro Rojas', 'pedro@innovatech.cl', '912345602', 0, 2),
('76345678-3', 'DataMinds SA', 'Carla Fuentes', 'carla@dataminds.cl', '912345603', 1, 3),
('76456789-4', 'GreenCode SpA', 'Luis Mora', 'luis@greencode.cl', '912345604', 0, 1),
('76543221-1', 'Agua .com', 'Francisco Pancho', 'fran.pancho@agua.com', '911122344', 0, 1),
('76567890-5', 'SoftAndina Ltda', 'Valentina Ríos', 'vale@softandina.cl', '912345605', 1, 2),
('76678901-6', 'CiberChile SA', 'Marco Salinas', 'marco@ciberchile.cl', '912345606', 0, 3);

--
-- Volcado de datos para la tabla `equipo_trabajo`
--

INSERT INTO `equipo_trabajo` (`codigo_interno`, `rut`, `rol`, `es_responsable`) VALUES
(1, '11111111-1', 'Jefe de Proyecto', 1),
(1, '11111111-2', 'Coordinador Técnico', 0),
(1, '11111111-3', 'Asesor Metodológico', 0),
(1, '22222222-1', 'Desarrollador Frontend', 0),
(1, '22222222-2', 'Desarrollador Backend', 0),
(1, '22222222-3', 'Analista de Datos', 0),
(1, '22222222-4', 'Tester QA', 1),
(1, '22222222-5', 'Diseñador UX', 0),
(2, '11111111-3', 'Jefe de Proyecto', 1),
(2, '11111111-4', 'Coordinador Técnico', 0),
(2, '11111111-5', 'Asesor Metodológico', 0),
(2, '22222222-5', 'Desarrollador Frontend', 0),
(2, '22222222-6', 'Desarrollador Backend', 0),
(2, '22222222-7', 'Analista de Datos', 0),
(2, '22222222-8', 'Tester QA', 0),
(2, '22222222-9', 'Diseñador UX', 0),
(3, '11111111-5', 'Jefe de Proyecto', 1),
(3, '11111111-6', 'Coordinador Técnico', 0),
(3, '11111111-7', 'Asesor Metodológico', 0),
(3, '22222222-0', 'Desarrollador Backend', 0),
(3, '22222222-9', 'Desarrollador Frontend', 0),
(3, '33333333-1', 'Analista de Datos', 0),
(3, '33333333-2', 'Tester QA', 0),
(3, '33333333-3', 'Diseñador UX', 0),
(4, '11111111-7', 'Jefe de Proyecto', 1),
(4, '11111111-8', 'Coordinador Técnico', 0),
(4, '11111111-9', 'Asesor Metodológico', 0),
(4, '33333333-3', 'Desarrollador Frontend', 0),
(4, '33333333-4', 'Desarrollador Backend', 0),
(4, '33333333-5', 'Analista de Datos', 0),
(4, '33333333-6', 'Tester QA', 0),
(4, '33333333-7', 'Diseñador UX', 0),
(5, '11111111-0', 'Coordinador Técnico', 0),
(5, '11111111-1', 'Asesor Metodológico', 0),
(5, '11111111-9', 'Jefe de Proyecto', 1),
(5, '33333333-0', 'Tester QA', 0),
(5, '33333333-7', 'Desarrollador Frontend', 0),
(5, '33333333-8', 'Desarrollador Backend', 0),
(5, '33333333-9', 'Analista de Datos', 0),
(5, '44444444-1', 'Diseñador UX', 0),
(6, '11111111-1', 'Jefe de Proyecto', 1),
(6, '11111111-3', 'Coordinador Técnico', 0),
(6, '11111111-5', 'Asesor Metodológico', 0),
(6, '22222222-1', 'Analista de Datos', 0),
(6, '22222222-3', 'Tester QA', 0),
(6, '22222222-6', 'Diseñador UX', 0),
(6, '44444444-1', 'Desarrollador Frontend', 0),
(6, '44444444-2', 'Desarrollador Backend', 0),
(7, '11111111-2', 'Jefe de Proyecto', 1),
(7, '11111111-4', 'Coordinador Técnico', 0),
(7, '11111111-6', 'Asesor Metodológico', 0),
(7, '22222222-2', 'Desarrollador Frontend', 0),
(7, '22222222-4', 'Desarrollador Backend', 0),
(7, '22222222-7', 'Analista de Datos', 0),
(7, '22222222-8', 'Tester QA', 0),
(7, '33333333-1', 'Diseñador UX', 0),
(8, '11111111-4', 'Jefe de Proyecto', 1),
(8, '11111111-6', 'Coordinador Técnico', 0),
(8, '11111111-8', 'Asesor Metodológico', 0),
(8, '33333333-0', 'Diseñador UX', 0),
(8, '33333333-2', 'Desarrollador Frontend', 0),
(8, '33333333-4', 'Desarrollador Backend', 0),
(8, '33333333-6', 'Analista de Datos', 0),
(8, '33333333-8', 'Tester QA', 0),
(9, '11111111-0', 'Asesor Metodológico', 0),
(9, '11111111-7', 'Jefe de Proyecto', 1),
(9, '11111111-9', 'Coordinador Técnico', 0),
(9, '22222222-0', 'Desarrollador Frontend', 0),
(9, '33333333-3', 'Desarrollador Backend', 0),
(9, '33333333-5', 'Analista de Datos', 0),
(9, '33333333-7', 'Tester QA', 0),
(9, '44444444-1', 'Diseñador UX', 0),
(10, '11111111-0', 'Coordinador Técnico', 0),
(10, '11111111-2', 'Asesor Metodológico', 0),
(10, '11111111-8', 'Jefe de Proyecto', 1),
(10, '22222222-5', 'Desarrollador Backend', 0),
(10, '22222222-9', 'Tester QA', 0),
(10, '33333333-2', 'Diseñador UX', 0),
(10, '33333333-9', 'Analista de Datos', 0),
(10, '44444444-2', 'Desarrollador Frontend', 0),
(17, '44444444-2', 'Responsable', 1),
(18, '44444444-2', 'Responsable', 1),
(19, '44444444-2', 'Responsable', 1);

--
-- Volcado de datos para la tabla `etapa`
--

INSERT INTO `etapa` (`id_etapa`, `nombre_etapa`, `semanas_plazo`, `entregable`, `codigo_interno_e`) VALUES
(1, 'Levantamiento de requisitos', 4, 'Documento de requisitos', 1),
(2, 'Diseño y arquitectura', 6, 'Diagrama de arquitectura', 1),
(3, 'Desarrollo e implementación', 45, 'Sistema funcional desplegado', 1),
(4, 'Análisis de datos históricos', 3, 'Informe de análisis', 2),
(5, 'Desarrollo de sensores', 8, 'Prototipo IoT funcional', 2),
(6, 'Integración y pruebas', 6, 'Reporte de pruebas', 2),
(7, 'Diseño instruccional', 5, 'Plan de contenidos aprobado', 3),
(8, 'Desarrollo de módulos LMS', 8, 'Módulos LMS publicados', 3),
(9, 'Piloto con usuarios reales', 4, 'Informe de piloto', 3),
(10, 'Modelamiento de rutas', 4, 'Modelo matemático validado', 4),
(11, 'Implementación del algoritmo', 9, 'Algoritmo en producción', 4),
(12, 'Integración con flota', 6, 'Sistema integrado con flota', 4),
(13, 'Análisis requerimientos PYME', 4, 'Catálogo de funciones', 5),
(14, 'Desarrollo módulos ERP', 10, 'ERP beta desplegado', 5),
(15, 'Capacitación y despliegue', 5, 'Manual de usuario entregado', 5),
(16, 'Recolección preguntas frecuentes', 3, 'Base de conocimiento lista', 6),
(17, 'Entrenamiento modelo NLP', 7, 'Modelo NLP entrenado', 6),
(18, 'Despliegue y monitoreo', 4, 'Chatbot en producción', 6),
(19, 'Mapeo de cadena productiva', 5, 'Mapa de procesos aprobado', 7),
(20, 'Desarrollo blockchain', 12, 'Red blockchain operativa', 7),
(21, 'Certificación y validación', 8, 'Certificado piloto emitido', 7),
(22, 'Investigación y diseño UX', 4, 'Wireframes validados', 8),
(23, 'Desarrollo app móvil', 8, 'App beta publicada', 8),
(24, 'Pruebas con usuarios', 3, 'Informe de usabilidad', 8),
(25, 'Instalación sensores solares', 4, 'Sensores instalados', 9),
(26, 'Desarrollo dashboard', 7, 'Dashboard funcional', 9),
(27, 'Contacto con entidades estatales', 5, 'Informe con sello municipal', 9),
(28, 'Validación y ajustes finales', 4, 'Reporte final entregado', 9),
(29, 'Análisis de inventario actual', 3, 'Diagnóstico de stock', 10),
(30, 'Implementación RFID', 7, 'Sistema RFID activo', 10),
(31, 'Integración con ERP', 5, 'ERP actualizado con RFID', 10);

--
-- Volcado de datos para la tabla `integrantes`
--

INSERT INTO `integrantes` (`nombre`, `rut`, `dpto`, `mail`, `telefono`, `id_sede`, `id_tipo`) VALUES
('Daniela Cruz', '11111111-0', 'Industrial', 'dcruz@usm.cl', '911000010', 5, 1),
('Jorge Castillo', '11111111-1', 'Informática', 'jcastillo@usm.cl', '911000001', 1, 1),
('Mónica Vera', '11111111-2', 'Electrónica', 'mvera@usm.cl', '911000002', 1, 1),
('Andrés Pino', '11111111-3', 'Matemáticas', 'apino@usm.cl', '911000003', 2, 1),
('Claudia Soto', '11111111-4', 'Computación', 'csoto@usm.cl', '911000004', 2, 1),
('Ricardo Núñez', '11111111-5', 'Industrial', 'rnunez@usm.cl', '911000005', 3, 1),
('Patricia Lagos', '11111111-6', 'Informática', 'plagos@usm.cl', '911000006', 3, 1),
('Sebastián Díaz', '11111111-7', 'Electrónica', 'sdiaz@usm.cl', '911000007', 4, 1),
('Isabel Ramos', '11111111-8', 'Matemáticas', 'iramos@usm.cl', '911000008', 4, 1),
('Felipe Muñoz', '11111111-9', 'Computación', 'fmunoz@usm.cl', '911000009', 5, 1),
('Ignacio Moya', '22222222-0', 'Industrial', 'imoya@alumnos.usm.cl', '922000010', 3, 2),
('Camila Torres', '22222222-1', 'Informática', 'ctorres@alumnos.usm.cl', '922000001', 1, 2),
('Diego Herrera', '22222222-2', 'Informática', 'dherrera@alumnos.usm.cl', '922000002', 1, 2),
('Sofía Mendez', '22222222-3', 'Electrónica', 'smendez@alumnos.usm.cl', '922000003', 1, 2),
('Matías Flores', '22222222-4', 'Matemáticas', 'mflores@alumnos.usm.cl', '922000004', 1, 2),
('Valentina Ossa', '22222222-5', 'Computación', 'vossa@alumnos.usm.cl', '922000005', 2, 2),
('Nicolás Ibarra', '22222222-6', 'Industrial', 'nibarra@alumnos.usm.cl', '922000006', 2, 2),
('Fernanda Reyes', '22222222-7', 'Informática', 'freyes@alumnos.usm.cl', '922000007', 2, 2),
('Tomás Contreras', '22222222-8', 'Electrónica', 'tcontreras@alumnos.usm.cl', '922000008', 2, 2),
('Paula Jiménez', '22222222-9', 'Computación', 'pjimenez@alumnos.usm.cl', '922000009', 3, 2),
('Maximiliano Ríos', '33333333-0', 'Industrial', 'mrios@alumnos.usm.cl', '933000010', 5, 2),
('Catalina Bravo', '33333333-1', 'Informática', 'cbravo@alumnos.usm.cl', '933000001', 3, 2),
('Rodrigo Sepúlveda', '33333333-2', 'Matemáticas', 'rsepulveda@alumnos.usm.cl', '933000002', 3, 2),
('Isidora Parra', '33333333-3', 'Electrónica', 'iparra@alumnos.usm.cl', '933000003', 4, 2),
('Benjamín Vega', '33333333-4', 'Computación', 'bvega@alumnos.usm.cl', '933000004', 4, 2),
('Antonia Guzmán', '33333333-5', 'Industrial', 'aguzman@alumnos.usm.cl', '933000005', 4, 2),
('Cristóbal Lara', '33333333-6', 'Informática', 'clara@alumnos.usm.cl', '933000006', 4, 2),
('Javiera Espinoza', '33333333-7', 'Matemáticas', 'jespinoza@alumnos.usm.cl', '933000007', 5, 2),
('Emilio Tapia', '33333333-8', 'Electrónica', 'etapia@alumnos.usm.cl', '933000008', 5, 2),
('Renata Fuentes', '33333333-9', 'Computación', 'rfuentes@alumnos.usm.cl', '933000009', 5, 2),
('Constanza Muñoz', '44444444-1', 'Informática', 'cmunoz@alumnos.usm.cl', '944000001', 1, 2),
('Álvaro Peña', '44444444-2', 'Electrónica', 'apena@alumnos.usm.cl', '944000002', 2, 2);

--
-- Volcado de datos para la tabla `postulacion`
--

INSERT INTO `postulacion` (`codigo_interno`, `numero_postulacion`, `fecha_postulacion`, `nombre_iniciativa`, `objetivo`, `descripcion_soluciones`, `resultados_esperados`, `presupuesto`, `rut_empresa`, `id_sede`, `id_reg_ejec`, `id_reg_impc`, `id_tipo_iniciativa`, `id_estado_postulacion`) VALUES
(1, 'POST-001', '2026-03-01', 'Sistema de Gestión Documental', 'Digitalizar procesos administrativos', 'Plataforma web de gestión de documentos', 'Reducir tiempos administrativos en 40%', 12000000.00, '76123456-1', 1, 5, 13, 1, 1),
(2, 'POST-002', '2026-03-03', 'App Monitoreo Ambiental', 'Monitorear calidad del aire en tiempo real', 'Aplicación móvil con sensores IoT integrados', 'Alertas automáticas de contaminación operativas', 18500000.00, '76234567-2', 2, 13, 8, 2, 1),
(3, 'POST-003', '2026-03-05', 'Plataforma E-Learning', 'Mejorar acceso a educación remota en regiones', 'LMS con módulos adaptativos de aprendizaje', '500 usuarios capacitados en primer semestre', 9800000.00, '76345678-3', 3, 4, 5, 1, 2),
(4, 'POST-004', '2026-03-07', 'Sistema Logística Inteligente', 'Optimizar rutas de distribución de productos', 'Algoritmo de ruteo con Machine Learning', 'Reducir costos logísticos en 25%', 22000000.00, '76456789-4', 4, 9, 13, 2, 1),
(5, 'POST-005', '2026-03-10', 'Portal Gestión PYME', 'Centralizar operaciones de pequeñas empresas', 'ERP simplificado desplegado en la nube', '30 empresas beneficiadas con el sistema', 15500000.00, '76567890-5', 5, 8, 4, 1, 3),
(6, 'POST-006', '2026-03-12', 'Chatbot Atención Ciudadana', 'Automatizar consultas en municipios', 'Chatbot con procesamiento de lenguaje natural', 'Reducir tiempos de espera ciudadana en 60%', 8200000.00, '76678901-6', 1, 13, 5, 2, 1),
(7, 'POST-007', '2026-03-14', 'Sistema Trazabilidad Agrícola', 'Registrar cadena productiva agrícola completa', 'Blockchain para trazabilidad de productos', 'Certificación para exportaciones obtenida', 31000000.00, '76123456-1', 2, 4, 9, 1, 2),
(8, 'POST-008', '2026-03-17', 'App Salud Mental Universitaria', 'Apoyar bienestar emocional de estudiantes', 'App móvil con recursos psicológicos digitales', '1000 estudiantes atendidos en el año', 7600000.00, '76234567-2', 3, 5, 13, 2, 1),
(9, 'POST-009', '2026-03-20', 'Dashboard Energía Renovable', 'Visualizar consumo energético en tiempo real', 'Panel de métricas para paneles solares', 'Ahorro del 35% en consumo energético', 19400000.00, '76345678-3', 4, 3, 8, 1, 4),
(10, 'POST-010', '2026-03-22', 'Sistema Inventario Inteligente', 'Automatizar control de stock en bodegas', 'RFID integrado con sistema ERP existente', 'Reducir pérdidas de inventario en 50%', 13700000.00, '76456789-4', 5, 13, 3, 2, 2),
(17, 'POST-011', '2026-05-15', 'appsita', 'objetivo', 'solutions UwUr', 'results lwk', 123123123.00, '76345678-3', 2, 13, 14, 2, 3),
(18, 'POST-012', '2026-05-15', 'App optimizacion de comidas', 'optimizar las comidas diarias de manera eficiente', 'crear aplicacion', 'aplicacion de optimizacion util y modular', 120000000.00, '76543221-1', 3, 15, 3, 1, 1),
(19, 'POST-013', '2026-05-15', 'aplicaicoon', 'probando', 'testear', 'pruebas y testing', 1200000.00, '76543221-1', 2, 10, 16, 2, 3);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
