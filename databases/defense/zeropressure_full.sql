--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: asignacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asignacion (
    id_caso_f integer,
    fecha_asignacion date,
    id_caso_e integer,
    id_ingeniero character varying(10),
    id_ingeniero_2 character varying(10),
    id_ingeniero_3 character varying(10)
);


ALTER TABLE public.asignacion OWNER TO postgres;

--
-- Name: ingenieros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingenieros (
    rut character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    numero_solicitudes_activas integer DEFAULT 0,
    especialidad_1 integer NOT NULL,
    especialidad_2 integer,
    CONSTRAINT ingenieros_especialidad_1_check CHECK (((especialidad_1 >= 1) AND (especialidad_1 <= 3))),
    CONSTRAINT ingenieros_especialidad_2_check CHECK (((especialidad_2 IS NULL) OR ((especialidad_2 >= 1) AND (especialidad_2 <= 3)))),
    CONSTRAINT ingenieros_numero_solicitudes_activas_check CHECK ((numero_solicitudes_activas <= 20))
);


ALTER TABLE public.ingenieros OWNER TO postgres;

--
-- Name: solicitudes_errores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_errores (
    id_caso integer NOT NULL,
    titulo character varying(100) NOT NULL,
    descripcion character varying(200) NOT NULL,
    fecha_publicacion date NOT NULL,
    autor character varying(10) NOT NULL,
    estado character varying(20) NOT NULL,
    numero_asignados smallint DEFAULT 0,
    fecha_solicitud timestamp without time zone DEFAULT now() NOT NULL,
    topico_id integer,
    CONSTRAINT solicitudes_errores_estado_check CHECK (((estado)::text = ANY (ARRAY[('Abierto'::character varying)::text, ('En Progreso'::character varying)::text, ('Resuelto'::character varying)::text, ('Cerrado'::character varying)::text]))),
    CONSTRAINT solicitudes_errores_numero_asignados_check CHECK ((numero_asignados <= 3)),
    CONSTRAINT solicitudes_errores_topico_id_check CHECK (((topico_id IS NULL) OR ((topico_id >= 1) AND (topico_id <= 3))))
);


ALTER TABLE public.solicitudes_errores OWNER TO postgres;

--
-- Name: solicitudes_errores_id_caso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_errores_id_caso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solicitudes_errores_id_caso_seq OWNER TO postgres;

--
-- Name: solicitudes_errores_id_caso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_errores_id_caso_seq OWNED BY public.solicitudes_errores.id_caso;


--
-- Name: solicitudes_funcionalidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudes_funcionalidad (
    id_caso integer NOT NULL,
    titulo character varying(100) NOT NULL,
    ambiente_desarrollo character varying(10),
    resumen character varying(150) NOT NULL,
    criterios_aceptacion text NOT NULL,
    estado character varying(20) NOT NULL,
    solicitante character varying(10) NOT NULL,
    numero_asignados smallint DEFAULT 0,
    fecha_solicitud timestamp without time zone DEFAULT now() NOT NULL,
    topico_id integer NOT NULL,
    CONSTRAINT solicitudes_funcionalidad_ambiente_desarrollo_check CHECK (((ambiente_desarrollo)::text = ANY ((ARRAY['Web'::character varying, 'Movil'::character varying])::text[]))),
    CONSTRAINT solicitudes_funcionalidad_estado_check CHECK (((estado)::text = ANY (ARRAY['Abierto'::character varying::text, 'En Progreso'::character varying::text, 'Resuelto'::character varying::text, 'Cerrado'::character varying::text, 'Archivado'::character varying::text]))),
    CONSTRAINT solicitudes_funcionalidad_numero_asignados_check CHECK ((numero_asignados <= 3)),
    CONSTRAINT solicitudes_funcionalidad_titulo_check CHECK ((char_length((titulo)::text) >= 20)),
    CONSTRAINT solicitudes_funcionalidad_topico_id_check CHECK (((topico_id >= 1) AND (topico_id <= 3)))
);


ALTER TABLE public.solicitudes_funcionalidad OWNER TO postgres;

--
-- Name: solicitudes_funcionalidad_id_caso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudes_funcionalidad_id_caso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solicitudes_funcionalidad_id_caso_seq OWNER TO postgres;

--
-- Name: solicitudes_funcionalidad_id_caso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudes_funcionalidad_id_caso_seq OWNED BY public.solicitudes_funcionalidad.id_caso;


--
-- Name: topicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topicos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.topicos OWNER TO postgres;

--
-- Name: topicos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.topicos_id_seq OWNER TO postgres;

--
-- Name: topicos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topicos_id_seq OWNED BY public.topicos.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    rut character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: solicitudes_errores id_caso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_errores ALTER COLUMN id_caso SET DEFAULT nextval('public.solicitudes_errores_id_caso_seq'::regclass);


--
-- Name: solicitudes_funcionalidad id_caso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_funcionalidad ALTER COLUMN id_caso SET DEFAULT nextval('public.solicitudes_funcionalidad_id_caso_seq'::regclass);


--
-- Name: topicos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topicos ALTER COLUMN id SET DEFAULT nextval('public.topicos_id_seq'::regclass);


--
-- Data for Name: asignacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asignacion (id_caso_f, fecha_asignacion, id_caso_e, id_ingeniero, id_ingeniero_2, id_ingeniero_3) FROM stdin;
1	2024-08-15	\N	\N	19876543-9	20987654-0
1	2024-08-17	\N	21098765-1	32109876-2	43210987-3
2	2024-07-22	\N	54321098-4	65432109-5	76543210-6
\N	2024-07-25	2	87654321-7	98765432-8	11223344-9
3	2024-06-10	\N	22334455-0	33445566-1	\N
\N	2024-06-11	3	44556677-2	55667788-3	66778899-4
4	2024-05-05	\N	77889900-5	88990011-6	\N
5	2024-08-28	\N	99001122-7	10111213-8	12131415-9
\N	2024-08-30	5	13141516-0	14151617-1	15161718-2
6	2024-07-15	\N	16171819-3	17181920-4	18192021-5
\N	2024-07-18	6	19202122-6	20212223-7	21222324-8
7	2024-06-22	\N	22232425-9	23242526-0	\N
\N	2024-06-23	7	24252627-1	25262728-2	26272829-3
8	2024-04-18	\N	27282930-4	28293031-5	\N
9	2024-08-10	\N	29303132-6	30313233-7	31323334-8
\N	2024-08-12	9	32333435-9	33343536-0	34353637-1
10	2024-07-28	\N	35363738-2	36373839-3	37383940-4
\N	2024-07-31	10	38394041-5	39404142-6	40414243-7
11	2024-06-05	\N	41424344-8	42434445-9	\N
\N	2024-06-06	11	43444546-0	44454647-1	45464748-2
12	2024-03-12	\N	46474849-3	47484950-4	\N
13	2024-08-22	\N	19876543-9	20987654-0	21098765-1
\N	2024-08-24	13	32109876-2	43210987-3	54321098-4
14	2024-07-18	\N	65432109-5	76543210-6	87654321-7
\N	2024-07-21	14	98765432-8	11223344-9	22334455-0
15	2024-05-30	\N	33445566-1	44556677-2	\N
\N	2024-05-31	15	55667788-3	66778899-4	77889900-5
16	2024-02-25	\N	88990011-6	99001122-7	\N
17	2024-08-05	\N	10111213-8	12131415-9	13141516-0
\N	2024-08-07	17	14151617-1	15161718-2	16171819-3
18	2024-07-12	\N	17181920-4	18192021-5	19202122-6
\N	2024-07-15	18	20212223-7	21222324-8	22232425-9
19	2024-05-15	\N	23242526-0	24252627-1	\N
20	2024-01-20	\N	25262728-2	26272829-3	\N
21	2024-08-18	\N	27282930-4	28293031-5	29303132-6
\N	2024-08-20	21	30313233-7	31323334-8	32333435-9
22	2024-07-05	\N	33343536-0	34353637-1	35363738-2
\N	2024-07-08	22	36373839-3	37383940-4	38394041-5
23	2024-04-28	\N	39404142-6	40414243-7	41424344-8
\N	2024-04-30	23	42434445-9	43444546-0	44454647-1
24	2023-12-15	\N	45464748-2	46474849-3	\N
25	2024-08-08	\N	47484950-4	19876543-9	20987654-0
\N	2024-08-10	24	21098765-1	32109876-2	43210987-3
\.


--
-- Data for Name: ingenieros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingenieros (rut, nombre, email, numero_solicitudes_activas, especialidad_1, especialidad_2) FROM stdin;
19876543-9	Andrés Silva López	andres.silva@zeropressure.cl	5	1	2
20987654-0	Camila Martínez Rojas	camila.martinez@zeropressure.cl	8	3	1
21098765-1	Diego González Pérez	diego.gonzalez@zeropressure.cl	3	2	3
32109876-2	Valentina Rodríguez Soto	valentina.rodriguez@zeropressure.cl	12	1	3
43210987-3	Matías Fernández Castro	matias.fernandez@zeropressure.cl	7	2	1
54321098-4	Javiera Vargas Navarro	javiera.vargas@zeropressure.cl	9	3	2
65432109-5	Felipe Herrera Mendoza	felipe.herrera@zeropressure.cl	4	1	2
76543210-6	Isidora Torres Romero	isidora.torres@zeropressure.cl	15	2	3
87654321-7	Benjamín Soto Díaz	benjamin.soto@zeropressure.cl	6	3	1
98765432-8	Antonia Rojas Pérez	antonia.rojas@zeropressure.cl	11	1	3
11223344-9	Tomás Díaz Fuentes	tomas.diaz@zeropressure.cl	2	2	\N
22334455-0	Florencia Rojas Castillo	florencia.rojas@zeropressure.cl	10	3	2
33445566-1	Gabriel Pérez Núñez	gabriel.perez@zeropressure.cl	8	1	3
44556677-2	Constanza López Medina	constanza.lopez@zeropressure.cl	7	2	1
55667788-3	Maximiliano González Reyes	maximiliano.gonzalez@zeropressure.cl	14	3	1
66778899-4	Amanda Silva Ortiz	amanda.silva@zeropressure.cl	5	1	2
77889900-5	Ricardo Martínez Vega	ricardo.martinez@zeropressure.cl	9	2	3
88990011-6	Daniela Rodríguez Herrera	daniela.rodriguez@zeropressure.cl	6	3	2
99001122-7	Nicolás Fernández Castro	nicolas.fernandez@zeropressure.cl	11	1	3
10111213-8	Sofía Vargas Rojas	sofia.vargas@zeropressure.cl	4	2	1
12131415-9	Alexandro Navarro Díaz	alexandro.navarro@zeropressure.cl	13	3	2
13141516-0	Emilia Herrera López	emilia.herrera@zeropressure.cl	7	1	3
14151617-1	Diego Mendoza Torres	diego.mendoza@zeropressure.cl	8	2	\N
15161718-2	Catalina Castro Soto	catalina.castro@zeropressure.cl	5	3	1
16171819-3	Joaquín Torres Romero	joaquin.torres@zeropressure.cl	12	1	2
17181920-4	Antonella Soto Pérez	antonella.soto@zeropressure.cl	6	2	3
18192021-5	Lucas Romero Silva	lucas.romero@zeropressure.cl	9	3	1
19202122-6	Martina Díaz González	martina.diaz@zeropressure.cl	4	1	2
20212223-7	Samuel Rojas Martínez	samuel.rojas@zeropressure.cl	15	2	3
21222324-8	Victoria Pérez Rodríguez	victoria.perez@zeropressure.cl	7	3	2
22232425-9	Matías López Fernández	matias.lopez@zeropressure.cl	10	1	3
23242526-0	Isabella González Vargas	isabella.gonzalez@zeropressure.cl	5	2	1
24252627-1	Benjamín Silva Navarro	benjamin.silva1@zeropressure.cl	8	3	2
25262728-2	Emma Martínez Herrera	emma.martinez@zeropressure.cl	11	1	3
26272829-3	Thiago Rodríguez Mendoza	thiago.rodriguez@zeropressure.cl	6	2	\N
27282930-4	Sofia Fernández Castro	sofia.fernandez@zeropressure.cl	9	3	1
28293031-5	Alonso Vargas Torres	alonso.vargas@zeropressure.cl	4	1	2
29303132-6	Valeria Navarro Soto	valeria.navarro@zeropressure.cl	13	2	3
30313233-7	Dylan Herrera Romero	dylan.herrera@zeropressure.cl	7	3	2
31323334-8	Renata Mendoza Díaz	renata.mendoza@zeropressure.cl	8	1	3
32333435-9	Maximiliano Castro Rojas	maximiliano.castro@zeropressure.cl	5	2	1
33343536-0	Antonella Torres Pérez	antonella.torres@zeropressure.cl	12	3	2
34353637-1	Matías Soto Silva	matias.soto@zeropressure.cl	6	1	3
35363738-2	Emilia Romero González	emilia.romero@zeropressure.cl	9	2	\N
36373839-3	Lucas Díaz Martínez	lucas.diaz@zeropressure.cl	7	3	1
37383940-4	Isidora Rojas Rodríguez	isidora.rojas@zeropressure.cl	14	1	2
38394041-5	Sebastián Pérez López	sebastian.perez@zeropressure.cl	5	2	3
39404142-6	Florencia González Rojas	florencia.gonzalez@zeropressure.cl	10	3	1
40414243-7	Benjamín Silva Castro	benjamin.silva@zeropressure.cl	8	1	2
41424344-8	Antonia Martínez Díaz	antonia.martinez@zeropressure.cl	6	2	3
42434445-9	Tomás Rodríguez Soto	tomas.rodriguez@zeropressure.cl	11	3	2
43444546-0	Valentina Fernández Mendoza	valentina.fernandez@zeropressure.cl	7	1	3
44454647-1	Matías Vargas Navarro	matias.vargas@zeropressure.cl	9	2	1
45464748-2	Javiera Torres Romero	javiera.torres@zeropressure.cl	4	3	2
46474849-3	Diego Soto Pérez	diego.soto@zeropressure.cl	15	1	3
47484950-4	Camila Rojas López	camila.rojas@zeropressure.cl	6	2	\N
\.


