--creamos la base de datos
CREATE DATABASE postulaciones_ct_usm;

--Creamos los catalogos
CREATE TABLE sede (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB; -- como piden InnoDB se define en la creacion.

CREATE TABLE tamaño_empresa (
    id_tamaño INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE regiones (
    id_regiones INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE estado_postulacion (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE tipo_integrante (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB;

CREATE TABLE tipo_iniciativa (
    id_tipo_in INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
) Engine=InnoDB;
-- hasta aqui llegan los catalogos

CREATE TABLE postulacion (
    codigo_interno INT PRIMARY KEY AUTO_INCREMENT,
    numero_postulacion VARCHAR(20) UNIQUE NOT NULL,
    fecha_postulacion DATE NOT NULL,
    nombre_iniciativa VARCHAR(100) NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    descripcion_soluciones VARCHAR(255) NOT NULL,
    resultados_esperados VARCHAR(255) NOT NULL,
    nombre_rep1 VARCHAR(100) NOT NULL,
    nombre_rep2 VARCHAR(100) NOT NULL,
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

CREATE TABLE etapa (
    id_etapa INT PRIMARY KEY AUTO_INCREMENT,
    nombre_etapa VARCHAR(100) NOT NULL,
    semanas_plazo INT NOT NULL,
    entregable VARCHAR(100) NOT NULL,
    codigo_interno INT,
    FOREIGN KEY (codigo_interno) REFERENCES postulacion(codigo_interno)
) Engine=InnoDB;

CREATE TABLE empresa (
    rut_empresa VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    nombre_representante VARCHAR(100) NOT NULL,
    mail_representante VARCHAR(100) NOT NULL,
    telefono_representante INT NOT NULL UNIQUE,
    convenio_USM TINYINT NOT NULL,
    id_tamaño_empresa INT,
    FOREIGN KEY (id_tamaño_empresa) REFERENCES tamaño_empresa(id_tamaño)
) Engine=InnoDB;

CREATE TABLE integrantes (
    nombre VARCHAR(100) NOT NULL UNIQUE,
    rut VARCHAR(12) PRIMARY KEY,
    dpto VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    telefono INT UNIQUE,
    id_sede INT,
    FOREIGN KEY (id_sede) REFERENCES sede(id_sede),
    id_tipo INT,
    FOREIGN KEY (id_tipo) REFERENCES tipo_integrante(id_tipo)
) Engine=InnoDB;

CREATE TABLE equipo_trabajo (
    codigo_interno INT,
    rut VARCHAR(12),
    rol VARCHAR(50) NOT NULL,
    --primary key compuesta para que no se repita el mismo integrante en la misma postulacion.
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
    ("Cerrada")
;

INSERT INTO tipo_integrante (descripcion) VALUES
    ("Profesor"),
    ("Estudiante")
;

INSERT INTO tipo_iniciativa (descripcion) VALUES
    ("Nueva"),
    ("Existente")
;

-- con esto deberia estar casi listo el script de creacion
