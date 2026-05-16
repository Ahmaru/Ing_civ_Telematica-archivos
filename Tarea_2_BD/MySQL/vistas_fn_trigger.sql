-- ==================== VISTAS ====================

CREATE OR REPLACE VIEW postulaciones_vista_academic AS
SELECT
    p.codigo_interno,
    p.numero_postulacion,
    empresa.nombre AS nombre_empresa,
    a.descripcion AS region_ejecucion,
    b.descripcion AS region_impacto,
    sede.descripcion AS sede,
    ti.descripcion AS tipo_iniciativa,
    p.presupuesto,
    p.fecha_postulacion,
    p.nombre_iniciativa,
    p.objetivo,
    p.descripcion_soluciones,
    p.resultados_esperados,
    es.descripcion AS estado,
    et.rol,
    et.rut AS responsable
FROM (((((((postulacion AS p
    INNER JOIN empresa ON empresa.rut_empresa = p.rut_empresa)
    INNER JOIN regiones AS a ON a.id_regiones = p.id_reg_ejec)
    INNER JOIN regiones AS b ON b.id_regiones = p.id_reg_impc)
    INNER JOIN sede ON sede.id_sede = p.id_sede)
    INNER JOIN tipo_iniciativa ti ON ti.id_tipo_in = p.id_tipo_iniciativa)
    INNER JOIN estado_postulacion es ON es.id_estado = p.id_estado_postulacion)
    INNER JOIN equipo_trabajo et ON (et.codigo_interno = p.codigo_interno AND et.es_responsable = 1));

CREATE OR REPLACE VIEW v_postulaciones_evaluador AS
SELECT p.numero_postulacion AS 'N_postulacion',
       p.nombre_iniciativa AS 'Iniciativa',
       ep.descripcion AS 'Estado',
       ti.descripcion AS 'Tipo_iniciativa'
FROM postulacion p
JOIN estado_postulacion ep ON p.id_estado_postulacion = ep.id_estado
JOIN tipo_iniciativa ti ON p.id_tipo_iniciativa = ti.id_tipo_in
WHERE p.id_estado_postulacion = 1;

-- ==================== TABLA DE AUDITORÍA ====================
CREATE TABLE IF NOT EXISTS auditoria_postulacion (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    codigo_interno INT NOT NULL,
    estado_anterior INT,
    estado_nuevo INT,
    fecha_cambio TIMESTAMP DEFAULT NOW(),
    rut_usuario VARCHAR(12),
    FOREIGN KEY (codigo_interno) REFERENCES postulacion(codigo_interno),
    FOREIGN KEY (estado_anterior) REFERENCES estado_postulacion(id_estado),
    FOREIGN KEY (estado_nuevo) REFERENCES estado_postulacion(id_estado),
    FOREIGN KEY (rut_usuario) REFERENCES integrantes(rut)
);

-- ==================== TRIGGERS ====================

-- TRIGGER 1: Auditar cambios de estado en postulación
DELIMITER //
CREATE TRIGGER trg_auditoria_cambio_estado
AFTER UPDATE ON postulacion
FOR EACH ROW
BEGIN
    IF NEW.id_estado_postulacion != OLD.id_estado_postulacion THEN
        INSERT INTO auditoria_postulacion (codigo_interno, estado_anterior, estado_nuevo)
        VALUES (NEW.codigo_interno, OLD.id_estado_postulacion, NEW.id_estado_postulacion);
    END IF;
END//
DELIMITER ;

-- TRIGGER 2: Validar que no se edite postulación fuera de estado Borrador
DELIMITER //
CREATE TRIGGER trg_validar_edicion_postulacion
BEFORE UPDATE ON postulacion
FOR EACH ROW
BEGIN
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
END//
DELIMITER ;