--
-- Data for Name: solicitudes_errores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_errores (id_caso, titulo, descripcion, fecha_publicacion, autor, estado, numero_asignados, fecha_solicitud, topico_id) FROM stdin;
1	Error en autenticación biometrica - falso positivo	El sistema de reconocimiento facial acepta usuarios no autorizados en 5% de los casos	2024-08-15	12345678-9	Abierto	2	2024-08-15 10:30:00	1
2	Crash en dashboard web al cargar gráficos grandes	La aplicación se cierra inesperadamente al visualizar datasets mayores a 10k puntos2024-07-22	23456789-0	En Progreso	3	2024-07-22 15:45:00	3
3	Fuga de memoria en integración APIs pago móvil	Consumo de memoria aumenta 2GB por hora durante transacciones internacionales	2024-06-10	34567890-1	Resuelto	1	2024-06-10 12:15:00	1
4	Notificaciones push no llegan a dispositivos iOS	30% de usuarios iOS no reciben notificaciones desde última actualización	2024-05-05	45678901-2	Cerrado	0	2024-05-05 17:30:00	2
5	Timeout en consultas base de datos bajo carga alta	Las consultas exceden 30 segundos cuando hay más de 500 usuarios concurrentes	2024-08-28	56789012-3	Abierto	2	2024-08-28 11:20:00	1
6	Modo oscuro no persiste después de reinicio app	La configuración de modo oscuro se restablece tras cerrar la aplicación	2024-07-15	67890123-4	En Progreso	3	2024-07-15 14:50:00	3
7	Datos en panel analytics desactualizados por 5 minutos	El dashboard muestra información con retraso inconsistente con lo esperado	2024-06-22	78901234-5	Resuelto	1	2024-06-22 16:15:00	2
8	Chat en vivo desconecta tras 2 minutos de inactividad	La sesión de chat se cierra automáticamente incluso con configuración contraria	2024-04-18	89012345-6	Cerrado	0	2024-04-18 10:35:00	3
9	Geolocalización muestra 100m de error en áreas urbanas	La precisión se reduce drásticamente en ciudades con edificios altos	2024-08-10	90123456-7	Abierto	2	2024-08-10 15:10:00	1
10	Backup cloud falla con archivos mayores a 2GB	Error de timeout durante upload de archivos grandes al sistema de backup	2024-07-28	11223344-8	En Progreso	3	2024-07-28 12:40:00	2
11	Sharing redes sociales no incluye preview imagen	Los links compartidos no muestran thumbnail en Facebook y Twitter	2024-06-05	22334455-9	Resuelto	1	2024-06-05 17:05:00	3
12	Recomendaciones inteligentes sugieren contenido irrelevante	El algoritmo muestra productos/servicios fuera del interés del usuario	2024-03-12	33445566-0	Cerrado	0	2024-03-12 11:20:00	1
13	OCR móvil no reconoce texto en imágenes con baja luz	El reconocimiento falla en fotos tomadas en condiciones de iluminación pobre	2024-08-22	44556677-1	Abierto	2	2024-08-22 14:35:00	2
14	Permisos de admin no se aplican inmediatamente tras cambios	Los cambios de roles tardan hasta 10 minutos en reflejarse en el sistema	2024-07-18	55667788-2	En Progreso	3	2024-07-18 16:00:00	1
15	Sincronización offline crea registros duplicados	Al reconectar el sistema genera entradas duplicadas en 15% de los casos	2024-05-30	66778899-3	Resuelto	1	2024-05-30 10:25:00	3
16	Cupones descuentos aplican doble descuento en carrito	Error en cálculo final cuando múltiples promociones están activas	2024-02-25	77889900-4	Cerrado	0	2024-02-25 15:40:00	2
17	Reconocimiento voz no funciona en ambientes ruidosos	La precisión cae a 40% en lugares con ruido ambiente superior a 60dB	2024-08-05	88990011-5	Abierto	2	2024-08-05 12:55:00	1
18	Métricas rendimiento no incluyen datos de últimos 15min	El dashboard muestra gap en datos recientes durante picos de uso	2024-07-12	99001122-6	En Progreso	3	2024-07-12 17:20:00	2
19	Streaming video calidad 4K consume 1GB por 5min	Consumo de datos excesivo comparado con estándares de industria	2024-05-15	10111213-7	Resuelto	1	2024-05-15 11:45:00	3
20	Facturación electrónica genera PDF con formato corrupto	Los archivos PDF no son legibles en lectores estándar del mercado	2024-01-20	12131415-8	Cerrado	0	2024-01-20 14:10:00	1
21	Widget home screen no se actualiza automáticamente	Requiere reinicio de app para mostrar información actualizada	2024-08-18	13141516-9	Abierto	2	2024-08-18 10:35:00	2
22	Tickets soporte se asignan a agentes no disponibles	El sistema asigna tickets a agentes fuera de su horario laboral	2024-07-05	14151617-0	En Progreso	3	2024-07-05 15:50:00	1
23	Realidad aumentatura no detecta superficies planas	La calibración AR falla en superficies irregulares o con patrones	2024-04-28	15161718-1	Resuelto	1	2024-04-28 12:15:00	3
24	Exportación masiva falla con caracteres especiales	Los archivos CSV/Excel corrompen datos con tildes y caracteres utf-8	2023-12-15	16171819-2	Cerrado	0	2024-12-15 17:30:00	2
25	Autenticación 2FA no envía códigos a números internacionales	Usuarios fuera del país no reciben SMS de verificación	2024-08-08	17181920-3	Abierto	2	2024-08-08 11:55:00	1
26	Backup cloud no verifica integridad de archivos subidos	No hay checksum validation permitiendo corrupción de datos silenciosa	2024-07-10	18192021-4	En Progreso	3	2024-07-10 15:20:00	2
27	Login redes sociales falla tras actualización API	Facebook OAuth devuelve error 400 desde última actualización SDK	2024-05-22	19202122-5	Resuelto	1	2024-05-22 12:45:00	3
28	Control parental permite bypass mediante reinstalación app	Los límites se resetean al desinstalar y reinstalar la aplicación	2024-02-18	20212223-6	Cerrado	0	2024-02-18 10:00:00	1
29	Procesamiento batch duplica tareas en alta concurrencia	El sistema agenda múltiples ejecuciones de misma tarea bajo carga	2024-08-12	21222324-7	Abierto	2	2024-08-12 17:15:00	1
30	Modo conductor no bloquea notificaciones entrantes	Las notificaciones distraen al usuario a pesar del modo conductor activo	2024-07-28	22232425-8	En Progreso	3	2024-07-28 11:40:00	3
31	Recomendaciones contenido muestran items fuera de stock	El algoritmo sugiere productos no disponibles en inventario	2024-06-05	23242526-9	Resuelto	1	2024-06-05 14:05:00	2
32	Escáner seguridad marca archivos PDF legítimos como malware	Falsos positivos en documentos PDF con imágenes embebidas	2024-01-15	24252627-0	Cerrado	0	2024-01-15 16:20:00	2
33	Métricas rendimiento no cargan en navegadores Safari	El dashboard queda en blanco específicamente en versiones Safari 16+	2024-08-22	25262728-1	Abierto	2	2024-08-22 12:55:00	1
34	Geofencing consume 30% batería en segundo plano	El monitoreo continuo de ubicación drena batería rápidamente	2024-07-15	26272829-2	En Progreso	3	2024-07-15 15:10:00	3
35	Colaboración tiempo real pierde cambios cada 10min	Los edits se pierden periódicamente en sesiones largas de colaboración	2024-05-08	27282930-3	Resuelto	1	2024-05-08 10:35:00	1
36	Reconocimiento facial falla con lentes de sol oscuros	No detecta rostros con lentes que cubren más del 50% del área facial	2024-03-22	28293031-4	Cerrado	0	2024-03-22 13:00:00	2
37	Analytics redes sociales no reporta datos de Instagram	La integración con Instagram Graph API devuelve empty response	2024-08-05	29303132-5	Abierto	2	2024-08-05 16:15:00	3
38	SLA escalamiento notifica a agentes fuera de turno	Las alertas de escalamiento llegan a agentes no working hours	2024-07-20	30313233-6	En Progreso	3	2024-07-20 11:30:00	1
39	Modo avión permite transacciones que requieren conexión	Algunas funcionalidades que necesitan internet no se bloquean	2024-04-12	31323334-7	Resuelto	1	2024-04-12 14:45:00	3
40	Cifrado end-to-end rompe search en historial mensajes	No es posible buscar en mensajes antiguos por diseño de encryption	2024-02-08	32333435-8	Cerrado	0	2024-02-08 17:00:00	2
41	Temas personalizados causan lentitud en dispositivos viejos	La UI se vuelve laggy en dispositivos con menos de 4GB RAM	2024-08-18	33343536-9	Abierto	2	2024-08-18 10:15:00	3
42	Pagos recurrentes fallan con tarjetas que expiran pronto	El sistema rechaza tarjetas con menos de 60 días hasta expiración	2024-07-25	34353637-0	En Progreso	3	2024-07-25 15:30:00	1
43	Realidad aumentada sobrecalienta dispositivos en 5min	La temperatura sube rápidamente causando throttling del CPU	2024-06-18	35363738-1	Resuelto	1	2024-06-18 12:45:00	3
44	Backup diferencial no detecta cambios en archivos binarios	Modificaciones en .exe .dll no son capturadas por el algoritmo	2024-01-28	36373839-2	Cerrado	0	2024-01-28 16:10:00	2
45	Widget financiero muestra datos de usuario incorrecto	En multi-user devices muestra información de último usuario activo	2024-08-08	37383940-3	Abierto	2	2024-08-08 13:25:00	1
46	Documentación automática no genera docs para código legacy	El parser falla con sintaxis anterior a ES6 en JavaScript	2024-07-12	38394041-4	En Progreso	3	2024-07-12 18:40:00	2
47	Modo lectura no guarda posición de scroll en documentos largos	Al salir y volver el scroll se resetea al inicio del documento	2024-05-25	39404142-5	Resuelto	1	2024-05-25 11:05:00	3
48	Monitoreo base de datos no alerta sobre deadlocks	Los deadlocks ocurren pero no generan notificaciones al equipo	2024-03-15	40414243-6	Cerrado	0	2024-03-15 14:20:00	1
49	Integración asistentes virtuales no entende acentos	Los comandos de voz con acentos son misinterpretados sistemáticamente	2024-08-28	41424344-7	Abierto	2	2024-08-28 17:35:00	3
50	Gamificación otorga puntos dobles por logros repetidos	Los usuarios pueden farmear puntos explotando bug de recompensas	2024-07-30	42434445-8	En Progreso	3	2024-07-30 10:50:00	2
52	Modo bajo consumo desactiva funcionalidades críticas	Características esenciales como notificaciones emergencia se desactivan	2024-02-12	12345678-9	Cerrado	0	2024-02-12 12:30:00	2
54	Traducción automática cambia significado técnico	Los términos técnicos son traducidos incorrectamente perdiendo precisión	2024-07-08	34567890-1	En Progreso	3	2024-07-08 11:40:00	3
55	Analytics embudos no considera abandoned carts	Las métricas de conversión ignoran carritos abandonados en último paso	2024-05-18	45678901-2	Resuelto	1	2024-05-18 14:55:00	2
56	2FA push notifica desde número genérico no reconocido	Los usuarios ignoran notificaciones por venir de número no familiar	2024-01-05	56789012-3	Cerrado	0	2024-01-05 18:10:00	1
57	Layouts configurables no son responsivos en móviles	Los layouts personalizados se rompen en viewports menores a 768px	2024-08-25	67890123-4	Abierto	2	2024-08-25 13:25:00	3
58	Cache inteligente sirve contenido stale durante updates	Los usuarios ven versiones antiguas hasta 10 minutos tras actualizaciones	2024-07-17	78901234-5	En Progreso	3	2024-07-17 10:40:00	1
59	Modo accesibilidad no anuncia cambios dinámicos en contenido	Los screen readers no detectan actualizaciones AJAX en la página	2024-04-28	89012345-6	Resuelto	1	2024-04-28 15:05:00	3
60	Reporting compliance falla con regulaciones multiregión	El sistema no soporta compliance simultáneo GDPR + CCPA + LGPD	2024-03-08	90123456-7	Cerrado	0	2024-03-08 17:20:00	2
61	Sincronización calendarios crea eventos duplicados	Al editar eventos en app se crean copias en el calendario nativo	2024-08-20	11223344-8	Abierto	2	2024-08-20 12:35:00	1
62	Backup multi-region replica datos sin encryption regional	Los backups en EU contienen datos de usuarios US sin encryption apropiada	2024-07-22	22334455-9	En Progreso	3	2024-07-22 16:50:00	2
63	Prototipado integrado no exporta a formatos industry standard	Los prototypes solo se exportan en formato propietario no compatible	2024-06-12	33445566-0	Resuelto	1	2024-06-12 11:15:00	3
64	Alertas machine learning no son actionables	Las alertas indican problemas pero no sugieren acciones concretas	2024-02-28	44556677-1	Cerrado	0	2024-02-28 14:30:00	1
65	Dashboard financiero no soporta múltiples monedas	Las gráficas se rompen cuando hay transacciones en más de 1 currency	2024-08-30	55667788-2	Abierto	2	2024-08-30 18:05:00	2
66	Dictado por voz inserta puntuación en lugares incorrectos	Los puntos y comas se colocan aleatoriamente en el texto dictado	2024-07-14	66778899-3	En Progreso	3	2024-07-14 10:20:00	3
67	Debugging remoto expone logs de otros usuarios en entornos shared	Los developers ven logs de sesiones de otros usuarios accidentalmente	2024-05-05	77889900-4	Resuelto	1	2024-05-05 13:45:00	1
68	Versionado documentos no maneja merge conflicts adecuadamente	Los conflictos de merge resultan en pérdida de cambios frecuentemente	2024-01-25	88990011-5	Cerrado	0	2024-01-25 16:10:00	2
69	Notificaciones preferencias se restablecen tras update app	Las configuraciones personalizadas vuelven a default tras actualizar	2024-08-10	99001122-6	Abierto	2	2024-08-10 11:35:00	3
70	Load balancing envía tráfico a instancias con high latency	El algoritmo no considera latency geográfica en el routing	2024-07-05	10111213-7	En Progreso	3	2024-07-05 15:50:00	1
71	Modo concentración no silencia notificaciones de sistema	Las notificaciones del OS (iOS/Android) aún interrumpen el modo	2024-04-15	12131415-8	Resuelto	1	2024-04-15 18:15:00	3
72	Magic links son marcados como spam por filtros email	El 40% de los emails de login terminan en carpeta spam	2024-03-05	13141516-9	Cerrado	0	2024-03-05 12:40:00	2
73	Integración project management sincroniza cada 24h solo	La sincronización no es en tiempo real como se anuncia	2024-08-28	14151617-0	Abierto	2	2024-08-28 14:55:00	1
74	Recomendación AI sugiere contenido ya consumido	El algoritmo recomienda repetidamente items que el usuario ya vio	2024-07-19	15161718-1	En Progreso	3	2024-07-19 10:10:00	2
75	Moderación automática bloquea contenido educativo legítimo	Los filtros marcan como inapropiado contenido educativo sobre salud	2024-06-08	16171819-2	Resuelto	1	2024-06-08 15:25:00	3
76	Backup incremental no puede restaurar versiones específicas	Solo permite restore a última versión no a puntos intermedios	2024-02-15	17181920-3	Cerrado	0	2024-02-15 17:40:00	1
77	Widget meteorología muestra datos de ubicación incorrecta	Usa IP geolocation en vez de GPS mostrando datos de ciudad equivocada	2024-08-15	18192021-4	Abierto	2	2024-08-15 12:05:00	2
78	Búsqueda inteligente no encuentra synonyms términos técnicos	La búsqueda no reconoce DB como sinónimo de base de datos	2024-07-24	19202122-5	En Progreso	3	2024-07-24 16:20:00	3
79	Modo viaje sugiere rutas con peajes sin opción avoid	Las rutas no consideran preferencia usuario sobre peajes	2024-05-12	20212223-6	Resuelto	1	2024-05-12 12:45:00	1
80	Monitoreo seguridad no detecta brute force attacks	Intentos de login fallidos repetidos no generan alertas	2024-01-18	21222324-7	Cerrado	0	2024-01-18 15:10:00	2
81	Feeds algoritmos ajustables favorecen contenido polarizante	Los algoritmos aumentan engagement pero disminuyen calidad contenido	2024-08-22	22232425-8	Abierto	2	2024-08-22 18:35:00	3
82	Pagos cross-border usan汇率 obsoletas	Las conversiones de currency usan rates con hasta 24h de retraso	2024-07-11	23242526-9	En Progreso	3	2024-07-11 11:00:00	1
83	Realidad aumentada navegación indoor no funciona en sótanos	El GPS indoor no funciona en niveles subterráneos de edificios	2024-04-22	24252627-0	Resuelto	1	2024-04-22 14:25:00	3
84	Backup encryption no permite recover si usuario pierde phone	No hay mecanismo de recovery para llaves almacenadas solo en device	2024-03-12	25262728-1	Cerrado	0	2024-03-12 17:50:00	2
85	Integración wearables no sincroniza datos históricos	Solo datos nuevos se sync el historial previo no está disponible	2024-08-05	26272829-2	Abierto	2	2024-08-05 13:15:00	1
86	Analytics rendimiento equipo expone salaries accidentalmente	Los reportes de performance incluyen campos de HR con información sensible	2024-07-28	27282930-3	En Progreso	3	2024-07-28 16:40:00	2
87	Modo lectura inmersiva no permite tomar notas	Los usuarios no pueden resaltar o comentar texto en este modo	2024-06-15	28293031-4	Resuelto	1	2024-06-15 12:05:00	3
88	Detección patrones uso bloquea usuarios por travel legitimo	Los viajes internacionales son marcados como suspicious activity	2024-02-22	29303132-5	Cerrado	0	2024-02-22 15:30:00	1
89	Avatares personalizables no se renderizan correctamente en VR	Los avatares aparecen distorsionados en entornos de realidad virtual	2024-08-18	30313233-6	Abierto	2	2024-08-18 18:55:00	3
90	Cache distribuido causa consistencia eventual con 5min delay	Los usuarios ven datos stale por hasta 5 minutos en alta carga	2024-07-07	31323334-7	En Progreso	3	2024-07-07 11:20:00	1
91	Controles accesibilidad no son discoverable	Los usuarios con movilidad reducida no encuentran las opciones de accesibilidad	2024-05-28	32333435-8	Resuelto	1	2024-05-28 14:45:00	3
92	Reporting ejecutivos usa jerga técnica incomprensible	Los reportes contienen términos técnicos no adecuados para audiencia ejecutiva	2024-01-08	33343536-9	Cerrado	0	2024-01-08 17:10:00	2
93	Integración smart home no soporta dispositivos Zigbee	Solo funciona con WiFi devices excluyendo protocolos populares como Zigbee	2024-08-25	34353637-0	Abierto	2	2024-08-25 12:35:00	1
94	Backup retención configurable permite settings contradictorios	Los usuarios pueden setear retención longer que retention policy org	2024-07-16	35363738-1	En Progreso	3	2024-07-16 16:00:00	2
95	Edición video básica reduce calidad a 720p incluso en original	Los videos editados se exportan a menor resolución que la original	2024-04-18	36373839-2	Resuelto	1	2024-04-18 10:25:00	3
96	Alertas mercado no son personalizables por instrumento	Los usuarios reciben alertas de todos los instrumentos no solo los seguidos	2024-03-28	37383940-3	Cerrado	0	2024-03-28 13:50:00	1
97	Shortcuts gestos interfieren con navegación nativa del OS	Los gestos personalizados conflictuan con system gestures del dispositivo	2024-08-12	38394041-4	Abierto	2	2024-08-12 17:15:00	2
98	Monitoreo QoS no considera network latency en métricas	Las métricas de calidad ignoran latency focusing solo en uptime	2024-07-21	39404142-5	En Progreso	3	2024-07-21 11:40:00	1
99	Modo privacidad desactiva funcionalidades de accessibility	Las features de accesibilidad dejan de funcionar en modo máxima privacidad	2024-06-02	40414243-6	Resuelto	1	2024-06-02 15:05:00	3
100	Backup local no verifica espacio disponible previamente	El backup falla silenciosamente cuando el disco destino está lleno	2024-02-05	41424344-7	Cerrado	0	2024-02-05 18:30:00	2
100	Backup local no verifica espacio disponible previamente	El backup falla silenciosamente cuando el disco destino está lleno	2024-02-05	41424344-7	Cerrado	0	2024-02-05 18:30:00	2
101	Error de autenticación OAuth móvil	El sistema rechaza tokens válidos en login móvil	2015-02-15	12345678-9	Abierto	1	2015-02-15 08:05:00	2
102	Desincronización de datos en dispositivos offline	Los cambios realizados offline no se sincronizan correctamente	2016-03-21	23456789-0	Cerrado	0	2016-03-21 11:10:00	1
103	Crash app al recibir push notification	App se cierra al recibir notificación en segundo plano	2017-04-18	34567890-1	En Progreso	2	2017-04-18 12:20:00	3
104	Problemas de encoding en exportación CSV	Los acentos y eñes no se ven correctamente en archivos exportados	2018-05-25	45678901-2	Resuelto	1	2018-05-25 13:30:00	2
105	Timeout en descarga de archivos grandes	Descargar archivos de más de 100MB falla por timeout	2019-06-30	56789012-3	Abierto	2	2019-06-30 14:40:00	1
106	Error 500 en API de productos	La API devuelve error interno al consultar productos agotados	2020-07-12	67890123-4	Cerrado	0	2020-07-12 15:50:00	3
107	No se guardan preferencias de usuario	Las configuraciones personalizadas se pierden al cerrar sesión	2021-08-19	78901234-5	En Progreso	3	2021-08-19 16:00:00	2
108	Integración de pagos rechaza tarjetas válidas	Transacciones legítimas son rechazadas por el gateway	2022-09-24	89012345-6	Resuelto	1	2022-09-24 17:10:00	1
109	Error de validación múltiple en formularios	El formulario muestra varios mensajes de error simultáneamente	2023-10-30	90123456-7	Cerrado	0	2023-10-30 18:20:00	3
110	Crash al abrir perfil usuario sin foto	La app se cierra si el usuario no tiene imagen de perfil	2024-11-14	11223344-8	Abierto	2	2024-11-14 19:30:00	2
111	Fallo en recordatorio de eventos calendar	El sistema no envía notificaciones de eventos programados	2015-01-16	22334455-9	Resuelto	1	2015-01-16 07:15:00	1
112	Error en login social con Google	No se puede iniciar sesión mediante cuenta de Google	2016-02-17	33445566-0	Cerrado	0	2016-02-17 08:22:00	3
113	No se actualizan los gráficos en tiempo real	Los dashboards muestran datos antiguos tras actualización	2017-03-18	44556677-1	En Progreso	2	2017-03-18 09:29:00	2
114	Problemas con la exportación masiva PDF	Exportar más de 50 documentos simultáneos falla	2018-04-19	55667788-2	Abierto	3	2018-04-19 10:36:00	1
115	Desbordamiento de memoria en módulo de búsqueda	La memoria consumida crece sin límite al buscar texto	2019-05-20	66778899-3	Resuelto	1	2019-05-20 11:43:00	3
116	No se puede restablecer contraseña por email	El enlace de recuperación nunca llega al correo	2020-06-21	77889900-4	Cerrado	0	2020-06-21 12:50:00	2
117	Error en módulo de notificaciones push	Algunos usuarios no reciben notificaciones en Android	2021-07-22	88990011-5	En Progreso	2	2021-07-22 13:57:00	1
118	El chat en vivo pierde mensajes en reconexión	Los mensajes enviados justo al reconectar la app se pierden	2022-08-23	99001122-6	Resuelto	1	2022-08-23 15:04:00	3
119	Fallo en la carga de imágenes en galería	Las imágenes no se muestran tras subirlas a la galería	2023-09-24	10111213-8	Cerrado	0	2023-09-24 16:11:00	2
120	No se puede eliminar cuenta de usuario	El botón de eliminar cuenta no funciona en la web	2024-10-25	12131415-9	Abierto	3	2024-10-25 17:18:00	1
121	Error en envío masivo de emails	Los correos programados no se envían a todos los destinatarios	2015-11-01	13141516-0	Resuelto	1	2015-11-01 18:25:00	3
122	App móvil muestra pantalla en blanco tras login	La app no carga datos tras autenticación	2016-12-02	14151617-1	Cerrado	0	2016-12-02 19:32:00	2
123	Desincronización entre stock físico y virtual	El inventario online no refleja el real en tienda	2017-01-03	15161718-2	En Progreso	2	2017-01-03 20:39:00	1
124	Pérdida de sesión al cambiar de red	La aplicación cierra sesión al cambiar de WiFi a datos móviles	2018-02-04	16171819-3	Abierto	3	2018-02-04 21:46:00	3
125	Fallo en la actualización automática de precios	Los precios no se actualizan en tiempo real en la app	2019-03-05	17181920-4	Resuelto	1	2019-03-05 22:53:00	2
126	Error en la integración con Facebook OAuth	No se pueden vincular cuentas con Facebook	2020-04-06	18192021-5	Cerrado	0	2020-04-06 23:00:00	1
127	Módulo de ayuda no carga contenido	La sección de ayuda aparece vacía al abrirla	2021-05-07	19202122-6	En Progreso	2	2021-05-07 08:07:00	3
128	Fallo en la validación de RUT chileno	Se aceptan RUT inválidos al registrar usuarios	2022-06-08	20212223-7	Resuelto	1	2022-06-08 09:14:00	2
129	Crash al intentar exportar contactos	La app se cierra al exportar más de 100 contactos	2023-07-09	21222324-8	Cerrado	0	2023-07-09 10:21:00	1
130	No se muestran los descuentos en carrito	El sistema no aplica promociones correctamente	2024-08-10	22232425-9	Abierto	3	2024-08-10 11:28:00	3
131	Problemas de latencia en streaming	El video se pausa cada pocos segundos	2015-09-15	23242526-0	Resuelto	1	2015-09-15 12:35:00	2
132	Búsqueda avanzada no filtra correctamente	Los resultados no corresponden a los filtros seleccionados	2016-10-16	24252627-1	Cerrado	0	2016-10-16 13:42:00	1
133	No se puede adjuntar archivos en soporte	El botón de adjuntar no responde en la página de soporte	2017-11-17	25262728-2	En Progreso	2	2017-11-17 14:49:00	3
134	Problemas al generar reportes PDF	Los reportes generados están vacíos	2018-12-18	26272829-3	Abierto	3	2018-12-18 15:56:00	2
135	Error de checksum en descargas	Archivos descargados aparecen corruptos	2019-01-19	27282930-4	Resuelto	1	2019-01-19 17:03:00	1
136	El sistema no permite registrar nuevos usuarios	El registro queda congelado en el último paso	2020-02-20	28293031-5	Cerrado	0	2020-02-20 18:10:00	3
137	Botón de compartir no funciona en iOS	No se comparten links desde la app en iPhone	2021-03-21	29303132-6	En Progreso	2	2021-03-21 19:17:00	2
138	Notificaciones duplicadas por cada evento	Se reciben dos notificaciones por cada acción del usuario	2022-04-22	30313233-7	Resuelto	1	2022-04-22 20:24:00	1
139	Módulo de calendario no sincroniza con Google	Los eventos creados no aparecen en Google Calendar	2023-05-23	31323334-8	Cerrado	0	2023-05-23 21:31:00	3
140	Error en la visualización de mapas	Los mapas no cargan las ubicaciones correctas	2024-06-24	32333435-9	Abierto	3	2024-06-24 22:38:00	2
141	Fallo en el guardado de configuraciones	Los cambios no se persisten en la base de datos	2015-03-02	33343536-0	Resuelto	1	2015-03-02 06:10:00	1
142	Error de permisos en módulo administrativo	Usuarios sin permisos acceden a configuraciones	2016-04-07	34353637-1	Cerrado	0	2016-04-07 07:19:00	3
143	No se actualizan las métricas de ventas	Las cifras de ventas no se refrescan automáticamente	2017-05-12	35363738-2	En Progreso	2	2017-05-12 08:28:00	2
144	Fallo en la subida de documentos PDF	Los archivos no aparecen en el historial	2018-06-17	36373839-3	Abierto	3	2018-06-17 09:37:00	1
145	Crash de la app en modo oscuro	Cambiar a modo oscuro cierra la aplicación	2019-07-22	37383940-4	Resuelto	1	2019-07-22 10:46:00	3
146	Error en la carga de historial de pedidos	No aparecen los pedidos anteriores en la vista	2020-08-27	38394041-5	Cerrado	0	2020-08-27 11:55:00	2
147	Botón de logout no responde en Android	No se puede cerrar sesión en algunos dispositivos	2021-09-02	39404142-6	En Progreso	2	2021-09-02 13:04:00	1
148	Problemas de compatibilidad con navegadores antiguos	El sitio no carga en IE11	2022-10-07	40414243-7	Resuelto	1	2022-10-07 14:13:00	3
149	Fallo al cargar avatar de usuario	La imagen de perfil no se muestra en el header	2023-11-12	41424344-8	Cerrado	0	2023-11-12 15:22:00	2
150	No se puede cambiar la contraseña desde la app	La opción de cambio de contraseña no guarda los cambios	2024-12-17	12345678-9	Abierto	3	2024-12-17 16:31:00	1
151	Error en envío de SMS de verificación	Los códigos SMS no llegan a usuarios internacionales	2015-01-12	13141516-1	Abierto	2	2015-01-12 08:15:00	1
152	Crash al buscar productos sin stock	La app se cierra si el stock es cero	2016-02-13	14151617-2	Cerrado	0	2016-02-13 09:28:00	2
153	No se puede actualizar email de usuario	El sistema rechaza emails válidos	2017-03-14	15161718-3	En Progreso	1	2017-03-14 10:42:00	3
154	Problemas de visualización en modo horizontal	La UI se desordena al rotar el dispositivo	2018-04-15	16171819-4	Resuelto	2	2018-04-15 11:54:00	1
155	Error de permisos en módulo de reportes	Usuarios básicos pueden acceder a reportes avanzados	2019-05-16	17181920-5	Cerrado	0	2019-05-16 13:06:00	2
156	Fallo en la integración con SII	No se pueden timbrar facturas electrónicas	2020-06-17	18192021-6	En Progreso	3	2020-06-17 14:18:00	3
157	No se guardan cambios en perfil de usuario	Los cambios se pierden al refrescar la página	2021-07-18	19202122-7	Abierto	1	2021-07-18 15:31:00	1
158	Error en la generación de QR pagos	Los códigos QR no son válidos para lectura	2022-08-19	20212223-8	Resuelto	2	2022-08-19 16:43:00	2
159	Crash al filtrar por fecha en reportes	La app se cierra al seleccionar un rango de fechas	2023-09-20	21222324-9	Cerrado	0	2023-09-20 17:55:00	3
160	Problemas de compatibilidad con iOS 14	La app no inicia en versiones antiguas de iOS	2024-10-21	22232425-0	En Progreso	3	2024-10-21 18:08:00	1
161	Fallo en cálculo de impuestos en carrito	El IVA no se suma correctamente al total	2015-02-22	23242526-1	Resuelto	1	2015-02-22 19:20:00	2
162	Error de autenticación con biometría	La huella digital no es reconocida en algunos dispositivos	2016-03-23	24252627-2	Cerrado	0	2016-03-23 20:32:00	3
163	No se puede agregar dirección nueva	El formulario de dirección muestra error sin detalles	2017-04-24	25262728-3	En Progreso	2	2017-04-24 21:44:00	1
164	Problemas al eliminar productos del carrito	Los productos eliminados siguen apareciendo	2018-05-25	26272829-4	Abierto	3	2018-05-25 22:57:00	2
165	Error en actualización automática de app	La app no se actualiza en segundo plano	2019-06-26	27282930-5	Resuelto	1	2019-06-26 07:09:00	3
166	Fallo en la carga de banners promocionales	Los banners no se muestran en la página principal	2020-07-27	28293031-6	Cerrado	0	2020-07-27 08:21:00	1
167	No se pueden aplicar cupones de descuento	Los cupones válidos son rechazados	2021-08-28	29303132-7	En Progreso	2	2021-08-28 09:33:00	2
168	Error en la generación de recibos PDF	Los recibos no incluyen todos los productos	2022-09-29	30313233-8	Abierto	3	2022-09-29 10:45:00	3
169	Crash al editar perfil con foto grande	La app se cierra si la foto supera 5MB	2023-10-30	31323334-9	Resuelto	1	2023-10-30 11:57:00	1
170	Fallo al mostrar historial de compras	El historial aparece vacío aunque hay compras	2024-11-01	32333435-0	Cerrado	0	2024-11-01 13:09:00	2
171	Error en envío de notificaciones programadas	Las notificaciones llegan en horarios incorrectos	2015-03-12	33343536-1	En Progreso	2	2015-03-12 14:21:00	3
172	No se pueden marcar mensajes como leídos	El sistema no actualiza el estado de los mensajes	2016-04-13	34353637-2	Abierto	1	2016-04-13 15:33:00	1
173	Problemas de visualización en modo oscuro	Algunos textos se ven ilegibles	2017-05-14	35363738-3	Resuelto	2	2017-05-14 16:45:00	2
174	Error de permisos en módulo de usuarios	Admins no pueden eliminar cuentas	2018-06-15	36373839-4	Cerrado	0	2018-06-15 17:57:00	3
175	Fallo en la integración con API externa	La API responde con error 404	2019-07-16	37383940-5	En Progreso	3	2019-07-16 19:09:00	1
176	No se guardan cambios al editar dirección	Al guardar cambios se pierden los datos	2020-08-17	38394041-6	Abierto	1	2020-08-17 20:21:00	2
177	Error en la exportación de datos Excel	El archivo descargado está vacío	2021-09-18	39404142-7	Resuelto	2	2021-09-18 21:33:00	3
178	Crash al abrir el chat grupal	La aplicación se cierra al ingresar a grupos grandes	2022-10-19	40414243-8	Cerrado	0	2022-10-19 22:45:00	1
179	No se puede cambiar foto de perfil	El sistema rechaza todos los formatos de imagen	2023-11-20	41424344-9	En Progreso	3	2023-11-20 23:57:00	2
180	Error al aplicar filtros en búsqueda avanzada	No se aplican los filtros seleccionados	2024-12-21	12345678-0	Abierto	1	2024-12-21 08:09:00	3
181	Error de conexión con servidor de base de datos	La app muestra error de conexión cada cierto tiempo	2015-04-22	23456789-1	Resuelto	2	2015-04-22 09:21:00	1
182	No se pueden eliminar mensajes antiguos	El sistema muestra error desconocido	2016-05-23	34567890-2	Cerrado	0	2016-05-23 10:33:00	2
183	Problemas con notificaciones de eventos	Las notificaciones no llegan a todos los usuarios	2017-06-24	45678901-3	En Progreso	1	2017-06-24 11:45:00	3
184	Fallo en la descarga de archivos adjuntos	Los archivos descargados aparecen corruptos	2018-07-25	56789012-4	Abierto	2	2018-07-25 12:57:00	1
185	Error de validación en formulario de registro	Se permiten contraseñas demasiado cortas	2019-08-26	67890123-5	Resuelto	3	2019-08-26 14:09:00	2
186	No se muestran los métodos de pago disponibles	El sistema no carga los métodos de pago	2020-09-27	78901234-6	Cerrado	0	2020-09-27 15:21:00	3
187	Crash al intentar abrir notificaciones antiguas	La app se cierra con notificaciones del año anterior	2021-10-28	89012345-7	En Progreso	1	2021-10-28 16:33:00	1
188	Error de cálculo en cuotas de pago	Las cuotas no suman el total correcto	2022-11-29	90123456-8	Abierto	2	2022-11-29 17:45:00	2
189	Fallo en la actualización de la foto de portada	No se guarda la nueva imagen de portada	2023-12-30	11223344-0	Resuelto	3	2023-12-30 18:57:00	3
190	Error en la generación de códigos promocionales	Los códigos generados no funcionan	2024-01-01	22334455-1	Cerrado	0	2024-01-01 20:09:00	1
191	No se pueden agregar productos al carrito	El botón de agregar no responde	2015-05-12	33445566-2	En Progreso	1	2015-05-12 21:21:00	2
192	Problemas de carga en la sección de noticias	Las noticias no cargan correctamente	2016-06-13	44556677-3	Abierto	2	2016-06-13 22:33:00	3
193	Fallo de autenticación en doble factor	El segundo factor de autenticación falla	2017-07-14	55667788-4	Resuelto	3	2017-07-14 23:45:00	1
194	Error al guardar configuración de privacidad	Los cambios no se guardan correctamente	2018-08-15	66778899-5	Cerrado	0	2018-08-15 08:57:00	2
195	No se muestran los pagos realizados	La sección de pagos aparece vacía	2019-09-16	77889900-6	En Progreso	1	2019-09-16 10:09:00	3
196	Fallo en la integración con MercadoPago	No se pueden realizar pagos online	2020-10-17	88990011-7	Abierto	2	2020-10-17 11:21:00	1
197	Error en la carga de productos destacados	Los productos destacados no aparecen en el home	2021-11-18	99001122-8	Resuelto	3	2021-11-18 12:33:00	2
198	No se pueden eliminar tarjetas guardadas	El sistema rechaza la eliminación de tarjetas	2022-12-19	10111213-9	Cerrado	0	2022-12-19 13:45:00	3
199	Error al enviar archivos grandes por chat	Archivos superiores a 50MB fallan al enviar	2023-01-20	12131415-0	En Progreso	1	2023-01-20 14:57:00	1
200	Fallo en la visualización de productos relacionados	No se muestran los productos sugeridos	2024-02-21	13141516-1	Abierto	2	2024-02-21 16:09:00	2
\.


