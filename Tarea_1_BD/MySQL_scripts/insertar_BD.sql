--Script para llenar la base de datos

USE postulaciones_ct_usm;


INSERT INTO integrantes (rut, nombre, dpto, mail, telefono, id_sede, id_tipo) VALUES

    ('11111111-1', 'Jorge Castillo',   'Informática',   'jcastillo@usm.cl',  '911000001', 1, 1),
    ('11111111-2', 'Mónica Vera',      'Electrónica',   'mvera@usm.cl',      '911000002', 1, 1),
    ('11111111-3', 'Andrés Pino',      'Matemáticas',   'apino@usm.cl',      '911000003', 2, 1),
    ('11111111-4', 'Claudia Soto',     'Computación',   'csoto@usm.cl',      '911000004', 2, 1),
    ('11111111-5', 'Ricardo Núñez',    'Industrial',    'rnunez@usm.cl',     '911000005', 3, 1),
    ('11111111-6', 'Patricia Lagos',   'Informática',   'plagos@usm.cl',     '911000006', 3, 1),
    ('11111111-7', 'Sebastián Díaz',   'Electrónica',   'sdiaz@usm.cl',      '911000007', 4, 1),
    ('11111111-8', 'Isabel Ramos',     'Matemáticas',   'iramos@usm.cl',     '911000008', 4, 1),
    ('11111111-9', 'Felipe Muñoz',     'Computación',   'fmunoz@usm.cl',     '911000009', 5, 1),
    ('11111111-0', 'Daniela Cruz',     'Industrial',    'dcruz@usm.cl',      '911000010', 5, 1),

    ('22222222-1', 'Camila Torres',      'Informática',   'ctorres@alumnos.usm.cl',    '922000001', 1, 2),
    ('22222222-2', 'Diego Herrera',      'Informática',   'dherrera@alumnos.usm.cl',   '922000002', 1, 2),
    ('22222222-3', 'Sofía Mendez',       'Electrónica',   'smendez@alumnos.usm.cl',    '922000003', 1, 2),
    ('22222222-4', 'Matías Flores',      'Matemáticas',   'mflores@alumnos.usm.cl',    '922000004', 1, 2),
    ('22222222-5', 'Valentina Ossa',     'Computación',   'vossa@alumnos.usm.cl',      '922000005', 2, 2),
    ('22222222-6', 'Nicolás Ibarra',     'Industrial',    'nibarra@alumnos.usm.cl',    '922000006', 2, 2),
    ('22222222-7', 'Fernanda Reyes',     'Informática',   'freyes@alumnos.usm.cl',     '922000007', 2, 2),
    ('22222222-8', 'Tomás Contreras',    'Electrónica',   'tcontreras@alumnos.usm.cl', '922000008', 2, 2),
    ('22222222-9', 'Paula Jiménez',      'Computación',   'pjimenez@alumnos.usm.cl',   '922000009', 3, 2),
    ('22222222-0', 'Ignacio Moya',       'Industrial',    'imoya@alumnos.usm.cl',      '922000010', 3, 2),
    ('33333333-1', 'Catalina Bravo',     'Informática',   'cbravo@alumnos.usm.cl',     '933000001', 3, 2),
    ('33333333-2', 'Rodrigo Sepúlveda',  'Matemáticas',   'rsepulveda@alumnos.usm.cl', '933000002', 3, 2),
    ('33333333-3', 'Isidora Parra',      'Electrónica',   'iparra@alumnos.usm.cl',     '933000003', 4, 2),
    ('33333333-4', 'Benjamín Vega',      'Computación',   'bvega@alumnos.usm.cl',      '933000004', 4, 2),
    ('33333333-5', 'Antonia Guzmán',     'Industrial',    'aguzman@alumnos.usm.cl',    '933000005', 4, 2),
    ('33333333-6', 'Cristóbal Lara',     'Informática',   'clara@alumnos.usm.cl',      '933000006', 4, 2),
    ('33333333-7', 'Javiera Espinoza',   'Matemáticas',   'jespinoza@alumnos.usm.cl',  '933000007', 5, 2),
    ('33333333-8', 'Emilio Tapia',       'Electrónica',   'etapia@alumnos.usm.cl',     '933000008', 5, 2),
    ('33333333-9', 'Renata Fuentes',     'Computación',   'rfuentes@alumnos.usm.cl',   '933000009', 5, 2),
    ('33333333-0', 'Maximiliano Ríos',   'Industrial',    'mrios@alumnos.usm.cl',      '933000010', 5, 2),
    ('44444444-1', 'Constanza Muñoz',    'Informática',   'cmunoz@alumnos.usm.cl',     '944000001', 1, 2),
    ('44444444-2', 'Álvaro Peña',        'Electrónica',   'apena@alumnos.usm.cl',      '944000002', 2, 2)
