--creamos la base de datos

CREATE DATABASE postulaciones_ct_usm;

-- Definimos los catalogos rn

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

-- tabla cronograma no estoy seguro pero igual la planteo en caso de
-- tuve que cambiarla por logica de la BD
CREATE TABLE etapa (
    id_etapa INT PRIMARY KEY AUTO_INCREMENT,
    plazo INT NOT NULL,
    entregable VARCHAR(200) NOT NULL,
    connect_cronograma INT FOREIGN KEY
) Engine=InnoDB;

CREATE TABLE cronograma (
    id_cronograma INT PRIMARY KEY AUTO_INCREMENT,
    id_etapa INT,
    FOREIGN KEY (id_etapa) REFERENCES etapa(id_etapa)
) Engine=InnoDB;

CREATE TABLE empresa (
    rut_empresa VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    nombre_representante VARCHAR(100) NOT NULL,
    mail_representante VARCHAR(100) NOT NULL,
    telefono_representante INT NOT NULL UNIQUE,
    convenio_USM BOOLEAN
) Engine=InnoDB;

CREATE TABLE integrantes (
    nombre VARCHAR(100) NOT NULL UNIQUE,
    rut VARCHAR(12) PRIMARY KEY,
    dpto VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    telefono INT UNIQUE
) Engine=InnoDB;

CREATE TABLE postulacion (
    -- luego sigo con esto ya que necesito P2 para seguir con las definiciones y alguna
    -- conexion con otras tablas
) Engine=InnoDB;
;

-- Aqui comenzamos a llenar los catalogos como son valores constantes

INSERT INTO sede (descripcion)
    VALUES ("Sede Casa central Valparaiso"),
    VALUES ("Sede San Joaquin"),
    VALUES ("Sede Vitacura"),
    VALUES ("Sede Viña del Mar"),
    VALUES ("Sede Concepcion")
;

INSERT INTO tamaño_empresa (descripcion)
    VALUES ("Micro-empresa"),
    VALUES ("Mediana"),
    VALUES ("Grande")
;

INSERT INTO regiones (descripcion)
    VALUES ("Región de Tarapaca"),
    VALUES ("Región de Antofagasta"),
    VALUES ("Región de Atacama"),
    VALUES ("Región de Coquimbo"),
    VALUES ("Región de Valparaiso"),
    VALUES ("Región del Libertador Bernardo O'Higgins"),
    VALUES ("Región del Maule"),
    VALUES ("Región del Biobio"),
    VALUES ("Región de la Araucania"),
    VALUES ("Región de Los Lagos"),
    VALUES ("Región de Aisen"),
    VALUES ("Región de Magallanes y Antartica Chilena"),
    VALUES ("Región Metropolitana"),
    VALUES ("Región de Los Rios"),
    VALUES ("Región de Arica-Parinacota"),
    VALUES ("Región de Nuble")
;

INSERT INTO estado_postulacion (descripcion)
    VALUES ("En revisión"),
    VALUES ("Aprobada"),
    VALUES ("Rechazada"),
    VALUES ("Cerrada")
;

INSERT INTO tipo_integrante (descripcion)
    VALUES ("Profesor"),
    VALUES ("Estudiante")
;

INSERT INTO tipo_iniciativa (descripcion)
    VALUES ("Nueva"),
    VALUES ("Existente")
;

-- con esto deberia estar casi listo el script de creacion
