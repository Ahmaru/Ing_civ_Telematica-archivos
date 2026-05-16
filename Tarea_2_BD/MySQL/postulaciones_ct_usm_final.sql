-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-05-2026 a las 14:45:10
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
CREATE DATABASE IF NOT EXISTS `postulaciones_ct_usm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `postulaciones_ct_usm`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_asignar_evaluador`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignar_evaluador` (IN `p_codigo_interno` INT, IN `p_rut_evaluador` VARCHAR(12))   BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al asignar evaluador';
    END;

    START TRANSACTION;

    -- 1. Validar que la postulación existe y está en revisión
    SELECT COUNT(*) INTO v_existe
    FROM postulacion
    WHERE codigo_interno = p_codigo_interno
    AND id_estado_postulacion = 1;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Postulación no encontrada o no está en revisión';
    END IF;

    -- 2. Validar que el evaluador existe y es coordinador
    SELECT COUNT(*) INTO v_existe
    FROM credenciales
    WHERE rut = p_rut_evaluador
    AND id_tipo = 2;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Evaluador no encontrado o no es coordinador';
    END IF;

    -- 3. Validar que no esté ya asignado
    SELECT COUNT(*) INTO v_existe
    FROM evaluacion
    WHERE codigo_interno = p_codigo_interno
    AND rut_evaluador = p_rut_evaluador;

    IF v_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El evaluador ya está asignado a esta postulación';
    END IF;

    -- 4. Insertar asignación
    INSERT INTO evaluacion (codigo_interno, rut_evaluador, estado_nuevo)
    VALUES (p_codigo_interno, p_rut_evaluador, 1);

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_crear_postulacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_postulacion` (IN `p_numero_postulacion` VARCHAR(20), IN `p_nombre_iniciativa` VARCHAR(100), IN `p_objetivo` VARCHAR(255), IN `p_descripcion_soluciones` VARCHAR(255), IN `p_resultados_esperados` VARCHAR(255), IN `p_presupuesto` DECIMAL(12,2), IN `p_rut_empresa` VARCHAR(12), IN `p_id_sede` INT, IN `p_id_reg_ejec` INT, IN `p_id_reg_impc` INT, IN `p_id_tipo_iniciativa` INT, IN `p_rut_responsable` VARCHAR(12), OUT `p_codigo_generado` INT)   BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_codigo_generado = -1;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al crear postulación';
    END;

    START TRANSACTION;

    -- 1. Validar que la empresa existe
    SELECT COUNT(*) INTO v_existe
    FROM empresa
    WHERE rut_empresa = p_rut_empresa;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Empresa no encontrada';
    END IF;

    -- 2. Validar que el responsable existe
    SELECT COUNT(*) INTO v_existe
    FROM integrantes
    WHERE rut = p_rut_responsable;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Responsable no encontrado';
    END IF;

    -- 3. Crear postulación
    INSERT INTO postulacion (
        numero_postulacion, fecha_postulacion, nombre_iniciativa,
        objetivo, descripcion_soluciones, resultados_esperados,
        presupuesto, rut_empresa, id_sede, id_reg_ejec, id_reg_impc,
        id_tipo_iniciativa, id_estado_postulacion
    ) VALUES (
        p_numero_postulacion, NOW(), p_nombre_iniciativa,
        p_objetivo, p_descripcion_soluciones, p_resultados_esperados,
        p_presupuesto, p_rut_empresa, p_id_sede, p_id_reg_ejec, p_id_reg_impc,
        p_id_tipo_iniciativa, 5
    );

    SET p_codigo_generado = LAST_INSERT_ID();

    -- 4. Agregar responsable al equipo_trabajo
    INSERT INTO equipo_trabajo (codigo_interno, rut, rol, es_responsable)
    VALUES (p_codigo_generado, p_rut_responsable, 'Responsable', 1);

    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `sp_registrar_evaluacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_evaluacion` (IN `p_codigo_interno` INT, IN `p_rut_evaluador` VARCHAR(12), IN `p_estado_nuevo` INT, IN `p_comentarios` VARCHAR(255))   BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al registrar evaluación';
    END;

    START TRANSACTION;

    -- 1. Validar que la postulación existe y está en revisión
    SELECT COUNT(*) INTO v_existe
    FROM postulacion
    WHERE codigo_interno = p_codigo_interno
    AND id_estado_postulacion = 1;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Postulación no encontrada o no está en revisión';
    END IF;

    -- 2. Validar que el evaluador está asignado
    SELECT COUNT(*) INTO v_existe
    FROM evaluacion
    WHERE codigo_interno = p_codigo_interno
    AND rut_evaluador = p_rut_evaluador;

    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Evaluador no está asignado a esta postulación';
    END IF;

    -- 3. Actualizar estado de la postulación
    UPDATE postulacion
    SET id_estado_postulacion = p_estado_nuevo
    WHERE codigo_interno = p_codigo_interno;

    -- 4. Actualizar evaluación con comentarios y estado
    UPDATE evaluacion
    SET estado_nuevo = p_estado_nuevo,
        comentarios = p_comentarios,
        fecha_evaluacion = NOW()
    WHERE codigo_interno = p_codigo_interno
    AND rut_evaluador = p_rut_evaluador;

    COMMIT;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `fn_obtener_estado`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_obtener_estado` (`p_id_estado` INT) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC READS SQL DATA BEGIN
    DECLARE v_descripcion VARCHAR(50);

    SELECT descripcion INTO v_descripcion
    FROM estado_postulacion
    WHERE id_estado = p_id_estado;

    RETURN IFNULL(v_descripcion, 'Desconocido');
END$$

DROP FUNCTION IF EXISTS `fn_postulaciones_pendientes_evaluador`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_postulaciones_pendientes_evaluador` (`p_rut_evaluador` VARCHAR(12)) RETURNS INT(11) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE v_total INT;

    SELECT COUNT(*) INTO v_total
    FROM evaluacion e
    JOIN postulacion p ON e.codigo_interno = p.codigo_interno
    WHERE e.rut_evaluador = p_rut_evaluador
    AND p.id_estado_postulacion = 1;

    RETURN IFNULL(v_total, 0);
