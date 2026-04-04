-- Definimos los catalogos rn

CREATE TABLE sede (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB -- como piden InnoDB se define en la creacion.

CREATE TABLE tamaño_empresa (
    id_tamaño INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB

CREATE TABLE regiones (
    id_regiones INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB

CREATE TABLE estado_postulacion (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB

CREATE TABLE tipo_integrante (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
) Engine=InnoDB

CREATE TABLE tipo_iniciativa (
    id_tipo_in INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
) Engine=InnoDB

-- tabla cronograma no estoy seguro pero igual la planteo en caso de
-- tuve que cambiarla por logica de la BD
CREATE TABLE etapa (
    id_etapa INT PRIMARY KEY AUTO_INCREMENT,
    plazo TIME NOT NULL,
    entregable VARCHAR(200) NOT NULL,
    connect_cronograma INT FOREIGN KEY
) Engine=InnoDB

CREATE TABLE cronograma (
    id_cronograma INT PRIMARY KEY AUTO_INCREMENT,
    id_etapa INT FOREIGN KEY
) Engine=InnoDB

CREATE TABLE empresa (
    rut_empresa VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    nombre_representante VARCHAR(100) NOT NULL,
    mail_representante VARCHAR(100) NOT NULL,
    telefono_representante INT NOT NULL UNIQUE,
    convenio_USM BOOLEAN
) Engine=InnoDB

CREATE TABLE integrantes (
    nombre VARCHAR(100) NOT NULL UNIQUE,
    rut VARCHAR(12) PRIMARY KEY,
    dpto VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    telefono INT UNIQUE
) Engine=InnoDB

CREATE TABLE postulacion (
    -- luego sigo con esto ya que necesito P2 para seguir con las definiciones y alguna
    -- conexion con otras tablas
) Engine=InnoDB

INSERT INTO integrantes ();