--
-- Data for Name: solicitudes_funcionalidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudes_funcionalidad (id_caso, titulo, ambiente_desarrollo, resumen, criterios_aceptacion, estado, solicitante, numero_asignados, fecha_solicitud, topico_id) FROM stdin;
1	1	Implementación de autenticación biometrica en app móvil	Movil	Sistema de login mediante huella dactilar y reconocimiento facial para mayor seguridad	1. Usuario debe poder registrar huella; 2. Reconocimiento facial con 99% precisión; 3. Tiempo respuesta <2 segundos	Abierto	12345678-9	2	2024-08-15 09:30:00	1
2	Rediseño completo de interfaz dashboard web	Web	Nueva interfaz moderna con mejor experiencia de usuario y accesibilidad	1. Compatibilidad con lectores de pantalla; 2. Tiempo carga <3 segundos; 3. Feedback visual inmediato acciones	En Progreso	23456789-0	3	2024-07-22 14:15:00	3
3	Integración con APIs de pago móvil internacional	Movil	Conectar con sistemas de pago globales para expansión internacional	1. Soporte para 5 monedas diferentes; 2. Conversión automática tasas; 3. Certificación PCI DSS	Resuelto	34567890-1	1	2024-06-10 11:45:00	1
4	Sistema de notificaciones push personalizables	Movil	Notificaciones inteligentes basadas en comportamiento usuario	1. Segmentación por intereses; 2. Horarios optimizados; 3. Tasas apertura >25%	Cerrado	45678901-2	0	2024-05-05 16:20:00	2
5	Optimización rendimiento base de datos backend	Web	Mejora tiempos respuesta consultas y procesos batch	1. Reducción 50% tiempo consultas; 2. Soporte 1000 conexiones simultaneas; 3. Backup automático diario	Abierto	56789012-3	2	2024-08-28 10:00:00	1
6	Implementación dark mode en aplicación móvil	Movil	Modo oscuro para reducir fatiga visual y ahorro batería	1. Activación automática crepuscular; 2. Persistencia configuración; 3. Contraste accesibilidad AA	En Progreso	67890123-4	3	2024-07-15 13:30:00	3
7	Sistema de reportes analytics tiempo real	Web	Panel de analytics con datos en tiempo real para toma decisiones	1. Actualización cada 30 segundos; 2. Exportación PDF/Excel; 3. 20 métricas diferentes	Resuelto	78901234-5	1	2024-06-22 15:45:00	2
8	Funcionalidad chat en vivo soporte técnico	Web	Chat integrado para atención al cliente inmediata	1. Tiempo respuesta <1 minuto; 2. Historial conversaciones; 3. Transferencia entre agentes	Cerrado	89012345-6	0	2024-04-18 09:15:00	3
9	Geolocalización para entregas en tiempo real	Movil	Seguimiento preciso de entregas con mapas integrados	1. Precisión 10 metros; 2. Notificaciones ETA; 3. Optimización rutas	Abierto	90123456-7	2	2024-08-10 14:00:00	1
10	Sistema de backup cloud automático	Web	Backup automático en nube con cifrado end-to-end	1. Cifrado AES-256; 2. Programación flexible; 3. Restauración 1 clic	En Progreso	11223344-8	3	2024-07-28 11:30:00	2
11	Integración redes sociales sharing	Movil	Compartir contenido en redes sociales directamente desde app	1. Soporte 5 redes sociales; 2. Analytics shares; 3. Deep linking	Resuelto	22334455-9	1	2024-06-05 16:45:00	3
12	Sistema de recomendaciones inteligentes	Web	Algoritmo recomendaciones basado machine learning	1. Precisión >80%; 2. Personalización usuario; 3. Actualización diaria	Cerrado	33445566-0	0	2024-03-12 10:20:00	1
13	Escaneo documentos con OCR móvil	Movil	Digitalización documentos mediante cámara con OCR	1. Soporte 10 idiomas; 2. Precisión 95%; 3. Exportación PDF	Abierto	44556677-1	2	2024-08-22 13:15:00	2
14	Panel administración roles permisos	Web	Sistema granular de permisos para diferentes tipos usuario	1. 5 niveles acceso; 2. Auditoría cambios; 3. Interface intuitiva	En Progreso	55667788-2	3	2024-07-18 15:30:00	1
15	Sincronización offline datos móvil	Movil	Funcionalidad offline con sync automático reconexión	1. Datos persistentes 7 días; 2. Sync conflic resolution; 3. Indicador estado	Resuelto	66778899-3	1	2024-05-30 09:45:00	3
16	Sistema de cupones descuentos inteligentes	Web	Cupones personalizados basados comportamiento compra	1. Generación automática; 2. Redención fácil; 3. Analytics efectividad	Cerrado	77889900-4	0	2024-02-25 14:10:00	2
17	Reconocimiento voz comandos app móvil	Movil	Control por voz para hands-free operation	1. Soporte 3 idiomas; 2. Precisión 92%; 3. Comandos personalizables	Abierto	88990011-5	2	2024-08-05 11:00:00	1
18	Dashboard métricas rendimiento sistema	Web	Monitoreo completo health check sistema	1. 15 métricas técnicas; 2. Alertas automáticas; 3. Historial tendencias	En Progreso	99001122-6	3	2024-07-12 16:20:00	2
19	Streaming video calidad adaptativa	Movil	Video streaming que adapta calidad según conexión	1. 4 calidades diferentes; 2. Buffer inteligente; 3. Estadísticas consumo	Resuelto	10111213-7	1	2024-05-15 10:35:00	3
20	Sistema de facturación electrónica automática	Web	Generación automática facturas electrónicas SII	1. Validación SII; 2. Envío automático; 3. Historial 5 años	Cerrado	12131415-8	0	2024-01-20 13:50:00	1
21	Widget home screen para Android	Movil	Widget con información resumida app en home screen	1. Actualización automática; 2. 3 tamaños diferentes; 3. Interacción directa	Abierto	13141516-9	2	2024-08-18 09:05:00	2
22	Sistema de tickets soporte priorizado	Web	Gestión tickets con prioridades y escalamiento automático	1. 4 niveles prioridad; 2. Routing inteligente; 3. SLA tracking	En Progreso	14151617-0	3	2024-07-05 14:20:00	1
23	Realidad aumentada para visualización productos	Movil	Visualización productos 3D en entorno real mediante AR	1. Escala precisa; 2. 20 productos iniciales; 3. Screenshot sharing	Resuelto	15161718-1	1	2024-04-28 11:45:00	3
24	Exportación masiva datos reports	Web	Exportación datasets completos formatos varios	1. Soporte CSV JSON XML; 2. Límite 100k registros; 3. Compresión automática	Cerrado	16171819-2	0	2024-12-15 16:10:00	2
25	Autenticación 2FA para seguridad reforzada	Web	Two-factor authentication mediante SMS y authenticator app	1. Múltiples métodos; 2. Códigos backup; 3. Recuperación cuenta	Abierto	17181920-3	2	2024-08-08 10:25:00	1
26	Verificación integridad backups cloud	Web	Sistema checksum y verificación automática backups	1. Verificación diaria; 2. Alertas corrupción; 3. Reportes mensuales	En Progreso	18192021-4	3	2024-07-10 14:40:00	2
27	Login social redes sociales	Web	Autenticación mediante Facebook Google Apple	1. 3 providers mínimo; 2. Sync datos básicos; 3. Unlink accounts	Resuelto	19202122-5	1	2024-05-22 11:05:00	3
28	Control parental para contenido app	Movil	Límites y controles para usuarios menores edad	1. Límites tiempo; 2. Filtro contenido; 3. Reportes actividad	Cerrado	20212223-6	0	2024-02-18 09:30:00	1
29	Procesamiento batch para operaciones masivas	Web	Ejecución tareas programadas fuera horario peak	1. Scheduling flexible; 2. Monitoring ejecución; 3. Retry automático	Abierto	21222324-7	2	2024-08-12 16:45:00	1
30	Modo conductor para app móvil	Movil	Interfaz simplificada para uso seguro mientras conduce	1. Activación automática; 2. Comandos voz; 3. Minimizar distracciones	En Progreso	22232425-8	3	2024-07-28 10:20:00	3
31	Integración inventario en tiempo real	Web	Sincronización constante stock entre online y físico	1. Actualización <1 minuto; 2. Alertas stock bajo; 3. Historial movimientos	Resuelto	23242526-9	1	2024-06-05 13:35:00	2
32	Escáner seguridad archivos upload	Web	Antivirus y análisis malware archivos subidos	1. 5 motores escaneo; 2. Cuarentena automática; 3. Logs detallados	Cerrado	24252627-0	0	2024-01-15 15:50:00	2
33	Dashboard responsive para móviles	Movil	Versión móvil completa de dashboard administrativo	1. Compatibilidad iOS Android; 2. Funcionalidad completa; 3. Performance optimizada	Abierto	25262728-1	2	2024-08-22 11:25:00	1
34	Geofencing para notificaciones contextuales	Movil	Notificaciones basadas ubicación geográfica usuario	1. Radio configurable; 2. Trigger entrada/salida; 3. Bajo consumo batería	En Progreso	26272829-2	3	2024-07-15 14:40:00	3
35	Colaboración tiempo real documentos	Web	Edición simultánea documentos múltiples usuarios	1. Cursor presencia; 2. Historial cambios; 3. Conflict resolution	Resuelto	27282930-3	1	2024-05-08 09:05:00	1
36	Reconocimiento facial para verificación identidad	Movil	Verificación identidad mediante selfie y documento	1. Matching 98% precisión; 2. Anti-spoofing; 3. Auditoría completa	Cerrado	28293031-4	0	2024-03-22 12:20:00	2
37	Analytics redes sociales integrado	Web	Dashboard analytics para múltiples redes sociales	1. 4 plataformas soportadas; 2. Métricas engagement; 3. Reportes comparativos	Abierto	29303132-5	2	2024-08-05 15:45:00	3
38	Sistema escalamiento automático tickets	Web	Escalamiento tickets basado en SLA y prioridad	1. Reglas configurables; 2. Notificaciones; 3. Escalamiento múltiples niveles	En Progreso	30313233-6	3	2024-07-20 10:00:00	1
39	Modo avión funcionalidad limitada	Movil	Funcionalidad básica disponible sin conexión internet	1. Datos esenciales offline; 2. Sync automático reconexión; 3. Indicador claro	Resuelto	31323334-7	1	2024-04-12 13:25:00	3
40	Cifrado end-to-end mensajería	Movil	Mensajes cifrados punto a punto para máxima privacidad	1. Perfect forward secrecy; 2. Verificación identidad; 3. Auto-destrucción mensajes	Cerrado	32333435-8	0	2024-02-08 16:40:00	2
41	Temas personalizables interfaz usuario	Web	Personalización colores y estilos interface	1. 10 temas predefinidos; 2. Editor personalizado; 3. Persistencia configuración	Abierto	33343536-9	2	2024-08-18 09:15:00	3
42	Pagos recurrentes suscripciones	Web	Sistema gestión pagos automáticos recurrentes	1. Multiple payment methods; 2. Notificaciones renovación; 3. Upgrades/downgrades	En Progreso	34353637-0	3	2024-07-25 14:30:00	1
43	Realidad aumentada para manuales instrucciones	Movil	Visualización instrucciones 3D sobre productos reales	1. Reconocimiento objetos; 2. Animaciones paso a paso; 3. Soporte múltiples productos	Resuelto	35363738-1	1	2024-06-18 11:45:00	3
44	Backup diferencial para ahorro espacio	Web	Backup solo cambios desde última versión	1. 70% ahorro espacio; 2. Restore completo; 3. Verificación integridad	Cerrado	36373839-2	0	2024-01-28 15:10:00	2
45	Widget financiero home screen	Movil	Widget con resumen financiero rápido acceso	1. Datos sensibles protegidos; 2. Actualización automática; 3. Múltiples cuentas	Abierto	37383940-3	2	2024-08-08 12:05:00	1
46	Documentación automática código	Web	Generación automática documentación desde código fuente	1. Soporte múltiples lenguajes; 2. Documentación actualizada; 3. Búsqueda integrada	En Progreso	38394041-4	3	2024-07-12 17:20:00	2
47	Modo lectura distracción reducida	Web	Interfaz limpia para lectura concentrada	1. Eliminación elementos distractores; 2. Tipografía mejorada; 3. Guardado progreso	Resuelto	39404142-5	1	2024-05-25 10:35:00	3
48	Monitoreo base de datos tiempo real	Web	Alertas y métricas performance base datos	1. 20 métricas clave; 2. Alertas configurables; 3. Recomendaciones optimización	Cerrado	40414243-6	0	2024-03-15 13:50:00	1
49	Integración asistentes virtuales	Web	Control por voz mediante Alexa Google Assistant	1. 10 comandos básicos; 2. Personalización; 3. Soporte múltiples dispositivos	Abierto	41424344-7	2	2024-08-28 16:05:00	3
50	Sistema gamificación engagement usuario	Movil	Puntos logros y leaderboards para aumentar engagement	1. 10 logros iniciales; 2. Leaderboards sociales; 3. Recompensas reales	En Progreso	42434445-8	3	2024-07-30 09:20:00	2
52	Modo bajo consumo batería	Movil	Optimización consumo energía para prolongar batería	1. 30% más duración; 2. Funcionalidad esencial; 3. Activación automática	Cerrado	12345678-9	0	2024-02-12 11:00:00	2
54	Traducción automática contenido app	Web	Traducción 10 idiomas mediante AI	1. 10 idiomas soportados; 2. Calidad humana; 3. Glosario técnico	En Progreso	34567890-1	3	2024-07-08 10:10:00	3
55	Analytics embudos conversión	Web	Análisis embudos conversión para optimización	1. 5 embudos predefinidos; 2. Visualización clara; 3. Recomendaciones optimización	Resuelto	45678901-2	1	2024-05-18 13:25:00	2
56	2FA mediante push notifications	Movil	Autenticación mediante notificaciones push aprobación	1. Aprobación 1-tap; 2. Geolocation context; 3. Logs seguridad	Cerrado	56789012-3	0	2024-01-05 17:40:00	1
57	Layouts configurables dashboard	Web	Arrastrar y soltar para personalizar dashboards	1. 20 widgets disponibles; 2. Persistencia configuración; 3. Responsive design	Abierto	67890123-4	2	2024-08-25 12:05:00	3
58	Cache inteligente contenido	Web	Cache dinámico basado en patrones acceso	1. Reducción 60% carga; 2. Invalidation inteligente; 3. Stats performance	En Progreso	78901234-5	3	2024-07-17 09:20:00	1
59	Modo accesibilidad mejorado	Web	Mejoras accesibilidad para usuarios discapacidad visual	1. Screen reader optimized; 2. High contrast mode; 3. Keyboard navigation	Resuelto	89012345-6	1	2024-04-28 14:35:00	3
60	Reporting compliance regulaciones	Web	Reportes automáticos para GDPR CCPA LGPD	1. Templates predefinidos; 2. Exportación auditoría; 3. Actualización automática leyes	Cerrado	90123456-7	0	2024-03-08 16:50:00	2
61	Sincronización calendarios externos	Web	Sync bidireccional Google Calendar Outlook	1. Sync tiempo real; 2. Conflict resolution; 3. Soporte múltiples calendarios	Abierto	11223344-8	2	2024-08-20 11:15:00	1
62	Backup multi-region compliance	Web	Backup automático en múltiples regiones geográficas	1. 3 regiones mínimo; 2. Encryption in-transit at-rest; 3. Selección regiones	En Progreso	22334455-9	3	2024-07-22 15:30:00	2
63	Prototipado integrado diseño	Web	Herramienta prototipado dentro plataforma	1. Drag-drop interface; 2. Collaboration real-time; 3. Exportación múltiples formatos	Resuelto	33445566-0	1	2024-06-12 10:45:00	3
64	Alertas machine learning proactivas	Web	Sistema alertas predictivas basado machine learning	1. Detección temprana; 2. Root cause analysis; 3. Actionable insights	Cerrado	44556677-1	0	2024-02-28 13:00:00	1
65	Dashboard financiero multi-moneda	Web	Visualización finanzas múltiples monedas simultáneas	1. Conversión tiempo real; 2. Accounting standards; 3. Reportes consolidados	Abierto	55667788-2	2	2024-08-30 17:35:00	2
66	Dictado por voz a texto	Movil	Transcripción voz a texto con puntuación automática	1. Soporte 5 idiomas; 2. Puntuación inteligente; 3. Edición fácil	En Progreso	66778899-3	3	2024-07-14 09:00:00	3
67	Debugging remoto apps móviles	Web	Debugging tiempo real dispositivos remotos	1. Screen sharing; 2. Logs tiempo real; 3. Remote control	Resuelto	77889900-4	1	2024-05-05 12:15:00	1
68	Versionado documentos colaborativos	Web	Control versiones tipo Git para documentos	1. Branching merging; 2. Historial completo; 3. Rollback fácil	Cerrado	88990011-5	0	2024-01-25 15:40:00	2
69	Notificaciones preferencias granulares	Movil	Control fino sobre qué notificaciones recibir	1. 10 categorías configurables; 2. Horarios personalizados; 3. Modo silencio	Abierto	99001122-6	2	2024-08-10 10:05:00	3
70	Load balancing inteligente	Web	Distribución tráfico basado en latency y carga	1. Routing geográfico; 2. Health checks; 3. Failover automático	En Progreso	10111213-7	3	2024-07-05 14:20:00	1
71	Modo concentración bloqueo distracciones	Web	Modo que bloquea notificaciones y distracciones	1. Scheduling; 2. Stats productividad; 3. Integration calendario	Resuelto	12131415-8	1	2024-04-15 17:45:00	3
72	Magic links login sin password	Web	Autenticación mediante links mágicos por email	1. Expiración 15 minutos; 2. Detección fraud; 3. UX simplificada	Cerrado	13141516-9	0	2024-03-05 11:10:00	2
73	Integración project management tools	Web	Sync bidireccional Jira Trello Asana	1. 3 plataformas soportadas; 2. Sync tiempo real; 3. Mapeo campos personalizable	Abierto	14151617-0	2	2024-08-28 13:25:00	1
74	Recomendación AI contenido personalizado	Web	Algoritmo recomendación contenido ultra-personalizado	1. 50% mejor engagement; 2. Cold start solution; 3. Diversidad contenido	En Progreso	15161718-1	3	2024-07-19 09:40:00	2
75	Moderación automática contenido	Web	Sistema AI moderación contenido inapropiado	1. 95% precisión; 2. 10 categorías contenido; 3. Appeal process	Resuelto	16171819-2	1	2024-06-08 14:05:00	3
76	Backup incremental con versionado	Web	Sistema backup con histórico 30 versiones	1. Restore cualquier versión; 2. Compression eficiente; 3. Encryption end-to-end	Cerrado	17181920-3	0	2024-02-15 16:20:00	1
77	Widget meteorología ubicación actual	Movil	Widget con clima actual y pronóstico 24 horas	1. Ubicación precisa; 2. Actualización hora; 3. Alertas clima severo	Abierto	18192021-4	2	2024-08-15 10:45:00	2
78	Búsqueda inteligente semántica	Web	Búsqueda que entiende intención no solo keywords	1. Natural language; 2. Synonyms; 3. Resultados personalizados	En Progreso	19202122-5	3	2024-07-24 15:00:00	3
79	Modo viaje para planificación rutas	Movil	Funcionalidad específica para viajes largos	1. Planificación multi-stop; 2. Alertas tráfico; 3. Recomendaciones descanso	Resuelto	20212223-6	1	2024-05-12 11:15:00	1
80	Monitoreo seguridad tiempo real	Web	Sistema detección intrusos y amenazas seguridad	1. 20 señales detección; 2. Alertas inmediatas; 3. Response automático	Cerrado	21222324-7	0	2024-01-18 14:40:00	2
81	Feeds algoritmos ajustables	Web	Control usuario sobre algoritmo feed contenido	1. 5 sliders preferencias; 2. Efecto inmediato; 3. Reset fácil	Abierto	22232425-8	2	2024-08-22 17:15:00	3
82	Pagos cross-border multi-currency	Web	Sistema pagos internacionales múltiples monedas	1. 10 monedas soportadas; 2. Low fees; 3. Compliance internacional	En Progreso	23242526-9	3	2024-07-11 10:30:00	1
83	Realidad aumentada navegación indoor	Movil	Navegación interior edificios grandes mediante AR	1. Mapas interiores; 2. Precisión 5 metros; 3. Points of interest	Resuelto	24252627-0	1	2024-04-22 13:05:00	3
84	Backup encryption con key management	Web	Sistema gestión llaves encryption para backups	1. Key rotation automático; 2. Almacenamiento seguro; 3. Recovery protocol	Cerrado	25262728-1	0	2024-03-12 16:30:00	2
85	Integración wearables salud fitness	Movil	Sync datos salud desde Apple Watch Fitbit	1. 5 plataformas soportadas; 2. Datos históricos; 3. Privacidad garantizada	Abierto	26272829-2	2	2024-08-05 12:45:00	1
86	Analytics rendimiento equipo	Web	Dashboard performance empleados y equipos	1. 10 métricas performance; 2. Comparativas; 3. Feedback integrado	En Progreso	27282930-3	3	2024-07-28 15:00:00	2
87	Modo lectura inmersiva con notas	Web	Modo lectura con funcionalidad tomar notas integrada	1. Highlighting; 2. Notas marginales; 3. Exportación notas	Resuelto	28293031-4	1	2024-06-15 11:25:00	3
88	Detección patrones uso anómalos	Web	Sistema detección comportamiento inusual usuario	1. Machine learning; 2. Falsos positivos <3%; 3. Alertas configurables	Cerrado	29303132-5	0	2024-02-22 14:50:00	1
89	Avatares personalizables realidad virtual	Web	Sistema creación avatares personalizados para VR	1. 100 opciones personalización; 2. Exportación; 3. Compatibilidad múltiples plataformas	Abierto	30313233-6	2	2024-08-18 17:35:00	3
90	Cache distribuido consistente	Web	Sistema cache distribuido con consistencia fuerte	1. Latencia baja; 2. Consistencia inmediata; 3. High availability	En Progreso	31323334-7	3	2024-07-07 10:20:00	1
91	Controles accesibilidad one-click	Web	Acceso rápido controles accesibilidad desde cualquier lugar	1. Shortcut global; 2. 10 funciones accesibilidad; 3. Persistencia configuración	Resuelto	32333435-8	1	2024-05-28 13:45:00	3
92	Reporting ejecutivos simplificado	Web	Reportes high-level para audiencia ejecutiva	1. Visualización clara; 2. 5 KPIs clave; 3. Exportación presentación	Cerrado	33343536-9	0	2024-01-08 16:10:00	2
93	Integración smart home dispositivos	Web	Control dispositivos IoT hogar inteligente	1. 3 protocolos soportados; 2. Escenas automatización; 3. Control voz	Abierto	34353637-0	2	2024-08-25 11:15:00	1
94	Backup retención configurable	Web	Sistema retención backups personalizable por usuario	1. 5 políticas predefinidas; 2. Custom policies; 3. Enforcement automático	En Progreso	35363738-1	3	2024-07-16 15:30:00	2
95	Edición video básica móvil	Movil	Herramientas edición video directamente en app móvil	1. Trim crop; 2. Filters efectos; 3. Exportación alta calidad	Resuelto	36373839-2	1	2024-04-18 09:05:00	3
96	Alertas mercado personalizables	Web	Alertas mercados financieros personalizadas	1. 20 instrumentos soportados; 2. Alertas precio volumen; 3. Notificaciones push	Cerrado	37383940-3	0	2024-03-28 12:20:00	1
97	Shortcuts gestos personalizables	Movil	Gestos personalizados para acciones rápidas	1. 10 gestos configurables; 2. Sensibilidad ajustable; 3. Conflic detection	Abierto	38394041-4	2	2024-08-12 16:45:00	2
98	Monitoreo QoS experiencia usuario	Web	Métricas calidad experiencia usuario final	1. Real User Monitoring; 2. Alertas degradación; 3. Root cause analysis	En Progreso	39404142-5	3	2024-07-21 10:00:00	1
99	Modo privacidad máxima	Web	Modo  que minimiza data collection y tracking	1. No tracking; 2. Data local only; 3. Encryption reforzado Resuelto 40414243-6	1	2024-06-02 14:25:00	3
100	Backup local con verificación espacio	Web	Sistema backup local con gestión espacio inteligente	1. Verificación espacio; 2. Auto-cleanup; 3. Notificaciones espacio	Abierto	41424344-7	2	2024-08-05 17:00:00	2
101	Implementación de historial de cambios	Web	Registro automático y visualización de los cambios en registros importantes	1. Visualización por usuario; 2. Filtro por fecha; 3. Exportación histórica	Abierto	10010010-2	2	2015-03-01 08:15:00	2
102	Modo lectura nocturno	Movil	Cambia la paleta de colores para facilitar lectura nocturna	1. Cambio automático por horario; 2. Configuración personalizada; 3. Ahorro de batería	Resuelto	10020020-3	1	2015-04-15 21:30:00	3
103	Integración con Google Maps	Movil	Permite mostrar ubicaciones y rutas en la app	1. Actualización en tiempo real; 2. Múltiples marcadores; 3. Street View	Cerrado	10030030-4	0	2016-05-10 13:45:00	1
104	Panel de administración de usuarios	Web	Gestiona permisos, roles y bloqueos de usuarios	1. Registro de cambios; 2. Edición masiva; 3. Logs descargables	En Progreso	10040040-5	3	2016-07-24 16:10:00	3
105	Control de versiones de documentos	Web	Permite ver y restaurar versiones antiguas de documentos	1. Historial completo; 2. Restauración con un clic; 3. Notificación de cambios	Abierto	10050050-6	2	2017-02-18 10:05:00	2
106	Módulo de encuestas personalizadas	Web	Creación y envío de encuestas a usuarios seleccionados	1. Resultados en tiempo real; 2. Exportación CSV; 3. Límite de respuestas	Cerrado	10060060-7	0	2017-09-30 18:25:00	1
107	Reproductor de video integrado	Movil	Permite reproducir videos dentro de la app	1. Soporte MP4 y MKV; 2. Controles básicos; 3. Ajuste de velocidad	Resuelto	10070070-8	1	2018-03-12 14:40:00	3
108	Respaldo automático en la nube	Movil	Copia de seguridad automática de datos del usuario	1. Programación diaria; 2. Restablecimiento sencillo; 3. Notificaciones	En Progreso	10080080-9	3	2018-11-26 09:15:00	2
109	Panel de análisis de tráfico	Web	Visualiza estadísticas de visitas y comportamiento de usuarios	1. Gráficas interactivas; 2. Filtros avanzados; 3. Exportación PDF	Abierto	10090090-1	2	2019-07-07 12:30:00	1
110	Sincronización de contactos con Outlook	Movil	Permite importar y exportar contactos desde Outlook	1. Detección de duplicados; 2. Sincronización bidireccional; 3. Seguridad de datos	Cerrado	10100010-3	0	2019-10-22 17:10:00	2
111	Alertas de stock bajo	Web	Notifica automáticamente cuando un producto está por agotarse	1. Configuración de umbral; 2. Notificaciones email; 3. Panel de alertas	Resuelto	10110011-4	1	2020-01-14 19:50:00	3
112	Modo manos libres	Movil	Permite controlar funcionalidades por voz en modo conducción	1. Activación por comando; 2. Confirmación por voz; 3. Seguridad mejorada	En Progreso	10120012-5	3	2020-09-03 08:55:00	1
113	Exportación masiva a Excel	Web	Permite exportar grandes volúmenes de datos a archivos Excel	1. Límite de 100k filas; 2. Selección de columnas; 3. Formato compatible	Abierto	10130013-6	2	2021-06-11 13:20:00	2
114	Visualización de métricas en tiempo real	Web	Dashboard muestra KPIs en tiempo real para administración	1. Intervalo configurable; 2. Exportación gráfica; 3. Histórico semanal	Cerrado	10140014-7	0	2021-11-28 16:45:00	3
115	Integración con sistemas de facturación externos	Web	Enlace con servicios externos para emitir facturas	1. API REST; 2. Validación automática; 3. Registro de errores	Resuelto	10150015-8	1	2022-02-21 09:10:00	1
116	Módulo de feedback de usuarios	Movil	Permite recolectar opiniones y calificaciones de usuarios	1. Encuestas rápidas; 2. Análisis de sentimientos; 3. Reportes automáticos	En Progreso	10160016-9	3	2022-12-16 18:30:00	2
117	Notificaciones push por segmento	Web	Permite enviar mensajes push a segmentos de usuarios	1. Segmentos configurables; 2. Programación de envíos; 3. Estadísticas de apertura	Abierto	10170017-1	2	2023-08-03 11:55:00	3
118	Modo offline para reportes	Movil	Permite generar y consultar reportes sin conexión a internet	1. Sincronización posterior; 2. Alerta de actualización; 3. Visualización offline	Cerrado	10180018-2	0	2024-05-19 07:40:00	1
119	Autenticación por doble factor	Web	Doble autenticación usando SMS o email	1. Activación opcional; 2. Backup de códigos; 3. Seguridad avanzada	Resuelto	10190019-3	1	2025-03-30 15:10:00	2
120	Gestor de tareas recurrentes	Movil	Permite agendar tareas automáticas repetitivas	1. Edición masiva; 2. Alerta de próximos eventos; 3. Reprogramación fácil	En Progreso	10200020-4	3	2015-04-12 19:35:00	3
121	Chat grupal con archivos adjuntos	Movil	Permite enviar imágenes y documentos en chat grupal	1. Tamaño máx 20MB; 2. Vista previa; 3. Descarga individual	Abierto	10210021-5	2	2015-10-17 08:25:00	2
122	Panel de clientes frecuentes	Web	Muestra historial y beneficios de clientes VIP	1. Filtro por antigüedad; 2. Exportación de historial; 3. Mensajes personalizados	Cerrado	10220022-6	0	2016-01-03 15:50:00	1
123	Configuración de alertas personalizadas	Movil	Permite configurar notificaciones para eventos específicos	1. Reglas por usuario; 2. Sonido personalizado; 3. Horario silencioso	Resuelto	10230023-7	1	2016-08-05 14:15:00	3
124	Visualización de rutas optimizadas	Web	Muestra rutas de entrega optimizadas en el mapa	1. Algoritmo de optimización; 2. Actualización en vivo; 3. Descarga de rutas	Cerrado	10240024-8	0	2017-03-21 09:40:00	2
125	Modo presentación para dashboard	Web	Muestra información en formato visual para pantallas grandes	1. Modo oscuro; 2. Rotación automática; 3. Configuración de slides	Abierto	10250025-9	2	2017-12-29 17:55:00	1
126	Respaldo incremental en la nube	Web	Solo respalda archivos que han cambiado desde el último respaldo	1. Ahorro de espacio; 2. Historial de versiones; 3. Restauración rápida	Cerrado	10260026-1	0	2018-06-10 13:30:00	2
127	Panel de analítica avanzada	Web	Reportes gráficos y segmentación de usuarios	1. Gráficos personalizables; 2. Exportación CSV; 3. Aplicación de filtros	Resuelto	10270027-2	1	2019-02-25 07:45:00	3
128	Modo vacaciones	Movil	Desactiva notificaciones y procesos automáticos en vacaciones	1. Activación programada; 2. Mensaje de ausencia; 3. Reactivación automática	En Progreso	10280028-3	3	2019-11-04 15:20:00	1
129	Integración con Slack para alertas	Web	Permite enviar mensajes automáticos a canales de Slack	1. Webhooks configurables; 2. Logs de envíos; 3. Personalización de mensajes	Abierto	10290029-4	2	2020-08-17 09:10:00	2
130	Notificaciones de actualización de políticas	Movil	Alerta a usuarios cuando hay cambios en los términos o políticas	1. Confirmación de lectura; 2. Registro de aceptación; 3. Mensaje claro	Cerrado	10300030-5	0	2021-05-29 14:00:00	3
131	Modo ahorro de energía	Movil	Reduce consumo de batería disminuyendo procesos en segundo plano	1. Activación automática; 2. Estadísticas de ahorro; 3. Notificación de estado	Resuelto	10310031-6	1	2022-01-13 18:30:00	1
132	Módulo de integración contable	Web	Exporta movimientos a sistemas contables externos	1. Formato compatible; 2. Validación de datos; 3. Logs de errores	En Progreso	10320032-7	3	2022-10-26 13:10:00	2
133	Panel de ventas internacionales	Web	Permite analizar ventas por país y moneda	1. Conversión automática de moneda; 2. Filtros por región; 3. Exportación global	Abierto	10330033-8	2	2023-07-15 19:40:00	3
134	Chatbot de soporte automático	Web	Chatbot responde dudas frecuentes en la web	1. Base de conocimientos; 2. Aprendizaje automático; 3. Transferencia a humano	Cerrado	10340034-9	0	2024-03-09 08:15:00	1
135	Visualización de tickets en mapa	Movil	Muestra ubicación de tickets abiertos en mapa interactivo	1. Geolocalización automática; 2. Filtros por estado; 3. Rutas sugeridas	Resuelto	10350035-1	1	2025-01-24 14:45:00	2
136	Integración con MercadoPago	Web	Soporte para pagos rápidos con MercadoPago	1. Confirmación en tiempo real; 2. Reembolsos automáticos; 3. Estadísticas de pago	En Progreso	10360036-2	3	2015-06-28 19:20:00	3
137	Panel de fidelización de clientes	Web	Muestra puntos acumulados y recompensas disponibles	1. Actualización en tiempo real; 2. Canje de recompensas; 3. Exportación de puntos	Abierto	10370037-3	2	2016-03-14 12:15:00	1
138	Modo emergencias	Movil	Permite activar protocolo de emergencia desde la app	1. Botón visible; 2. Llamada a contacto seguro; 3. Compartir ubicación	Cerrado	10380038-4	0	2017-10-09 17:40:00	2
139	Exportación a Google Sheets	Web	Permite exportar reportes directamente a Google Sheets	1. OAuth seguro; 2. Selección de hojas; 3. Formato compatible	Resuelto	10390039-5	1	2018-05-21 11:50:00	3
140	Panel de auditoría de accesos	Web	Monitoreo y registro de accesos de usuarios a la plataforma	1. Exportación diaria; 2. Notificación de accesos sospechosos; 3. Filtros por usuario	En Progreso	10400040-6	3	2019-11-16 20:30:00	1
141	Integración con Google Drive	Movil	Permite subir y descargar archivos desde Google Drive	1. OAuth seguro; 2. Sincronización automática; 3. Gestión de permisos	Abierto	10410041-7	2	2020-06-03 16:10:00	2
142	Panel de métricas de satisfacción	Web	Visualiza NPS y satisfacción de usuarios	1. Encuestas programadas; 2. Gráficas históricas; 3. Exportación rápida	Cerrado	10420042-8	0	2021-01-09 10:55:00	3
143	Modo bajo consumo de datos	Movil	Reduce el uso de datos móviles en streaming y descargas	1. Ajuste de calidad; 2. Sincronización en WiFi; 3. Estadísticas de ahorro	Resuelto	10430043-9	1	2021-08-13 13:35:00	1
144	Panel de métricas operacionales	Web	Dashboard para operaciones diarias	1. KPIs configurables; 2. Alertas automáticas; 3. Exportación a Excel	En Progreso	10440044-1	3	2022-04-18 18:20:00	2
145	Integración con Telegram	Movil	Recibe notificaciones automáticas en Telegram	1. API Bot; 2. Mensajes personalizados; 3. Registro de envíos	Abierto	10450045-2	2	2023-02-22 09:45:00	3
146	Visualización de órdenes recurrentes	Web	Muestra historial y próximas órdenes programadas	1. Filtros por fecha; 2. Exportación CSV; 3. Notificación de próxima orden	Cerrado	10460046-3	0	2023-09-01 16:00:00	1
147	Módulo de integración con AFIP	Web	Emite comprobantes fiscales para Argentina	1. API AFIP; 2. Validación de CUIT; 3. Exportación de comprobantes	Resuelto	10470047-4	1	2024-05-05 11:25:00	2
148	Panel de ventas en diferentes monedas	Web	Permite analizar ventas en diversas monedas	1. Conversión automática; 2. Filtros por divisa; 3. Exportación global	En Progreso	10480048-5	3	2025-02-15 19:20:00	3
149	Modo lectura para personas con dislexia	Movil	Adapta la fuente y espaciado para facilitar la lectura	1. Activación manual; 2. Configuración de fuente; 3. Guía de lectura	Abierto	10490049-6	2	2015-09-12 20:10:00	1
150	Respaldo selectivo en la nube	Web	Permite seleccionar carpetas específicas para respaldar	1. Selección por usuario; 2. Historial de respaldos; 3. Restauración rápida	Cerrado	10500050-7	0	2016-04-02 10:25:00	2
151	Gestor de cuentas compartidas	Web	Permite que varios usuarios gestionen una misma cuenta con roles	1. Roles editables; 2. Historial de acciones; 3. Notificaciones de cambios	Abierto	10510051-8	2	2017-06-11 08:10:00	3
152	Modo ahorro extremo batería	Movil	Reduce al mínimo el consumo de batería desactivando procesos secundarios	1. Pausa de sincronizaciones; 2. Solo funciones esenciales; 3. Alerta de activación	Resuelto	10520052-9	1	2018-03-20 12:45:00	1
153	Panel de monitoreo para IoT	Web	Visualiza y gestiona dispositivos conectados en tiempo real	1. Reconocimiento automático; 2. Alerta de desconexión; 3. Dashboard configurable	Cerrado	10530053-1	0	2018-08-22 15:30:00	2
154	Widget calendario eventos	Movil	Muestra próximos eventos del usuario en la pantalla principal	1. Sincronización automática; 2. Edición rápida; 3. Alertas programables	En Progreso	10540054-2	3	2019-12-28 19:40:00	1
155	Notificaciones de cambios en políticas	Web	Alerta a los usuarios sobre actualizaciones en las políticas	1. Confirmación de lectura; 2. Registro de aceptación; 3. Resumen de cambios	Abierto	10550055-3	2	2020-02-18 17:55:00	2
156	Modo niños con interfaz adaptativa	Movil	Interfaz amigable y segura para menores	1. Control parental; 2. Bloqueo de compras; 3. Reporte de uso	Cerrado	10560056-4	0	2021-06-24 21:20:00	3
157	Panel comparativo de precios	Web	Permite comparar precios de productos entre distintas tiendas	1. Actualización automática; 2. Gráfica histórica; 3. Filtros avanzados	Resuelto	10570057-5	1	2022-11-15 14:10:00	1
158	Respaldo automático de imágenes	Movil	Sube automáticamente fotos nuevas a la nube	1. Solo WiFi; 2. Selección de carpetas; 3. Encriptación	En Progreso	10580058-6	3	2016-10-22 10:15:00	2
159	Integración con plataformas e-learning	Web	Permite importar y exportar cursos y calificaciones	1. API estándar; 2. Sincronización diaria; 3. Reportes descargables	Abierto	10590059-7	2	2016-11-18 08:45:00	3
160	Módulo de traducción automática	Movil	Traduce contenido de la app según idioma del sistema	1. 10 idiomas soportados; 2. Glosario personalizado; 3. Detección automática	Cerrado	10600060-8	0	2017-02-16 13:50:00	1
161	Panel de métricas avanzadas	Web	Reportes de rendimiento y uso para administradores	1. Selección de métricas; 2. Exportación CSV; 3. Alertas configurables	Resuelto	10610061-9	1	2018-05-23 09:30:00	2
162	Funcionalidad de pagos en cuotas	Movil	Pago dividido en varias cuotas automáticas	1. Configuración flexible; 2. Notificaciones de vencimiento; 3. Historial de pagos	En Progreso	10620062-1	3	2019-04-19 21:15:00	3
163	Modo lectura con ajuste de tamaño de fuente	Web	Permite cambiar tamaño de fuente en modo lectura	1. 5 tamaños disponibles; 2. Guarda preferencia; 3. Acceso rápido	Abierto	10630063-2	2	2020-09-10 17:40:00	1
164	Respaldo incremental de bases de datos	Web	Backup solo de los registros nuevos o modificados	1. Reducción de espacio; 2. Restauración eficiente; 3. Notificaciones diarias	Cerrado	10640064-3	0	2021-11-29 10:50:00	2
165	Módulo de gestión de inventario	Movil	Permite escanear códigos y registrar stock desde el móvil	1. Escaneo rápido; 2. Sincronización inmediata; 3. Exportación PDF	Resuelto	10650065-4	1	2022-06-18 16:30:00	3
166	Panel de seguimiento de entregas	Web	Visualiza el estado de los envíos y retrasos	1. Integración con transportistas; 2. Alertas de retraso; 3. Historial de entregas	En Progreso	10660066-5	3	2023-07-14 09:25:00	1
167	Funcionalidad de listas colaborativas	Movil	Permite a varios usuarios editar una lista en tiempo real	1. Sincronización instantánea; 2. Historial de cambios; 3. Notificación de edición	Abierto	10670067-6	2	2024-04-20 16:50:00	2
168	Respaldo seguro en múltiples regiones	Web	Copia de seguridad distribuida geográficamente	1. Selección de regiones; 2. Encriptación avanzada; 3. Restauración rápida	Cerrado	10680068-7	0	2015-01-14 11:00:00	3
169	Módulo de personalización de widgets	Movil	Permite crear y configurar widgets personalizados en el home	1. Editor visual; 2. Guardado de plantillas; 3. Sincronización	Resuelto	10690069-8	1	2016-04-07 13:30:00	1
170	Panel de facturación electrónica	Web	Permite emitir facturas electrónicas y llevar registro	1. Certificación tributaria; 2. Envío automático a clientes; 3. Exportación XML	En Progreso	10700070-9	3	2017-09-20 19:15:00	2
171	Modo concentración para estudiantes	Movil	Bloquea apps y notificaciones durante sesiones de estudio	1. Temporizador configurable; 2. Reporte de enfoque; 3. Desbloqueo de emergencia	Abierto	10710071-1	2	2018-02-21 10:10:00	3
172	Funcionalidad de firma electrónica	Web	Firma digitalmente documentos desde la plataforma	1. Soporte PDF; 2. Validez legal; 3. Auditoría de firmas	Cerrado	10720072-2	0	2019-11-18 11:20:00	1
173	Panel de gestión de devoluciones	Web	Gestiona y monitorea devoluciones de productos	1. Notificación automática; 2. Seguimiento de estado; 3. Reporte mensual	Resuelto	10730073-3	1	2020-06-15 15:45:00	2
174	Módulo de encuestas rápidas	Movil	Permite crear y responder encuestas instantáneas	1. Resultados en tiempo real; 2. Compartir por chat; 3. Historial de respuestas	En Progreso	10740074-4	3	2021-09-01 08:55:00	3
175	Funcionalidad de pagos vía QR	Web	Paga y cobra escaneando códigos QR	1. Integración bancaria; 2. Confirmación inmediata; 3. Historial de transacciones	Abierto	10750075-5	2	2022-01-30 13:20:00	1
176	Respaldo automático de configuraciones	Web	Guarda la configuración del usuario en la nube	1. Restauración con un clic; 2. Historial de cambios; 3. Notificación de respaldo	Cerrado	10760076-6	0	2022-12-13 16:40:00	2
177	Panel de visualización de tendencias	Web	Muestra tendencias de uso y actividad en gráficos interactivos	1. Filtros de tiempo; 2. Exportación a PNG; 3. Análisis predictivo	Resuelto	10770077-7	1	2023-03-29 11:05:00	3
178	Módulo de recordatorios inteligentes	Movil	Recordatorios automáticos según hábitos del usuario	1. IA predictiva; 2. Personalización; 3. Historial de recordatorios	En Progreso	10780078-8	3	2024-06-12 19:35:00	1
179	Panel de integración de APIs externas	Web	Permite administrar y conectar APIs de terceros	1. Añadir/eliminar API; 2. Logs de integración; 3. Panel de estado	Abierto	10790079-9	2	2015-05-28 17:10:00	2
180	Funcionalidad de feedback visual	Web	Permite a usuarios enviar capturas y comentarios gráficos	1. Herramientas de marcado; 2. Envío directo a soporte; 3. Seguimiento de tickets	Cerrado	10800080-1	0	2016-08-19 14:30:00	3
181	Modo modo bajo datos	Movil	Reduce el uso de datos para usuarios con planes limitados	1. Control de calidad media; 2. Sincronización solo WiFi; 3. Notificación de ahorro	Resuelto	10810081-2	1	2017-04-03 11:00:00	1
182	Panel de gestión de proyectos	Web	Permite crear, asignar y monitorear proyectos y tareas	1. Tablero Kanban; 2. Seguimiento de tiempo; 3. Exportación CSV	En Progreso	10820082-3	3	2018-10-23 09:50:00	2
183	Funcionalidad de integración con SAP	Web	Conecta la plataforma con SAP para sincronizar datos	1. Importación automática; 2. Exportación flexible; 3. Auditoría de procesos	Abierto	10830083-4	2	2019-12-02 13:55:00	3
184	Respaldo de archivos multimedia	Movil	Sube fotos y videos a la nube automáticamente	1. Selección de calidad; 2. Espacio configurable; 3. Notificación de éxito	Cerrado	10840084-5	0	2020-06-21 18:20:00	1
185	Modo noche programable	Web	Permite programar horarios para modo noche	1. Configuración sencilla; 2. Activación automática; 3. Estado visible	Resuelto	10850085-6	1	2021-01-11 16:45:00	2
186	Módulo de visualización de rutas	Movil	Muestra rutas de entrega y recogida en el mapa	1. Integración con GPS; 2. Optimización de rutas; 3. Feedback de choferes	En Progreso	10860086-7	3	2022-09-17 13:10:00	3
187	Panel de control de recursos	Web	Monitorea recursos utilizados por el sistema en tiempo real	1. Gráficos dinámicos; 2. Alertas de sobreuso; 3. Exportación de métricas	Abierto	10870087-8	2	2023-11-30 19:55:00	1
188	Funcionalidad de pagos sin contacto	Movil	Pago mediante NFC y QR sin contacto físico	1. Seguridad biométrica; 2. Confirmación instantánea; 3. Historial de pagos	Cerrado	10880088-9	0	2015-11-07 08:35:00	2
189	Modo multiusuario	Web	Varios usuarios pueden usar la app con sesiones independientes	1. Cambio rápido de sesión; 2. Notificación de actividad; 3. Historial separado	Resuelto	10890089-1	1	2016-12-16 15:20:00	3
190	Panel de análisis de satisfacción	Web	Monitorea la satisfacción del usuario con encuestas	1. Encuestas automáticas; 2. Estadísticas en tiempo real; 3. Exportación PDF	En Progreso	10900090-2	3	2017-08-12 11:45:00	1
191	Funcionalidad de listas inteligentes	Movil	Listas de tareas que se reordenan según prioridad inteligente	1. Algoritmo de aprendizaje; 2. Edición manual; 3. Sincronización	Abierto	10910091-3	2	2018-03-25 13:25:00	2
192	Respaldo automático de configuraciones	Web	Guarda automáticamente cambios en configuraciones críticas	1. Historial de respaldos; 2. Restauración fácil; 3. Alerta de cambios	Cerrado	10920092-4	0	2019-06-18 08:00:00	3
193	Módulo de facturación internacional	Web	Emite facturas en diferentes monedas	1. Conversión automática; 2. Selección de idioma; 3. Soporte tributario	Resuelto	10930093-5	1	2020-02-22 12:40:00	1
194	Panel de control parental	Movil	Permite limitar funciones y horarios para menores	1. Tiempo de uso diario; 2. Bloqueo de apps; 3. Reporte de actividad	En Progreso	10940094-6	3	2021-10-27 19:15:00	2
195	Funcionalidad de edición colaborativa	Web	Permite edición simultánea de documentos	1. Varios editores a la vez; 2. Historial de cambios; 3. Resolución de conflictos	Abierto	10950095-7	2	2022-07-03 09:35:00	3
196	Módulo de integración con AFIP	Movil	Permite emitir comprobantes fiscales desde el móvil	1. Certificación AFIP; 2. Validación de datos; 3. Exportación PDF	Cerrado	10960096-8	0	2023-05-05 11:40:00	1
197	Panel de ventas predictivas	Web	Analiza ventas y predice tendencias futuras	1. Algoritmo ML; 2. Exportación de predicciones; 3. Reporte mensual	Resuelto	10970097-9	1	2024-03-11 15:55:00	2
198	Modo modo invitado	Movil	Permite usar la app sin crear cuenta para probar funciones	1. Límite de acceso; 2. Conversión fácil a cuenta real; 3. Borrado de datos automático	En Progreso	10980098-1	3	2015-07-13 13:20:00	3
199	Funcionalidad de listas de deseos	Web	Permite a usuarios crear y compartir listas de deseos	1. Compartir por email; 2. Notificación de precios; 3. Exportación PDF	Abierto	10990099-2	2	2016-05-24 16:30:00	1
200	Respaldo de imágenes de perfil	Movil	Guarda automáticamente las fotos de perfil anteriores	1. Historial de imágenes; 2. Restauración fácil; 3. Notificación de cambios	Cerrado	11000100-3	0	2017-12-20 08:50:00	2
201	Módulo de importación de datos CSV	Web	Permite importar datos masivamente desde archivos CSV	1. Validación de formato; 2. Notificación de errores; 3. Vista previa antes de importar	Abierto	11010101-4	2	2018-07-11 14:20:00	2
202	Funcionalidad de órdenes programadas	Movil	Permite programar pedidos para fechas futuras	1. Selección de fecha y hora; 2. Notificación previa; 3. Edición de órdenes	Resuelto	11020202-5	1	2019-02-15 09:45:00	3
203	Panel de monitoreo de energía	Web	Visualiza el consumo energético de dispositivos conectados	1. Gráficos diarios y mensuales; 2. Alertas de sobreconsumo; 3. Exportación CSV	Cerrado	11030303-6	0	2019-11-13 19:00:00	1
204	Integración con plataformas de pago internacionales	Web	Acepta pagos de clientes en todo el mundo	1. Soporte para PayPal y Stripe; 2. Conversión de moneda; 3. Confirmación instantánea	En Progreso	11040404-7	3	2020-10-22 17:30:00	3
205	Modo oscuro automático	Movil	Cambia a modo oscuro según la hora del día	1. Activación programable; 2. Recordatorio visual; 3. Ahorro de batería	Abierto	11050505-8	2	2021-06-18 08:15:00	1
206	Panel de análisis de productividad	Web	Muestra gráficos de productividad por usuario y equipo	1. Filtros por periodo; 2. Exportación PDF; 3. Comparación entre equipos	Cerrado	11060606-9	0	2022-01-28 16:10:00	2
207	Funcionalidad de búsqueda avanzada	Movil	Permite filtrar resultados por múltiples criterios	1. 10 filtros combinables; 2. Guardado de búsquedas; 3. Historial de búsquedas	Resuelto	11070707-1	1	2022-08-11 13:40:00	3
208	Módulo de integración con bancos	Web	Permite consultar movimientos y saldos bancarios	1. API segura; 2. Actualización diaria; 3. Notificación de movimientos	En Progreso	11080808-2	3	2023-05-26 10:05:00	1
209	Respaldo selectivo de archivos	Movil	Selecciona archivos específicos para respaldar en la nube	1. Filtro por tipo de archivo; 2. Notificación de respaldo; 3. Restauración con un clic	Abierto	11090909-3	2	2024-03-17 15:50:00	2
210	Panel de historial de pagos	Web	Muestra historial completo de pagos realizados	1. Filtros por fecha y monto; 2. Exportación PDF; 3. Buscador integrado	Cerrado	11101010-4	0	2025-01-10 17:45:00	3
211	Funcionalidad de reportes automáticos	Movil	Envío automático de reportes a emails configurados	1. Frecuencia configurable; 2. Plantillas personalizadas; 3. Confirmación de envío	Resuelto	11111111-5	1	2015-09-02 09:10:00	1
212	Panel de integración con Zapier	Web	Permite automatizar flujos conectando con otras apps	1. Webhooks; 2. Notificación de errores; 3. Logs de integración	En Progreso	11121212-6	3	2016-06-20 13:25:00	2
213	Módulo para compartir archivos grandes	Movil	Permite compartir archivos de hasta 2GB entre usuarios	1. Link seguro; 2. Fecha de expiración; 3. Notificación de descarga	Abierto	11131313-7	2	2017-11-28 14:30:00	3
214	Funcionalidad de encuestas de satisfacción	Web	Permite enviar encuestas después de cada compra	1. Resultados en tiempo real; 2. Exportación de respuestas; 3. Notificación de baja puntuación	Cerrado	11141414-8	0	2018-10-13 18:55:00	1
215	Panel de gestión de incidencias	Web	Permite reportar, asignar y cerrar incidencias del sistema	1. Asignación automática; 2. Filtros avanzados; 3. Exportación Excel	Resuelto	11151515-9	1	2019-05-06 17:20:00	2
216	Módulo de control de acceso	Movil	Permite controlar accesos físicos a oficinas con QR	1. Registro de accesos; 2. Notificación de entradas; 3. Integración con cámaras	En Progreso	11161616-1	3	2020-01-24 12:35:00	3
217	Funcionalidad de modo invitado	Web	Permite navegar la plataforma sin iniciar sesión	1. Restricciones de acceso; 2. Conversión fácil a cuenta; 3. Eliminación de datos temporal	Abierto	11171717-2	2	2020-09-30 08:25:00	1
218	Panel de métricas de engagement	Web	Analiza la interacción de usuarios con el sistema	1. Gráficos comparativos; 2. Segmentación por usuario; 3. Exportación rápida	Cerrado	11181818-3	0	2021-03-20 11:45:00	2
219	Funcionalidad de pagos con código de barras	Movil	Paga servicios escaneando código de barras	1. Integración con bancos; 2. Confirmación instantánea; 3. Historial de pagos	Resuelto	11191919-4	1	2021-12-02 14:30:00	3
220	Módulo de gestión documental	Web	Organiza y busca documentos en la nube	1. Filtro por etiquetas; 2. Visualización previa; 3. Historial de versiones	En Progreso	11202020-5	3	2022-07-15 17:10:00	1
221	Respaldo automático de chat	Movil	Guarda conversaciones en la nube periódicamente	1. Programación configurable; 2. Restauración de chats; 3. Encriptación	Abierto	11212121-6	2	2023-06-18 08:00:00	2
222	Panel de análisis de clima laboral	Web	Permite evaluar el clima laboral con encuestas internas	1. Resultados anónimos; 2. Exportación gráfica; 3. Seguimiento por área	Cerrado	11222222-7	0	2024-04-21 19:25:00	3
223	Funcionalidad de multi-idioma en chat	Movil	Permite traducir automáticamente mensajes en tiempo real	1. Soporte 8 idiomas; 2. Detección automática; 3. Corrección de errores	Resuelto	11232323-8	1	2025-03-15 13:10:00	1
224	Módulo de sugerencias de productos	Web	Sugiere productos relacionados según historial	1. Algoritmo configurable; 2. Feedback de usuario; 3. Exportación de sugerencias	En Progreso	11242424-9	3	2015-05-23 18:40:00	2
225	Panel de análisis de tickets	Movil	Analiza tiempos de respuesta y resolución en soporte	1. Métricas por agente; 2. Estadísticas mensuales; 3. Exportación a Excel	Abierto	11252525-1	2	2016-02-20 12:05:00	3
226	Funcionalidad de pagos con NFC	Movil	Paga con solo acercar el teléfono a un terminal	1. Seguridad biométrica; 2. Confirmación instantánea; 3. Historial de pagos	Cerrado	11262626-2	0	2017-11-13 09:50:00	1
227	Panel de integración con Google Ads	Web	Permite visualizar métricas de campañas publicitarias	1. API segura; 2. Gráficas comparativas; 3. Exportación PDF	Resuelto	11272727-3	1	2018-08-09 15:30:00	2
228	Módulo de actualización automática	Movil	Actualiza la app automáticamente en segundo plano	1. Descarga silenciosa; 2. Notificación de actualización; 3. Configuración programable	En Progreso	11282828-4	3	2019-06-14 19:15:00	3
229	Funcionalidad de seguimiento de clientes	Web	Permite registrar interacciones y seguimiento comercial	1. Registro de notas; 2. Recordatorio de llamadas; 3. Exportación a CSV	Abierto	11292929-5	2	2020-05-25 14:00:00	1
230	Panel de gestión de suscripciones	Web	Permite administrar y visualizar suscripciones activas	1. Renovación automática; 2. Historial de pagos; 3. Notificaciones de vencimiento	Cerrado	11303030-6	0	2021-02-18 16:20:00	2
231	Funcionalidad de búsqueda por voz	Movil	Permite buscar información usando comandos de voz	1. Soporte en 5 idiomas; 2. Resultados instantáneos; 3. Corrección automática	Resuelto	11313131-7	1	2022-07-23 11:30:00	3
232	Módulo de integración con contadores	Web	Permite compartir reportes automáticamente con contadores	1. Exportación programada; 2. Notificaciones; 3. Logs de envío	En Progreso	11323232-8	3	2023-04-14 18:55:00	1
233	Respaldo automático de fotos	Movil	Sube fotos nuevas a la nube al detectar WiFi	1. Selección de carpetas; 2. Historial de respaldos; 3. Restauración rápida	Abierto	11333333-9	2	2024-01-12 08:25:00	2
234	Panel de análisis de cumplimiento	Web	Permite auditar cumplimiento de normativas internas	1. Checklist editable; 2. Resultados automáticos; 3. Exportación legal	Cerrado	11343434-1	0	2025-08-20 14:10:00	3
235	Funcionalidad de edición de imágenes	Web	Permite recortar y ajustar imágenes antes de subir	1. Herramientas básicas; 2. Filtros; 3. Vista previa en tiempo real	Resuelto	11353535-2	1	2015-10-01 09:20:00	1
236	Módulo de gestión de inventario	Movil	Controla stock y realiza inventarios desde el móvil	1. Escaneo de códigos; 2. Reporte en PDF; 3. Sincronización con web	En Progreso	11363636-3	3	2016-04-17 14:35:00	2
237	Funcionalidad de calendario compartido	Web	Permite compartir eventos y calendarios con colegas	1. Permisos de edición; 2. Notificaciones por evento; 3. Sincronización con Google Calendar	Abierto	11373737-4	2	2017-10-11 12:10:00	3
238	Panel de métricas para RRHH	Web	Analiza rotación, ausentismo y rendimiento	1. Gráficas por periodo; 2. Exportación a Excel; 3. Alertas personalizadas	Cerrado	11383838-5	0	2018-12-21 18:40:00	1
239	Funcionalidad de autenticación con Face ID	Movil	Permite autenticarse usando reconocimiento facial	1. Seguridad biométrica; 2. Integración con iOS; 3. Soporte para fallback	Resuelto	11393939-6	1	2019-09-08 10:30:00	2
240	Módulo de actualización de seguridad	Web	Permite recibir parches de seguridad automáticamente	1. Notificación de nuevas versiones; 2. Instalación silenciosa; 3. Historial de actualizaciones	En Progreso	11404040-7	3	2020-06-09 08:40:00	3
250	Funcionalidad de encuestas anónimas	Movil	Permite enviar y responder encuestas de manera anónima	1. Resultados agregados; 2. Protección de identidad; 3. Exportación de datos	Cerrado	11414141-8	0	2021-08-16 17:10:00	1
251	Módulo de integración con Shopify	Web	Permite sincronizar productos y ventas con Shopify	1. Importación automática; 2. Actualización de stock; 3. Reporte de ventas	Abierto	11424242-9	2	2018-01-14 09:20:00	2
252	Funcionalidad de envío programado de emails	Movil	Permite programar el envío de correos electrónicos	1. Selección de fecha/hora; 2. Vista previa; 3. Cancelación de envío	Resuelto	11434343-1	1	2018-10-21 16:10:00	3
253	Panel de métricas para ventas	Web	Visualiza estadísticas de ventas y tendencias	1. Filtros por periodo; 2. Exportación a Excel; 3. Gráficas interactivas	Cerrado	11444444-2	0	2019-05-09 13:45:00	1
254	Integración con correos certificados	Web	Permite enviar notificaciones legales por correo certificado	1. Confirmación de recepción; 2. Registro de envíos; 3. Descarga de acuses	En Progreso	11454545-3	3	2019-10-17 19:30:00	2
255	Modo enfoque para reuniones	Movil	Bloquea notificaciones durante reuniones agendadas	1. Detección automática de reuniones; 2. Activación manual; 3. Reporte de interrupciones	Abierto	11464646-4	2	2020-03-25 08:15:00	3
256	Panel de control de auditoría	Web	Monitorea y registra cambios críticos en la plataforma	1. Registro de acciones; 2. Exportación PDF; 3. Alertas de cambios	Cerrado	11474747-5	0	2020-11-13 14:00:00	1
257	Funcionalidad de pagos con criptomonedas	Movil	Acepta pagos en Bitcoin, Ethereum y otras criptos	1. Conversión automática; 2. Confirmación instantánea; 3. Historial de pagos	Resuelto	11484848-6	1	2021-06-04 12:40:00	2
258	Módulo de gestión de licencias	Web	Permite gestionar licencias de software y renovaciones	1. Notificación de vencimiento; 2. Asignación masiva; 3. Exportación de licencias	En Progreso	11494949-7	3	2021-12-20 18:05:00	3
259	Funcionalidad de modo sin conexión avanzada	Movil	Sincroniza cambios complejos al reconectar	1. Detección de conflictos; 2. Notificación de errores; 3. Resolución asistida	Abierto	11505050-8	2	2022-07-02 13:30:00	1
260	Panel de integración con Salesforce	Web	Permite importar y exportar contactos y oportunidades	1. API segura; 2. Actualización diaria; 3. Historial de sincronización	Cerrado	11515151-9	0	2023-01-28 09:50:00	2
261	Funcionalidad de recomendaciones automáticas	Movil	Sugiere productos y servicios según uso y preferencias	1. Personalización por usuario; 2. Feedback; 3. Estadísticas de acierto	Resuelto	11425252-1	1	2023-06-12 18:20:00	3
262	Módulo de análisis de tráfico web	Web	Analiza fuentes de tráfico y comportamiento de usuarios	1. Gráficas interactivas; 2. Filtros por periodo; 3. Exportación de datos	Resuelto	11525252-1	1	2024-12-27 15:20:00	2
263	Módulo de notificaciones de vencimientos	Web	Notifica próximos vencimientos de productos y servicios	1. Configuración de alertas; 2. Integración con calendario; 3. Reporte de vencidos	En Progreso	11535353-2	3	2023-09-21 11:25:00	3
264	Funcionalidad de bloqueo por horario	Movil	Bloquea funciones de la app en horarios definidos	1. Horarios configurables; 2. Notificación previa; 3. Excepciones programables	Abierto	11545454-3	2	2024-07-13 07:15:00	1
265	Panel de gestión de bonos y descuentos	Web	Gestiona y asigna bonos y descuentos a usuarios	1. Bonos acumulables; 2. Historial de uso; 3. Exportación de reportes	Cerrado	11555555-4	0	2025-04-07 17:40:00	2
266	Funcionalidad de modo seguro	Movil	Desactiva funciones críticas en ambientes inseguros	1. Activación automática; 2. Notificación de seguridad; 3. Log de eventos	Resuelto	11565656-5	1	2018-08-15 12:00:00	3
267	Módulo de integración con Zoom	Web	Permite agendar y gestionar reuniones Zoom	1. API OAuth segura; 2. Sincronización de calendarios; 3. Grabación automática	En Progreso	11575757-6	3	2019-05-11 10:30:00	1
268	Respaldo encriptado de chats	Movil	Guarda conversaciones en la nube con cifrado extremo	1. Encriptación AES; 2. Restauración con autenticación; 3. Notificación de respaldo	Abierto	11585858-7	2	2020-02-29 19:15:00	2
269	Panel de seguimiento de KPIs	Web	Visualiza indicadores clave de rendimiento para el negocio	1. KPIs configurables; 2. Gráficas históricas; 3. Exportación a Excel	Cerrado	11595959-8	0	2020-10-08 15:10:00	3
270	Funcionalidad de pagos vía transferencia	Movil	Paga servicios mediante transferencia bancaria directa	1. Integración bancaria nacional; 2. Confirmación automática; 3. Notificación de pago	Resuelto	11606060-9	1	2021-12-23 17:20:00	1
271	Módulo de edición de documentos colaborativos	Web	Permite edición simultánea de documentos por varios usuarios	1. Control de versiones; 2. Comentarios; 3. Notificación de cambios	En Progreso	11616161-1	3	2022-06-17 13:35:00	2
272	Funcionalidad de widgets informativos	Movil	Muestra widgets personalizables en el home	1. Selección de información; 2. Actualización automática; 3. Diseño adaptable	Abierto	11626262-2	2	2023-03-05 18:50:00	3
273	Módulo de ventas cruzadas	Web	Sugiere productos complementarios en el proceso de compra	1. Algoritmo configurable; 2. Estadísticas de éxito; 3. Exportación de sugerencias	Cerrado	11636363-3	0	2024-09-16 10:15:00	1
274	Funcionalidad de notificación de cumpleaños	Movil	Envía felicitaciones automáticas a contactos en su cumpleaños	1. Personalización de mensaje; 2. Envío programado; 3. Estadísticas de envíos	Resuelto	11646464-4	1	2016-04-14 08:00:00	2
275	Módulo de gestión de devoluciones	Web	Permite gestionar devoluciones de productos y servicios	1. Generación de tickets; 2. Notificación de estado; 3. Reporte mensual	En Progreso	11656565-5	3	2017-09-12 15:25:00	3
276	Funcionalidad de pagos recurrentes	Movil	Permite programar pagos automáticos periódicos	1. Frecuencia configurable; 2. Notificación previa; 3. Historial de pagos	Abierto	11666666-6	2	2018-12-01 11:05:00	1
277	Módulo de integración con Google Analytics	Web	Permite ver estadísticas de uso del sitio directamente en la plataforma	1. API segura; 2. Gráficas resumidas; 3. Exportación PDF	Cerrado	11676767-7	0	2019-06-19 19:30:00	2
278	Funcionalidad de video llamadas	Movil	Permite realizar videollamadas entre usuarios	1. Calidad HD; 2. Chat integrado; 3. Grabación de llamadas	Resuelto	11686868-8	1	2020-11-04 09:40:00	3
279	Módulo de gestión de inventarios avanzados	Web	Permite gestionar inventario con múltiples almacenes y ubicaciones	1. Transferencias entre bodegas; 2. Notificación de stock bajo; 3. Exportación de movimientos	En Progreso	11696969-9	3	2021-08-28 14:15:00	1
280	Funcionalidad de modo vacaciones	Movil	Permite desactivar notificaciones y actividades automáticas durante las vacaciones	1. Activación programada; 2. Mensaje de ausencia; 3. Reactivación automática	Abierto	11707070-1	2	2022-01-19 08:10:00	2
281	Módulo de recordatorios por ubicación	Web	Envía recordatorios cuando el usuario llega a un lugar específico	1. Geolocalización precisa; 2. Configuración flexible; 3. Notificación instantánea	Cerrado	11717171-2	0	2022-10-12 17:35:00	3
282	Funcionalidad de edición de tablas	Movil	Permite editar y reordenar tablas de datos desde la app	1. Arrastrar y soltar; 2. Guardado automático; 3. Exportación a Excel	Resuelto	11727272-3	1	2023-05-09 19:00:00	1
283	Módulo de análisis de abandono de carrito	Web	Analiza los motivos de abandono de carrito de compras	1. Encuestas automáticas; 2. Estadísticas detalladas; 3. Reporte semanal	En Progreso	11737373-4	3	2024-06-28 15:25:00	2
284	Funcionalidad de integración con SII	Movil	Permite declarar boletas electrónicas directamente desde la app	1. Validación de datos; 2. Envío automático; 3. Historial de declaraciones	Abierto	11747474-5	2	2015-09-16 10:50:00	3
285	Módulo de gestión de permisos avanzados	Web	Permite definir permisos personalizados para cada usuario	1. Jerarquía de roles; 2. Registro de cambios; 3. Exportación de configuraciones	Cerrado	11757575-6	0	2016-06-27 14:20:00	1
286	Funcionalidad de conversión de moneda	Movil	Convierte precios y montos según la moneda seleccionada	1. Actualización automática de tasas; 2. Selección personalizada; 3. Historial de conversiones	Resuelto	11767676-7	1	2017-02-03 16:45:00	2
287	Módulo de estadísticas de uso	Web	Muestra estadísticas detalladas de uso por usuario	1. Filtros por fecha y acción; 2. Exportación CSV; 3. Gráficas interactivas	En Progreso	11777777-8	3	2018-04-15 10:10:00	3
288	Funcionalidad de integración con Mercado Libre	Movil	Sincroniza productos, ventas y mensajes con Mercado Libre	1. API oficial; 2. Notificación de ventas; 3. Reporte de ganancias	Abierto	11787878-9	2	2019-11-05 12:30:00	1
289	Módulo de gestión de suscripciones avanzadas	Web	Permite crear y administrar planes de suscripción	1. Renovación automática; 2. Control de upgrades/downgrades; 3. Exportación de datos	Cerrado	11797979-1	0	2020-07-21 18:55:00	2
290	Funcionalidad de pagos por código QR	Movil	Paga escaneando códigos QR generados por comercios	1. Integración bancaria; 2. Confirmación automática; 3. Historial de pagos	Resuelto	11808080-2	1	2021-01-27 09:35:00	3
291	Módulo de gestión documental avanzada	Web	Permite versionar y compartir documentos con control de acceso	1. Historial de versiones; 2. Compartir por usuario; 3. Notificación de cambios	En Progreso	11818181-3	3	2021-09-15 11:55:00	1
292	Funcionalidad de modo multiusuario	Movil	Permite cambiar de usuario rápido en el mismo dispositivo	1. Perfiles independientes; 2. Sincronización de datos; 3. Límite de usuarios	Abierto	11828282-4	2	2022-02-08 13:20:00	2
293	Módulo de análisis de productividad	Web	Permite medir productividad individual y grupal	1. Reporte mensual; 2. Gráficas comparativas; 3. Exportación PDF	Cerrado	11838383-5	0	2023-07-21 19:40:00	3
294	Funcionalidad de pagos con Apple Pay	Movil	Acepta pagos usando Apple Pay en iOS	1. Integración nativa; 2. Confirmación biométrica; 3. Historial de pagos	Resuelto	11848484-6	1	2024-05-04 08:30:00	1
295	Módulo de integración con sistemas ERP	Web	Permite conectar la plataforma con sistemas ERP externos	1. API flexible; 2. Logs de integración; 3. Exportación de datos	En Progreso	11858585-7	3	2025-03-19 17:20:00	2
296	Funcionalidad de personalización de colores	Movil	Permite elegir la paleta de colores de la app	1. Paletas predefinidas; 2. Guardado de preferencias; 3. Compatibilidad con modo oscuro	Abierto	11868686-8	2	2015-04-09 10:50:00	3
297	Módulo de control de horarios	Web	Permite registrar y analizar horarios de entrada y salida	1. Registro automático; 2. Exportación a Excel; 3. Alertas de retraso	Cerrado	11878787-9	0	2016-12-10 14:35:00	1
298	Funcionalidad de integración con Google Fit	Movil	Sincroniza datos de actividad física con Google Fit	1. Soporte pasos, calorías y distancia; 2. Notificación de metas; 3. Historial de sincronización	Resuelto	11888888-1	1	2017-06-16 09:30:00	2
299	Módulo de gestión de agendas compartidas	Web	Permite compartir agendas y eventos entre equipos	1. Permisos por usuario; 2. Notificación de cambios; 3. Sincronización con calendarios externos	En Progreso	11898989-2	3	2018-11-07 19:00:00	3
300	Funcionalidad de envío de archivos por Bluetooth	Movil	Permite compartir archivos con otros dispositivos por Bluetooth	1. Compatibilidad multiplataforma; 2. Confirmación de envío; 3. Límite de tamaño configurables	Abierto	11909090-3	2	2019-08-13 13:10:00	1
\.