;

INSERT INTO empresa (rut_empresa,nombre,nombre_representante,mail_representante,telefono_representante,convenio_USM,id_tamaño_empresa) VALUES
    
    ('76123456-1', 'TechSol SpA',       'Ana Martínez',    'ana@techsol.cl',        '912345601', 1, 1),
    ('76234567-2', 'Innovatech Ltda',   'Pedro Rojas',     'pedro@innovatech.cl',   '912345602', 0, 2),
    ('76345678-3', 'DataMinds SA',      'Carla Fuentes',   'carla@dataminds.cl',    '912345603', 1, 3),
    ('76456789-4', 'GreenCode SpA',     'Luis Mora',       'luis@greencode.cl',     '912345604', 0, 1),
    ('76567890-5', 'SoftAndina Ltda',   'Valentina Ríos',  'vale@softandina.cl',    '912345605', 1, 2),
    ('76678901-6', 'CiberChile SA',     'Marco Salinas',   'marco@ciberchile.cl',   '912345606', 0, 3)
;

INSERT INTO postulacion (numero_postulacion, fecha_postulacion, nombre_iniciativa, objetivo, descripcion_soluciones, resultados_esperados, nombre_rep1, nombre_rep2, presupuesto, rut_empresa, id_sede, id_reg_ejec, id_reg_impc, id_tipo_inciativa, id_estado_postulacion) VALUES
    
    ('POST-001', '2026-03-01', 'Sistema de Gestión Documental',
    'Digitalizar procesos administrativos',
    'Plataforma web de gestión de documentos',
    'Reducir tiempos administrativos en 40%',
    'Prof. Jorge Castillo', 'Prof. Mónica Vera',
    12000000.00, '76123456-1', 1, 5, 13, 1, 1),

    ('POST-002', '2026-03-03', 'App Monitoreo Ambiental',
    'Monitorear calidad del aire en tiempo real',
    'Aplicación móvil con sensores IoT integrados',
    'Alertas automáticas de contaminación operativas',
    'Prof. Andrés Pino', 'Prof. Claudia Soto',
    18500000.00, '76234567-2', 2, 13, 8, 2, 1),

    ('POST-003', '2026-03-05', 'Plataforma E-Learning',
    'Mejorar acceso a educación remota en regiones',
    'LMS con módulos adaptativos de aprendizaje',
    '500 usuarios capacitados en primer semestre',
    'Prof. Ricardo Núñez', 'Prof. Patricia Lagos',
    9800000.00, '76345678-3', 3, 4, 5, 1, 2),

    ('POST-004', '2026-03-07', 'Sistema Logística Inteligente',
    'Optimizar rutas de distribución de productos',
    'Algoritmo de ruteo con Machine Learning',
    'Reducir costos logísticos en 25%',
    'Prof. Sebastián Díaz', 'Prof. Isabel Ramos',
    22000000.00, '76456789-4', 4, 9, 13, 2, 1),

    ('POST-005', '2026-03-10', 'Portal Gestión PYME',
    'Centralizar operaciones de pequeñas empresas',
    'ERP simplificado desplegado en la nube',
    '30 empresas beneficiadas con el sistema',
    'Prof. Felipe Muñoz', 'Prof. Daniela Cruz',
    15500000.00, '76567890-5', 5, 8, 4, 1, 3),

    ('POST-006', '2026-03-12', 'Chatbot Atención Ciudadana',
    'Automatizar consultas en municipios',
    'Chatbot con procesamiento de lenguaje natural',
    'Reducir tiempos de espera ciudadana en 60%',
    'Prof. Jorge Castillo', 'Prof. Andrés Pino',
    8200000.00, '76678901-6', 1, 13, 5, 2, 1),

    ('POST-007', '2026-03-14', 'Sistema Trazabilidad Agrícola',
    'Registrar cadena productiva agrícola completa',
    'Blockchain para trazabilidad de productos',
    'Certificación para exportaciones obtenida',
    'Prof. Mónica Vera', 'Prof. Ricardo Núñez',
    31000000.00, '76123456-1', 2, 4, 9, 1, 2),

    ('POST-008', '2026-03-17', 'App Salud Mental Universitaria',
    'Apoyar bienestar emocional de estudiantes',
    'App móvil con recursos psicológicos digitales',
    '1000 estudiantes atendidos en el año',
    'Prof. Claudia Soto', 'Prof. Felipe Muñoz',
    7600000.00, '76234567-2', 3, 5, 13, 2, 1),

    ('POST-009', '2026-03-20', 'Dashboard Energía Renovable',
    'Visualizar consumo energético en tiempo real',
    'Panel de métricas para paneles solares',
    'Ahorro del 35% en consumo energético',
    'Prof. Patricia Lagos', 'Prof. Isabel Ramos',
    19400000.00, '76345678-3', 4, 3, 8, 1, 4),

    ('POST-010', '2026-03-22', 'Sistema Inventario Inteligente',
    'Automatizar control de stock en bodegas',
    'RFID integrado con sistema ERP existente',
    'Reducir pérdidas de inventario en 50%',
    'Prof. Sebastián Díaz', 'Prof. Daniela Cruz',
    13700000.00, '76456789-4', 5, 13, 3, 2, 1)