END$$

DROP FUNCTION IF EXISTS `fn_puede_editar_postulacion`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_puede_editar_postulacion` (`p_codigo` INT, `p_rut_usuario` VARCHAR(12)) RETURNS TINYINT(1) DETERMINISTIC BEGIN
    DECLARE v_puede BOOLEAN DEFAULT FALSE;

    SELECT CASE
        WHEN COUNT(*) > 0 THEN TRUE
        ELSE FALSE
    END INTO v_puede
    FROM postulacion p
    JOIN equipo_trabajo et ON p.codigo_interno = et.codigo_interno
    WHERE p.codigo_interno = p_codigo
    AND et.rut = p_rut_usuario
    AND et.es_responsable = 1
    AND p.id_estado_postulacion = 5;

    RETURN v_puede;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_postulacion`
--

DROP TABLE IF EXISTS `auditoria_postulacion`;
CREATE TABLE IF NOT EXISTS `auditoria_postulacion` (
  `id_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_interno` int(11) NOT NULL,
  `estado_anterior` int(11) DEFAULT NULL,
  `estado_nuevo` int(11) DEFAULT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp(),
  `rut_usuario` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id_auditoria`),
  KEY `codigo_interno` (`codigo_interno`),
  KEY `estado_anterior` (`estado_anterior`),
  KEY `estado_nuevo` (`estado_nuevo`),
  KEY `rut_usuario` (`rut_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auditoria_postulacion`
--

INSERT INTO `auditoria_postulacion` (`id_auditoria`, `codigo_interno`, `estado_anterior`, `estado_nuevo`, `fecha_cambio`, `rut_usuario`) VALUES
(2, 17, NULL, 5, '2026-05-15 23:46:21', NULL),
(3, 17, 5, 1, '2026-05-15 23:46:42', NULL),
(4, 17, 1, 3, '2026-05-15 23:55:06', NULL),
(5, 18, NULL, 5, '2026-05-16 03:33:19', NULL),
(6, 18, 5, 1, '2026-05-16 03:33:30', NULL),
(7, 10, 1, 2, '2026-05-16 03:34:53', NULL),
(8, 19, NULL, 5, '2026-05-16 03:48:27', NULL),
(9, 19, 5, 1, '2026-05-16 03:48:35', NULL),
(10, 19, 1, 3, '2026-05-16 03:49:29', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credenciales`
--

DROP TABLE IF EXISTS `credenciales`;
CREATE TABLE IF NOT EXISTS `credenciales` (
  `id_usr` int(11) NOT NULL AUTO_INCREMENT,
  `rut` varchar(12) DEFAULT NULL,
  `password` varchar(70) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_usr`),
  KEY `rut` (`rut`),
  KEY `id_tipo` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `rut_empresa` varchar(12) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `nombre_representante` varchar(100) NOT NULL,
  `mail_representante` varchar(100) NOT NULL,
  `telefono_representante` varchar(12) NOT NULL,
  `convenio_USM` tinyint(4) NOT NULL,
  `id_tamaño_empresa` int(11) DEFAULT NULL,
  PRIMARY KEY (`rut_empresa`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `telefono_representante` (`telefono_representante`),
  KEY `id_tamaño_empresa` (`id_tamaño_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_trabajo`
--

DROP TABLE IF EXISTS `equipo_trabajo`;
CREATE TABLE IF NOT EXISTS `equipo_trabajo` (
  `codigo_interno` int(11) NOT NULL,
  `rut` varchar(12) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `es_responsable` tinyint(4) NOT NULL,
  PRIMARY KEY (`codigo_interno`,`rut`),
  KEY `rut` (`rut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_postulacion`
--

DROP TABLE IF EXISTS `estado_postulacion`;
CREATE TABLE IF NOT EXISTS `estado_postulacion` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_postulacion`
--

INSERT INTO `estado_postulacion` (`id_estado`, `descripcion`) VALUES
(1, 'En revisión'),
(2, 'Aprobada'),
(3, 'Rechazada'),
(4, 'Cerrada'),
(5, 'Borrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etapa`
--

DROP TABLE IF EXISTS `etapa`;
CREATE TABLE IF NOT EXISTS `etapa` (
  `id_etapa` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_etapa` varchar(100) NOT NULL,
  `semanas_plazo` int(11) NOT NULL,
  `entregable` varchar(100) NOT NULL,
  `codigo_interno_e` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_etapa`),
  KEY `codigo_interno_e` (`codigo_interno_e`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE IF NOT EXISTS `evaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_interno` int(11) NOT NULL,
  `rut_evaluador` varchar(12) NOT NULL,
  `estado_nuevo` int(11) NOT NULL,
  `fecha_evaluacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `comentarios` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `codigo_interno` (`codigo_interno`),
  KEY `rut_evaluador` (`rut_evaluador`),
  KEY `estado_nuevo` (`estado_nuevo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacion`
--

INSERT INTO `evaluacion` (`id`, `codigo_interno`, `rut_evaluador`, `estado_nuevo`, `fecha_evaluacion`, `comentarios`) VALUES
(1, 1, '11111111-2', 1, '2026-05-13 06:58:03', NULL),
(2, 6, '11111111-3', 1, '2026-05-13 06:59:24', NULL),
(3, 17, '11111111-2', 3, '2026-05-15 23:55:06', 'Malardium, borra la cuenta lwk sybau'),
(4, 10, '11111111-2', 2, '2026-05-16 03:34:53', 'Buena iniciativa, esperando resultados demostrables en el tiempo'),
(5, 19, '11111111-2', 3, '2026-05-16 03:49:29', 'Malardium, pruebas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `integrantes`
--

DROP TABLE IF EXISTS `integrantes`;
CREATE TABLE IF NOT EXISTS `integrantes` (
  `nombre` varchar(100) NOT NULL,
  `rut` varchar(12) NOT NULL,
  `dpto` varchar(100) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `id_sede` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  PRIMARY KEY (`rut`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `telefono` (`telefono`),
  KEY `id_sede` (`id_sede`),
  KEY `id_tipo` (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postulacion`
--

DROP TABLE IF EXISTS `postulacion`;
CREATE TABLE IF NOT EXISTS `postulacion` (
  `codigo_interno` int(6) NOT NULL AUTO_INCREMENT,
  `numero_postulacion` varchar(20) NOT NULL,
  `fecha_postulacion` date NOT NULL,
  `nombre_iniciativa` varchar(100) NOT NULL,
  `objetivo` varchar(255) NOT NULL,
  `descripcion_soluciones` varchar(255) NOT NULL,
  `resultados_esperados` varchar(255) NOT NULL,
  `presupuesto` decimal(12,2) NOT NULL,
  `rut_empresa` varchar(12) NOT NULL,
  `id_sede` int(11) DEFAULT NULL,
  `id_reg_ejec` int(11) DEFAULT NULL,
  `id_reg_impc` int(11) DEFAULT NULL,
  `id_tipo_iniciativa` int(11) DEFAULT NULL,
  `id_estado_postulacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo_interno`),
  UNIQUE KEY `numero_postulacion` (`numero_postulacion`),
  KEY `rut_empresa` (`rut_empresa`),
  KEY `id_sede` (`id_sede`),
  KEY `id_reg_ejec` (`id_reg_ejec`),
  KEY `id_reg_impc` (`id_reg_impc`),
  KEY `id_tipo_inciativa` (`id_tipo_iniciativa`),
  KEY `id_estado_postulacion` (`id_estado_postulacion`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Disparadores `postulacion`
--
DROP TRIGGER IF EXISTS `trg_auditoria_cambio_estado`;
DELIMITER $$
CREATE TRIGGER `trg_auditoria_cambio_estado` AFTER UPDATE ON `postulacion` FOR EACH ROW BEGIN
    IF NEW.id_estado_postulacion != OLD.id_estado_postulacion THEN
        INSERT INTO auditoria_postulacion (codigo_interno, estado_anterior, estado_nuevo)
        VALUES (NEW.codigo_interno, OLD.id_estado_postulacion, NEW.id_estado_postulacion);
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_auditoria_nueva_postulacion`;
DELIMITER $$
CREATE TRIGGER `trg_auditoria_nueva_postulacion` AFTER INSERT ON `postulacion` FOR EACH ROW BEGIN
    INSERT INTO auditoria_postulacion (codigo_interno, estado_anterior, estado_nuevo)
    VALUES (NEW.codigo_interno, NULL, NEW.id_estado_postulacion);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_validar_edicion_postulacion`;
DELIMITER $$
CREATE TRIGGER `trg_validar_edicion_postulacion` BEFORE UPDATE ON `postulacion` FOR EACH ROW BEGIN
    IF OLD.id_estado_postulacion != 5 AND (
        NEW.nombre_iniciativa != OLD.nombre_iniciativa OR
        NEW.objetivo != OLD.objetivo OR
        NEW.descripcion_soluciones != OLD.descripcion_soluciones OR
        NEW.resultados_esperados != OLD.resultados_esperados OR
        NEW.presupuesto != OLD.presupuesto OR
        NEW.rut_empresa != OLD.rut_empresa
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se pueden editar postulaciones en estado Borrador';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `postulaciones_vista_academic`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `postulaciones_vista_academic`;
CREATE TABLE IF NOT EXISTS `postulaciones_vista_academic` (
`codigo_interno` int(6)
,`numero_postulacion` varchar(20)
,`nombre_empresa` varchar(100)
,`region_ejecucion` varchar(50)
,`region_impacto` varchar(50)
,`sede` varchar(50)
,`tipo_iniciativa` varchar(100)
,`presupuesto` decimal(12,2)
,`fecha_postulacion` date
,`nombre_iniciativa` varchar(100)
,`objetivo` varchar(255)
,`descripcion_soluciones` varchar(255)
,`resultados_esperados` varchar(255)
,`estado` varchar(50)
,`rol` varchar(50)
,`responsable` varchar(12)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `regiones`
--

DROP TABLE IF EXISTS `regiones`;
CREATE TABLE IF NOT EXISTS `regiones` (
  `id_regiones` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_regiones`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `regiones`
--

INSERT INTO `regiones` (`id_regiones`, `descripcion`) VALUES
(1, 'Región de Tarapaca'),
(2, 'Región de Antofagasta'),
(3, 'Región de Atacama'),
(4, 'Región de Coquimbo'),
(5, 'Región de Valparaiso'),
(6, 'Región del Libertador Bernardo O\'Higgins'),
(7, 'Región del Maule'),
(8, 'Región del Biobio'),
(9, 'Región de la Araucania'),
(10, 'Región de Los Lagos'),
(11, 'Región de Aisen'),
(12, 'Región de Magallanes y Antartica Chilena'),
(13, 'Región Metropolitana'),
(14, 'Región de Los Rios'),
(15, 'Región de Arica-Parinacota'),
(16, 'Región de Nuble');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sede`
--

DROP TABLE IF EXISTS `sede`;
CREATE TABLE IF NOT EXISTS `sede` (
  `id_sede` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sede`
--

INSERT INTO `sede` (`id_sede`, `descripcion`) VALUES
(1, 'Campus Casa central Valparaiso'),
(2, 'Campus San Joaquin'),
(3, 'Campus Vitacura'),
(4, 'Sede Viña del Mar'),
(5, 'Sede Concepcion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tamaño_empresa`
--

DROP TABLE IF EXISTS `tamaño_empresa`;
CREATE TABLE IF NOT EXISTS `tamaño_empresa` (
  `id_tamaño` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tamaño`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tamaño_empresa`
--

INSERT INTO `tamaño_empresa` (`id_tamaño`, `descripcion`) VALUES
(1, 'Micro-empresa'),
(2, 'Mediana'),
(3, 'Grande');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ingreso`
--

DROP TABLE IF EXISTS `tipo_ingreso`;
CREATE TABLE IF NOT EXISTS `tipo_ingreso` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_ingreso`
--

INSERT INTO `tipo_ingreso` (`id_tipo`, `descripcion`) VALUES
(1, 'Administrador CT-USM'),
(2, 'Coordinador de proyecto'),
(3, 'Responsable Academico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_iniciativa`
--

DROP TABLE IF EXISTS `tipo_iniciativa`;
CREATE TABLE IF NOT EXISTS `tipo_iniciativa` (
  `id_tipo_in` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tipo_in`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_iniciativa`
--

INSERT INTO `tipo_iniciativa` (`id_tipo_in`, `descripcion`) VALUES
(1, 'Nueva'),
(2, 'Existente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_integrante`
--

DROP TABLE IF EXISTS `tipo_integrante`;
CREATE TABLE IF NOT EXISTS `tipo_integrante` (
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_integrante`
--

INSERT INTO `tipo_integrante` (`id_tipo`, `descripcion`) VALUES
(1, 'Profesor'),
(2, 'Estudiante');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_postulaciones_evaluador`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `v_postulaciones_evaluador`;
CREATE TABLE IF NOT EXISTS `v_postulaciones_evaluador` (
`N_postulacion` varchar(20)
,`Iniciativa` varchar(100)
,`Estado` varchar(50)
,`Tipo_iniciativa` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `postulaciones_vista_academic`
--
DROP TABLE IF EXISTS `postulaciones_vista_academic`;

DROP VIEW IF EXISTS `postulaciones_vista_academic`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `postulaciones_vista_academic`  AS SELECT `p`.`codigo_interno` AS `codigo_interno`, `p`.`numero_postulacion` AS `numero_postulacion`, `empresa`.`nombre` AS `nombre_empresa`, `a`.`descripcion` AS `region_ejecucion`, `b`.`descripcion` AS `region_impacto`, `sede`.`descripcion` AS `sede`, `ti`.`descripcion` AS `tipo_iniciativa`, `p`.`presupuesto` AS `presupuesto`, `p`.`fecha_postulacion` AS `fecha_postulacion`, `p`.`nombre_iniciativa` AS `nombre_iniciativa`, `p`.`objetivo` AS `objetivo`, `p`.`descripcion_soluciones` AS `descripcion_soluciones`, `p`.`resultados_esperados` AS `resultados_esperados`, `es`.`descripcion` AS `estado`, `et`.`rol` AS `rol`, `et`.`rut` AS `responsable` FROM (((((((`postulacion` `p` join `empresa` on(`empresa`.`rut_empresa` = `p`.`rut_empresa`)) join `regiones` `a` on(`a`.`id_regiones` = `p`.`id_reg_ejec`)) join `regiones` `b` on(`b`.`id_regiones` = `p`.`id_reg_impc`)) join `sede` on(`sede`.`id_sede` = `p`.`id_sede`)) join `tipo_iniciativa` `ti` on(`ti`.`id_tipo_in` = `p`.`id_tipo_iniciativa`)) join `estado_postulacion` `es` on(`es`.`id_estado` = `p`.`id_estado_postulacion`)) join `equipo_trabajo` `et` on(`et`.`codigo_interno` = `p`.`codigo_interno` and `et`.`es_responsable` = 1)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_postulaciones_evaluador`
--
DROP TABLE IF EXISTS `v_postulaciones_evaluador`;

DROP VIEW IF EXISTS `v_postulaciones_evaluador`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_postulaciones_evaluador`  AS SELECT `p`.`numero_postulacion` AS `N_postulacion`, `p`.`nombre_iniciativa` AS `Iniciativa`, `ep`.`descripcion` AS `Estado`, `ti`.`descripcion` AS `Tipo_iniciativa` FROM ((`postulacion` `p` join `estado_postulacion` `ep` on(`p`.`id_estado_postulacion` = `ep`.`id_estado`)) join `tipo_iniciativa` `ti` on(`p`.`id_tipo_iniciativa` = `ti`.`id_tipo_in`)) WHERE `p`.`id_estado_postulacion` = 1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auditoria_postulacion`
--
ALTER TABLE `auditoria_postulacion`
  ADD CONSTRAINT `auditoria_postulacion_ibfk_1` FOREIGN KEY (`codigo_interno`) REFERENCES `postulacion` (`codigo_interno`),
  ADD CONSTRAINT `auditoria_postulacion_ibfk_2` FOREIGN KEY (`estado_anterior`) REFERENCES `estado_postulacion` (`id_estado`),
  ADD CONSTRAINT `auditoria_postulacion_ibfk_3` FOREIGN KEY (`estado_nuevo`) REFERENCES `estado_postulacion` (`id_estado`),
  ADD CONSTRAINT `auditoria_postulacion_ibfk_4` FOREIGN KEY (`rut_usuario`) REFERENCES `integrantes` (`rut`);

--
-- Filtros para la tabla `credenciales`
--
ALTER TABLE `credenciales`
  ADD CONSTRAINT `credenciales_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `integrantes` (`rut`),
  ADD CONSTRAINT `credenciales_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_ingreso` (`id_tipo`);

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`id_tamaño_empresa`) REFERENCES `tamaño_empresa` (`id_tamaño`);

--
-- Filtros para la tabla `equipo_trabajo`
--
ALTER TABLE `equipo_trabajo`
  ADD CONSTRAINT `equipo_trabajo_ibfk_1` FOREIGN KEY (`rut`) REFERENCES `integrantes` (`rut`),
  ADD CONSTRAINT `equipo_trabajo_ibfk_2` FOREIGN KEY (`codigo_interno`) REFERENCES `postulacion` (`codigo_interno`);

--
-- Filtros para la tabla `etapa`
--
ALTER TABLE `etapa`
  ADD CONSTRAINT `etapa_ibfk_1` FOREIGN KEY (`codigo_interno_e`) REFERENCES `postulacion` (`codigo_interno`);

--
-- Filtros para la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `evaluacion_ibfk_1` FOREIGN KEY (`codigo_interno`) REFERENCES `postulacion` (`codigo_interno`),
  ADD CONSTRAINT `evaluacion_ibfk_2` FOREIGN KEY (`rut_evaluador`) REFERENCES `integrantes` (`rut`),
  ADD CONSTRAINT `evaluacion_ibfk_3` FOREIGN KEY (`estado_nuevo`) REFERENCES `estado_postulacion` (`id_estado`);

--
-- Filtros para la tabla `integrantes`
--
ALTER TABLE `integrantes`
  ADD CONSTRAINT `integrantes_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`id_sede`),
  ADD CONSTRAINT `integrantes_ibfk_2` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_integrante` (`id_tipo`);

--
-- Filtros para la tabla `postulacion`
--
ALTER TABLE `postulacion`
  ADD CONSTRAINT `postulacion_ibfk_1` FOREIGN KEY (`rut_empresa`) REFERENCES `empresa` (`rut_empresa`),
  ADD CONSTRAINT `postulacion_ibfk_2` FOREIGN KEY (`id_sede`) REFERENCES `sede` (`id_sede`),
  ADD CONSTRAINT `postulacion_ibfk_3` FOREIGN KEY (`id_reg_ejec`) REFERENCES `regiones` (`id_regiones`),
  ADD CONSTRAINT `postulacion_ibfk_4` FOREIGN KEY (`id_reg_impc`) REFERENCES `regiones` (`id_regiones`),
  ADD CONSTRAINT `postulacion_ibfk_5` FOREIGN KEY (`id_tipo_iniciativa`) REFERENCES `tipo_iniciativa` (`id_tipo_in`),
  ADD CONSTRAINT `postulacion_ibfk_6` FOREIGN KEY (`id_estado_postulacion`) REFERENCES `estado_postulacion` (`id_estado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