--
-- Data for Name: topicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topicos (id, nombre) FROM stdin;
1	Backend
2	Seguridad
3	UX/UI
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (rut, nombre, email) FROM stdin;
12345678-9	Ana López Rojas	ana.lopez@email.com
23456789-0	Carlos Muñoz Díaz	carlos.munoz@email.com
34567890-1	María González Pérez	maria.gonzalez@email.com
45678901-2	Juan Silva Rojas	juan.silva@email.com
56789012-3	Paula Martínez López	paula.martinez@email.com
67890123-4	Diego Rodríguez Soto	diego.rodriguez@email.com
78901234-5	Camila Fernández Mora	camila.fernandez@email.com
89012345-6	Andrés Vargas Castro	andres.vargas@email.com
90123456-7	Valentina Navarro Jiménez	valentina.navarro@email.com
11223344-8	Matías Herrera Ruiz	matias.herrera@email.com
22334455-9	Javiera Mendoza López	javiera.mendoza@email.com
33445566-0	Felipe Castro Ríos	felipe.castro@email.com
44556677-1	Isidora Torres Vargas	isidora.torres@email.com
55667788-2	Benjamín Soto Méndez	benjamin.soto@email.com
66778899-3	Antonia Romero Silva	antonia.romero@email.com
77889900-4	Tomás Díaz Fuentes	tomas.diaz@email.com
88990011-5	Florencia Rojas Castillo	florencia.rojas@email.com
99001122-6	Gabriel Pérez Núñez	gabriel.perez@email.com
10111213-7	Constanza López Medina	constanza.lopez@email.com
12131415-8	Maximiliano González Reyes	maximiliano.gonzalez@email.com
13141516-9	Amanda Silva Ortiz	amanda.silva@email.com
14151617-0	Ricardo Martínez Vega	ricardo.martinez@email.com
15161718-1	Daniela Rodríguez Herrera	daniela.rodriguez@email.com
16171819-2	Nicolás Fernández Castro	nicolas.fernandez@email.com
17181920-3	Sofía Vargas Rojas	sofia.vargas@email.com
18192021-4	Alexandro Navarro Díaz	alexandro.navarro@email.com
19202122-5	Emilia Herrera López	emilia.herrera@email.com
20212223-6	Diego Mendoza Torres	diego.mendoza@email.com
21222324-7	Catalina Castro Soto	catalina.castro@email.com
22232425-8	Joaquín Torres Romero	joaquin.torres@email.com
23242526-9	Antonella Soto Pérez	antonella.soto@email.com
24252627-0	Lucas Romero Silva	lucas.romero@email.com
25262728-1	Martina Díaz González	martina.diaz@email.com
26272829-2	Samuel Rojas Martínez	samuel.rojas@email.com
27282930-3	Victoria Pérez Rodríguez	victoria.perez@email.com
28293031-4	Matías López Fernández	matias.lopez@email.com
29303132-5	Isabella González Vargas	isabella.gonzalez@email.com
30313233-6	Benjamín Silva Navarro	benjamin.silva@email.com
31323334-7	Emma Martínez Herrera	emma.martinez@email.com
32333435-8	Thiago Rodríguez Mendoza	thiago.rodriguez@email.com
33343536-9	Sofia Fernández Castro	sofia.fernandez@email.com
34353637-0	Sebastian Vargas Torres	storres@email.com
35363738-1	Valeria Navarro Soto	valeria.navarro@email.com
36373839-2	Dylan Herrera Romero	dylan.herrera@email.com
37383940-3	Renata Mendoza Díaz	renata.mendoza@email.com
38394041-4	Maximiliano Castro Rojas	maximiliano.castro@email.com
39404142-5	Antonella Torres Pérez	antonella.torres@email.com
40414243-6	Matías Soto Silva	matias.soto@email.com
41424344-7	Emilia Romero González	emilia.romero@email.com
42434445-8	Lucas Díaz Martínez	lucas.diaz@email.com
\.


