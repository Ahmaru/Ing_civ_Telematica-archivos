-- DATOS DE PRUEBA PARA TESTEAR

-- 1. Crear empresa de prueba
INSERT INTO empresa (rut_empresa, nombre, nombre_representante, mail_representante, telefono_representante, convenio_USM, id_tamaño_empresa)
VALUES ('12345678-9', 'Tech Solutions SpA', 'Juan Pérez', 'juan@tech.cl', '+56912345678', 1, 2);

-- 2. Crear integrante postulante de prueba (Responsable Académico)
INSERT INTO integrantes (nombre, rut, dpto, mail, telefono, id_sede, id_tipo)
VALUES ('Carlos Rodríguez', '11111111-1', 'Informática', 'carlos@usm.cl', '+56912345679', 1, 1);

-- 3. Crear credencial para el postulante (ROL 3 = Responsable Académico)
-- Password: 123456 (hashed)
INSERT INTO credenciales (rut, password, id_tipo)
VALUES ('11111111-1', '$2y$10$qKGRkLjy1JlRp2LnKyqPkesxh0Nv8g7w2B4K2L6M8N0P2Q4R6S8U', 3);

-- 4. Crear integrante evaluador de prueba (Coordinador de proyecto)
INSERT INTO integrantes (nombre, rut, dpto, mail, telefono, id_sede, id_tipo)
VALUES ('María González', '22222222-2', 'Coordinación CT', 'maria@usm.cl', '+56912345680', 1, 1);

-- 5. Crear credencial para el evaluador (ROL 2 = Coordinador)
-- Password: 123456 (hashed)
INSERT INTO credenciales (rut, password, id_tipo)
VALUES ('22222222-2', '$2y$10$qKGRkLjy1JlRp2LnKyqPkesxh0Nv8g7w2B4K2L6M8N0P2Q4R6S8U', 2);

-- 6. Crear integrante admin de prueba (Administrador)
INSERT INTO integrantes (nombre, rut, dpto, mail, telefono, id_sede, id_tipo)
VALUES ('Pedro López', '33333333-3', 'Administración', 'pedro@usm.cl', '+56912345681', 1, 1);

-- 7. Crear credencial para el admin (ROL 1 = Administrador)
-- Password: 123456 (hashed)
INSERT INTO credenciales (rut, password, id_tipo)
VALUES ('33333333-3', '$2y$10$qKGRkLjy1JlRp2LnKyqPkesxh0Nv8g7w2B4K2L6M8N0P2Q4R6S8U', 1);

-- Notas:
-- La contraseña 123456 hasheada en bcrypt es: $2y$10$qKGRkLjy1JlRp2LnKyqPkesxh0Nv8g7w2B4K2L6M8N0P2Q4R6S8U
-- Para login: usrname = rut (sin guión o con guión), psswrd = 123456