-- TRIGGER 3: Registrar creación de postulación en auditoría
DELIMITER //
CREATE TRIGGER trg_auditoria_nueva_postulacion
AFTER INSERT ON postulacion
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_postulacion (codigo_interno, estado_anterior, estado_nuevo)
    VALUES (NEW.codigo_interno, NULL, NEW.id_estado_postulacion);
END//
DELIMITER ;

-- ==================== PROCEDURES ====================

-- PROCEDURE 1: Registrar evaluación completa
DELIMITER //
CREATE PROCEDURE sp_registrar_evaluacion(
    IN p_codigo_interno INT,
    IN p_rut_evaluador VARCHAR(12),
    IN p_estado_nuevo INT,
    IN p_comentarios VARCHAR(255)
)
BEGIN
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
END//
DELIMITER ;

-- PROCEDURE 2: Asignar evaluador a postulación
DELIMITER //
CREATE PROCEDURE sp_asignar_evaluador(
    IN p_codigo_interno INT,
    IN p_rut_evaluador VARCHAR(12)
)
BEGIN
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
END//
DELIMITER ;

-- PROCEDURE 3: Crear postulación (validaciones complejas)
DELIMITER //
CREATE PROCEDURE sp_crear_postulacion(
    IN p_numero_postulacion VARCHAR(20),
    IN p_nombre_iniciativa VARCHAR(100),
    IN p_objetivo VARCHAR(255),
    IN p_descripcion_soluciones VARCHAR(255),
    IN p_resultados_esperados VARCHAR(255),
    IN p_presupuesto DECIMAL(12,2),
    IN p_rut_empresa VARCHAR(12),
    IN p_id_sede INT,
    IN p_id_reg_ejec INT,
    IN p_id_reg_impc INT,
    IN p_id_tipo_iniciativa INT,
    IN p_rut_responsable VARCHAR(12),
    OUT p_codigo_generado INT
)
BEGIN
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
END//
DELIMITER ;

-- ==================== FUNCTIONS ====================

-- FUNCTION 1: Validar si un usuario puede editar una postulación
DELIMITER //
CREATE FUNCTION fn_puede_editar_postulacion(
    p_codigo INT,
    p_rut_usuario VARCHAR(12)
) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
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
END//
DELIMITER ;

-- FUNCTION 2: Obtener descripción del estado
DELIMITER //
CREATE FUNCTION fn_obtener_estado(p_id_estado INT)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_descripcion VARCHAR(50);

    SELECT descripcion INTO v_descripcion
    FROM estado_postulacion
    WHERE id_estado = p_id_estado;

    RETURN IFNULL(v_descripcion, 'Desconocido');
END//
DELIMITER ;

-- FUNCTION 3: Contar postulaciones de un evaluador en estado "En revisión"
DELIMITER //
CREATE FUNCTION fn_postulaciones_pendientes_evaluador(p_rut_evaluador VARCHAR(12))
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT;

    SELECT COUNT(*) INTO v_total
    FROM evaluacion e
    JOIN postulacion p ON e.codigo_interno = p.codigo_interno
    WHERE e.rut_evaluador = p_rut_evaluador
    AND p.id_estado_postulacion = 1;

    RETURN IFNULL(v_total, 0);
END//
DELIMITER ;

-- ==================== EJEMPLOS DE USO ====================

-- Llamar procedure: sp_registrar_evaluacion
-- CALL sp_registrar_evaluacion(1, '22222222-2', 2, 'Excelente iniciativa, recomendado para aprobación');

-- Llamar procedure: sp_asignar_evaluador
-- CALL sp_asignar_evaluador(1, '22222222-2');

-- Llamar function: fn_puede_editar_postulacion
-- SELECT fn_puede_editar_postulacion(1, '11111111-1');

-- Llamar function: fn_postulaciones_pendientes_evaluador
-- SELECT fn_postulaciones_pendientes_evaluador('22222222-2');

-- Ver auditoría
-- SELECT * FROM auditoria_postulacion ORDER BY fecha_cambio DESC;