--
-- Name: solicitudes_errores_id_caso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_errores_id_caso_seq', 1, false);


--
-- Name: solicitudes_funcionalidad_id_caso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudes_funcionalidad_id_caso_seq', 1, false);


--
-- Name: topicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topicos_id_seq', 3, true);


--
-- Name: ingenieros ingenieros_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingenieros
    ADD CONSTRAINT ingenieros_email_key UNIQUE (email);


--
-- Name: ingenieros ingenieros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingenieros
    ADD CONSTRAINT ingenieros_pkey PRIMARY KEY (rut);


--
-- Name: solicitudes_errores solicitudes_errores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_errores
    ADD CONSTRAINT solicitudes_errores_pkey PRIMARY KEY (id_caso);


--
-- Name: solicitudes_errores solicitudes_errores_titulo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_errores
    ADD CONSTRAINT solicitudes_errores_titulo_key UNIQUE (titulo);


--
-- Name: solicitudes_funcionalidad solicitudes_funcionalidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_funcionalidad
    ADD CONSTRAINT solicitudes_funcionalidad_pkey PRIMARY KEY (id_caso);


--
-- Name: solicitudes_funcionalidad solicitudes_funcionalidad_titulo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_funcionalidad
    ADD CONSTRAINT solicitudes_funcionalidad_titulo_key UNIQUE (titulo);