;

INSERT INTO etapa (nombre_etapa, semanas_plazo, entregable, codigo_interno_e) VALUES

    ('Levantamiento de requisitos',   4,  'Documento de requisitos',      1),
    ('Diseño y arquitectura',         6,  'Diagrama de arquitectura',     1),
    ('Desarrollo e implementación',   45, 'Sistema funcional desplegado', 1),
    ('Análisis de datos históricos',  3,  'Informe de análisis',          2),
    ('Desarrollo de sensores',        8,  'Prototipo IoT funcional',      2),
    ('Integración y pruebas',         6,  'Reporte de pruebas',           2),
    ('Diseño instruccional',          5,  'Plan de contenidos aprobado',  3),
    ('Desarrollo de módulos LMS',     8,  'Módulos LMS publicados',       3),
    ('Piloto con usuarios reales',    4,  'Informe de piloto',            3),
    ('Modelamiento de rutas',         4,  'Modelo matemático validado',   4),
    ('Implementación del algoritmo',  9,  'Algoritmo en producción',      4),
    ('Integración con flota',         6,  'Sistema integrado con flota',  4),
    ('Análisis requerimientos PYME',  4,  'Catálogo de funciones',        5),
    ('Desarrollo módulos ERP',        10, 'ERP beta desplegado',          5),
    ('Capacitación y despliegue',     5,  'Manual de usuario entregado',  5),
    ('Recolección preguntas frecuentes', 3, 'Base de conocimiento lista', 6),
    ('Entrenamiento modelo NLP',      7,  'Modelo NLP entrenado',         6),
    ('Despliegue y monitoreo',        4,  'Chatbot en producción',        6),
    ('Mapeo de cadena productiva',    5,  'Mapa de procesos aprobado',    7),
    ('Desarrollo blockchain',         12, 'Red blockchain operativa',     7),
    ('Certificación y validación',    8,  'Certificado piloto emitido',   7),
    ('Investigación y diseño UX',     4,  'Wireframes validados',         8),
    ('Desarrollo app móvil',          8,  'App beta publicada',           8),
    ('Pruebas con usuarios',          3,  'Informe de usabilidad',        8),
    ('Instalación sensores solares',  4,  'Sensores instalados',          9),
    ('Desarrollo dashboard',          7,  'Dashboard funcional',          9),
    ('Validación y ajustes finales',  4,  'Reporte final entregado',      9),
    ('Análisis de inventario actual', 3,  'Diagnóstico de stock',         10),
    ('Implementación RFID',           7,  'Sistema RFID activo',          10),
    ('Integración con ERP',           5,  'ERP actualizado con RFID',     10)
;

INSERT INTO equipo_trabajo (codigo_interno, rut, rol) VALUES

    (1, '11111111-1', 'Jefe de Proyecto'),
    (1, '11111111-2', 'Coordinador Técnico'),
    (1, '11111111-3', 'Asesor Metodológico'),
    (1, '22222222-1', 'Desarrollador Frontend'),
    (1, '22222222-2', 'Desarrollador Backend'),
    (1, '22222222-3', 'Analista de Datos'),
    (1, '22222222-4', 'Tester QA'),
