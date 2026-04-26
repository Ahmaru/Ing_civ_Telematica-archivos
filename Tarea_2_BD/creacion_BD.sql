--creamos la base de datos
CREATE DATABASE IF NOT EXISTS postulaciones_ct_usm;

--Usamos la base de datos ya creada
USE postulaciones_ct_usm;

--Creamos los catalogos
CREATE TABLE IF NOT EXISTS sede (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB; -- como piden InnoDB se define en la creacion.

CREATE TABLE IF NOT EXISTS tamaño_empresa (
    id_tamaño INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS regiones (
    id_regiones INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS estado_postulacion (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS tipo_integrante (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS tipo_ingreso (
    id_tipo  INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(30) NOT NULL
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS tipo_iniciativa (
    id_tipo_in INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
) Engine=InnoDB;

-- hasta aqui llegan los catalogos

CREATE TABLE IF NOT EXISTS empresa (
    rut_empresa VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    nombre_representante VARCHAR(100) NOT NULL,
    mail_representante VARCHAR(100) NOT NULL,
    telefono_representante VARCHAR(12) NOT NULL UNIQUE,
    convenio_USM TINYINT NOT NULL,
    id_tamaño_empresa INT,
    FOREIGN KEY (id_tamaño_empresa) REFERENCES tamaño_empresa(id_tamaño)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS postulacion (
    codigo_interno INT PRIMARY KEY AUTO_INCREMENT,
    numero_postulacion VARCHAR(20) UNIQUE NOT NULL,
    fecha_postulacion DATE NOT NULL,
    nombre_iniciativa VARCHAR(100) NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    descripcion_soluciones VARCHAR(255) NOT NULL,
    resultados_esperados VARCHAR(255) NOT NULL,
    -- nombre_rep1 VARCHAR(100) NOT NULL,
    -- nombre_rep2 VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    rut_empresa VARCHAR(12) NOT NULL,
    FOREIGN KEY (rut_empresa) REFERENCES empresa(rut_empresa),
    id_sede INT,
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede),
    id_reg_ejec INT,
    FOREIGN KEY (id_reg_ejec) REFERENCES regiones(id_regiones),
    id_reg_impc INT,
    FOREIGN KEY (id_reg_impc) REFERENCES regiones(id_regiones),
    id_tipo_inciativa INT,
    FOREIGN KEY (id_tipo_inciativa) REFERENCES tipo_iniciativa(id_tipo_in),
    id_estado_postulacion INT,
    FOREIGN KEY (id_estado_postulacion) REFERENCES estado_postulacion(id_estado)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS etapa (
    id_etapa INT PRIMARY KEY AUTO_INCREMENT,
    nombre_etapa VARCHAR(100) NOT NULL,
    semanas_plazo INT NOT NULL,
    entregable VARCHAR(100) NOT NULL,
    codigo_interno_e INT,
    FOREIGN KEY (codigo_interno_e) REFERENCES postulacion(codigo_interno)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS integrantes (
    nombre VARCHAR(100) NOT NULL UNIQUE,
    rut VARCHAR(12) PRIMARY KEY,
    dpto VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(12) UNIQUE,
    id_sede INT,
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede),
    id_tipo INT,
    FOREIGN KEY (id_tipo) REFERENCES tipo_integrante(id_tipo)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS credenciales (
    id_usr INT PRIMARY KEY AUTO_INCREMENT,
    rut VARCHAR(12) ,
    password VARCHAR(20) NOT NULL,
    id_tipo INT NOT NULL,
    FOREIGN KEY (rut) REFERENCES integrantes(rut),
    FOREIGN KEY (id_tipo) REFERENCES tipo_ingreso(id_tipo)
) Engine=InnoDB;

CREATE TABLE IF NOT EXISTS equipo_trabajo (
    codigo_interno INT,
    rut VARCHAR(12),
    rol VARCHAR(50) NOT NULL,
    es_responsable TINYINT NOT NULL,
    PRIMARY KEY (codigo_interno,rut),
    FOREIGN KEY (rut) REFERENCES integrantes(rut),
    FOREIGN KEY (codigo_interno) REFERENCES postulacion(codigo_interno)
) Engine=InnoDB;

-- Aqui comenzamos a llenar los catalogos como son valores constantes

INSERT INTO sede (descripcion) VALUES
    ("Campus Casa central Valparaiso"),
    ("Campus San Joaquin"),
    ("Campus Vitacura"),
    ("Sede Viña del Mar"),
    ("Sede Concepcion")
;

INSERT INTO tamaño_empresa (descripcion) VALUES
    ("Micro-empresa"),
    ("Mediana"),
    ("Grande")
;

INSERT INTO regiones (descripcion) VALUES
    ("Región de Tarapaca"),
    ("Región de Antofagasta"),
    ("Región de Atacama"),
    ("Región de Coquimbo"),
    ("Región de Valparaiso"),
    ("Región del Libertador Bernardo O'Higgins"),
    ("Región del Maule"),
    ("Región del Biobio"),
    ("Región de la Araucania"),
    ("Región de Los Lagos"),
    ("Región de Aisen"),
    ("Región de Magallanes y Antartica Chilena"),
    ("Región Metropolitana"),
    ("Región de Los Rios"),
    ("Región de Arica-Parinacota"),
    ("Región de Nuble")
;

INSERT INTO estado_postulacion (descripcion) VALUES
    ("En revisión"),
    ("Aprobada"),
    ("Rechazada"),
    ("Cerrada"),
    ("Borrador")
;

INSERT INTO tipo_integrante (descripcion) VALUES
    ("Profesor"),
    ("Estudiante")
;

INSERT INTO tipo_iniciativa (descripcion) VALUES
    ("Nueva"),
    ("Existente")
;

INSERT INTO tipo_ingreso (descripcion) VALUES 
    ("Administrador CT-USM"),
    ("Coordinador de proyecto"),
    ("Responsable Academico")
;

-- con esto deberia estar casi listo el script de creacion