--
-- Name: topicos topicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topicos
    ADD CONSTRAINT topicos_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (rut);


--
-- Name: asignacion asignacion_id_caso_e_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignacion
    ADD CONSTRAINT asignacion_id_caso_e_fkey FOREIGN KEY (id_caso_e) REFERENCES public.solicitudes_errores(id_caso);


--
-- Name: asignacion asignacion_id_caso_f_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignacion
    ADD CONSTRAINT asignacion_id_caso_f_fkey FOREIGN KEY (id_caso_f) REFERENCES public.solicitudes_funcionalidad(id_caso);


--
-- Name: asignacion id_ingeniero_2_to_rut_ingeniero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignacion
    ADD CONSTRAINT id_ingeniero_2_to_rut_ingeniero FOREIGN KEY (id_ingeniero_2) REFERENCES public.ingenieros(rut);


--
-- Name: asignacion id_ingeniero_3_to_rut_ingeniero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignacion
    ADD CONSTRAINT id_ingeniero_3_to_rut_ingeniero FOREIGN KEY (id_ingeniero_3) REFERENCES public.ingenieros(rut);


--
-- Name: asignacion id_ingeniero_to_rut_ingeniero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asignacion
    ADD CONSTRAINT id_ingeniero_to_rut_ingeniero FOREIGN KEY (id_ingeniero) REFERENCES public.ingenieros(rut);