--    (1, '22222222-5', 'Diseñador UX'),

    (2, '11111111-3', 'Jefe de Proyecto'),
    (2, '11111111-4', 'Coordinador Técnico'),
    (2, '11111111-5', 'Asesor Metodológico'),
    (2, '22222222-5', 'Desarrollador Frontend'),
    (2, '22222222-6', 'Desarrollador Backend'),
    (2, '22222222-7', 'Analista de Datos'),
    (2, '22222222-8', 'Tester QA'),
    (2, '22222222-9', 'Diseñador UX'),

    (3, '11111111-5', 'Jefe de Proyecto'),
    (3, '11111111-6', 'Coordinador Técnico'),
    (3, '11111111-7', 'Asesor Metodológico'),
    (3, '22222222-9', 'Desarrollador Frontend'),
    (3, '22222222-0', 'Desarrollador Backend'),
    (3, '33333333-1', 'Analista de Datos'),
    (3, '33333333-2', 'Tester QA'),
    (3, '33333333-3', 'Diseñador UX'),

    (4, '11111111-7', 'Jefe de Proyecto'),
    (4, '11111111-8', 'Coordinador Técnico'),
    (4, '11111111-9', 'Asesor Metodológico'),
    (4, '33333333-3', 'Desarrollador Frontend'),
    (4, '33333333-4', 'Desarrollador Backend'),
    (4, '33333333-5', 'Analista de Datos'),
    (4, '33333333-6', 'Tester QA'),
    (4, '33333333-7', 'Diseñador UX'),

    (5, '11111111-9', 'Jefe de Proyecto'),
    (5, '11111111-0', 'Coordinador Técnico'),
    (5, '11111111-1', 'Asesor Metodológico'),
    (5, '33333333-7', 'Desarrollador Frontend'),
    (5, '33333333-8', 'Desarrollador Backend'),
    (5, '33333333-9', 'Analista de Datos'),
    (5, '33333333-0', 'Tester QA'),
    (5, '44444444-1', 'Diseñador UX'),

    (6, '11111111-1', 'Jefe de Proyecto'),
    (6, '11111111-3', 'Coordinador Técnico'),
    (6, '11111111-5', 'Asesor Metodológico'),
    (6, '44444444-1', 'Desarrollador Frontend'),
    (6, '44444444-2', 'Desarrollador Backend'),
    (6, '22222222-1', 'Analista de Datos'),
    (6, '22222222-3', 'Tester QA'),
    (6, '22222222-6', 'Diseñador UX'),

    (7, '11111111-2', 'Jefe de Proyecto'),
    (7, '11111111-4', 'Coordinador Técnico'),
    (7, '11111111-6', 'Asesor Metodológico'),
    (7, '22222222-2', 'Desarrollador Frontend'),
    (7, '22222222-4', 'Desarrollador Backend'),
    (7, '22222222-7', 'Analista de Datos'),
    (7, '22222222-8', 'Tester QA'),
    (7, '33333333-1', 'Diseñador UX'),

    (8, '11111111-4', 'Jefe de Proyecto'),
    (8, '11111111-6', 'Coordinador Técnico'),
    (8, '11111111-8', 'Asesor Metodológico'),
    (8, '33333333-2', 'Desarrollador Frontend'),
    (8, '33333333-4', 'Desarrollador Backend'),
    (8, '33333333-6', 'Analista de Datos'),
    (8, '33333333-8', 'Tester QA'),
    (8, '33333333-0', 'Diseñador UX'),

    (9, '11111111-7', 'Jefe de Proyecto'),
    (9, '11111111-9', 'Coordinador Técnico'),
    (9, '11111111-0', 'Asesor Metodológico'),
    (9, '22222222-0', 'Desarrollador Frontend'),
    (9, '33333333-3', 'Desarrollador Backend'),
    (9, '33333333-5', 'Analista de Datos'),
    (9, '33333333-7', 'Tester QA'),
    (9, '44444444-1', 'Diseñador UX'),

    (10, '11111111-8', 'Jefe de Proyecto'),
    (10, '11111111-0', 'Coordinador Técnico'),
    (10, '11111111-2', 'Asesor Metodológico'),
    (10, '44444444-2', 'Desarrollador Frontend'),
    (10, '22222222-5', 'Desarrollador Backend'),
    (10, '33333333-9', 'Analista de Datos'),
    (10, '22222222-9', 'Tester QA'),
    (10, '33333333-2', 'Diseñador UX')
;