--
-- Name: ingenieros ingenieros_especialidad_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingenieros
    ADD CONSTRAINT ingenieros_especialidad_1_fkey FOREIGN KEY (especialidad_1) REFERENCES public.topicos(id);


--
-- Name: ingenieros ingenieros_especialidad_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingenieros
    ADD CONSTRAINT ingenieros_especialidad_2_fkey FOREIGN KEY (especialidad_2) REFERENCES public.topicos(id);


--
-- Name: solicitudes_errores solicitudes_errores_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_errores
    ADD CONSTRAINT solicitudes_errores_autor_fkey FOREIGN KEY (autor) REFERENCES public.usuarios(rut);


--
-- Name: solicitudes_errores solicitudes_errores_topico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_errores
    ADD CONSTRAINT solicitudes_errores_topico_id_fkey FOREIGN KEY (topico_id) REFERENCES public.topicos(id);


--
-- Name: solicitudes_funcionalidad solicitudes_funcionalidad_solicitante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_funcionalidad
    ADD CONSTRAINT solicitudes_funcionalidad_solicitante_fkey FOREIGN KEY (solicitante) REFERENCES public.usuarios(rut);


--
-- Name: solicitudes_funcionalidad solicitudes_funcionalidad_topico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudes_funcionalidad
    ADD CONSTRAINT solicitudes_funcionalidad_topico_id_fkey FOREIGN KEY (topico_id) REFERENCES public.topicos(id);


--
-- PostgreSQL database dump complete
--

CREATE OR REPLACE FUNCTION check_max_solicitudes_funcionalidad()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM solicitudes_funcionalidad
        WHERE solicitante = NEW.solicitante
          AND DATE(fecha_solicitud) = DATE(NEW.fecha_solicitud)
    ) >= 25 THEN
        RAISE EXCEPTION 'No se puede agregar más de 25 solicitudes de funcionalidad por solicitante en la misma fecha';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_max_solicitudes_funcionalidad
BEFORE INSERT ON solicitudes_funcionalidad
FOR EACH ROW
EXECUTE FUNCTION check_max_solicitudes_funcionalidad();


CREATE OR REPLACE FUNCTION check_max_solicitudes_funcionalidad()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM solicitudes_funcionalidad
        WHERE solicitante = NEW.solicitante
          AND DATE(fecha_solicitud) = DATE(NEW.fecha_solicitud)
    ) >= 25 THEN
        RAISE EXCEPTION 'No se puede agregar más de 25 solicitudes de funcionalidad por solicitante en la misma fecha';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_max_errores_por_autor
BEFORE INSERT ON solicitudes_errores
FOR EACH ROW
EXECUTE FUNCTION check_max_errores_por_autor();

CREATE OR REPLACE FUNCTION check_max_asignaciones_ingeniero()
RETURNS TRIGGER AS $$
DECLARE
    total_activo integer := 0;
    ingeniero text;
BEGIN
    FOREACH ingeniero IN ARRAY ARRAY[NEW.id_ingeniero, NEW.id_ingeniero_2, NEW.id_ingeniero_3]
    LOOP
        IF ingeniero IS NOT NULL THEN
            SELECT COUNT(*) INTO total_activo
            FROM asignacion a
            JOIN solicitudes_funcionalidad f ON a.id_caso_f = f.id_caso
            WHERE (a.id_ingeniero = ingeniero OR a.id_ingeniero_2 = ingeniero OR a.id_ingeniero_3 = ingeniero)
              AND (f.estado = 'Abierto' OR f.estado = 'En Progreso')
            UNION ALL
            SELECT COUNT(*)
            FROM asignacion a
            JOIN solicitudes_errores e ON a.id_caso_e = e.id_caso
            WHERE (a.id_ingeniero = ingeniero OR a.id_ingeniero_2 = ingeniero OR a.id_ingeniero_3 = ingeniero)
              AND (e.estado = 'Abierto' OR e.estado = 'En Progreso');

            IF total_activo >= 3 THEN
                RAISE EXCEPTION 'El ingeniero % ya tiene 3 o más asignaciones activas.', ingeniero;
            END IF;
        END IF;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_max_asignaciones_ingeniero
BEFORE INSERT OR UPDATE ON asignacion
FOR EACH ROW
EXECUTE FUNCTION check_max_asignaciones_ingeniero();


