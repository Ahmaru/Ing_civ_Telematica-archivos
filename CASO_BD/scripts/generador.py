import random
from datetime import datetime, timedelta

# ==========================================
# CONFIGURACIÓN Y CATÁLOGOS BASE
# ==========================================
CANTIDAD_POSTULACIONES = 300
CANTIDAD_EMPRESAS = 80
CANTIDAD_USUARIOS = 50

# Nombres y apellidos chilenos genéricos
nombres = [
    "Juan",
    "Camila",
    "Diego",
    "Valentina",
    "Matias",
    "Javiera",
    "Sebastian",
    "Fernanda",
    "Nicolas",
    "Sofia",
    "Felipe",
    "Isidora",
]
apellidos = [
    "Perez",
    "Gonzalez",
    "Soto",
    "Contreras",
    "Silva",
    "Rojas",
    "Diaz",
    "Munoz",
    "Tapia",
    "Lagos",
    "Moya",
    "Herrera",
]

# Datos temáticos (Telemática, Redes, Sistemas)
palabras_empresa = [
    "Tech",
    "Net",
    "Telematics",
    "Ciber",
    "Data",
    "Infra",
    "Core",
    "Sys",
]
iniciativas_nombres = [
    "Implementación de Redes OSPF",
    "Migración a Infraestructura Huawei",
    "Despliegue de Switches Cisco",
    "Auditoría de Ciberseguridad Perimetral",
    "Optimización de Almacenamiento BTRFS",
    "Normalización de Base de Datos 3NF",
    "Sistema de Monitoreo IoT",
    "Configuración de Dual-Boot Corporativo",
    "Automatización de Rutas Telemáticas",
    "Despliegue de Nodos de Fibra Óptica",
]
roles_equipo = [
    "Ingeniero de Redes",
    "Especialista en Ciberseguridad",
    "Administrador BTRFS",
    "Consultor Técnico",
    "Analista de Datos",
    "Arquitecto de Soluciones",
    "Desarrollador",
]
etapas_nombres = [
    "Levantamiento de topología",
    "Diseño de red",
    "Configuración de enrutadores",
    "Pruebas de conectividad",
    "Despliegue en producción",
    "Auditoría de seguridad",
    "Normalización de datos",
]

# Lógica para garantizar mínimos exactos
# Garantizamos que las 5 sedes aparezcan al menos 20 veces (5 * 60 = 300)
sedes_distribuidas = [1, 2, 3, 4, 5] * 60
random.shuffle(sedes_distribuidas)

# Garantizamos que las 16 regiones aparezcan al menos 1 vez
regiones_ejecucion = ([i for i in range(1, 17)] * 20)[:300]
regiones_impacto = ([i for i in range(1, 17)] * 20)[:300]
random.shuffle(regiones_ejecucion)
random.shuffle(regiones_impacto)


# Generador de RUT aleatorio formato chileno
def generar_rut():
    return f"{random.randint(10000000, 26000000)}-{random.choice('0123456789K')}"


# ==========================================
# INICIO DE ESCRITURA DEL ARCHIVO SQL
# ==========================================
with open("datos_masivos_ct_usm.sql", "w", encoding="utf-8") as f:
    f.write("-- DUMP DE DATOS MASIVOS SINTÉTICOS\n")
    f.write("USE `postulaciones_ct_usm`;\n\n")

    # 1. Generar 80 Empresas
    print("Generando 80 empresas...")
    ruts_empresas = []
    for i in range(CANTIDAD_EMPRESAS):
        rut = generar_rut()
        ruts_empresas.append(rut)
        nombre = f"{random.choice(palabras_empresa)} {random.choice(apellidos)} {random.choice(['SpA', 'S.A.', 'Ltda.'])}"
        nom_rep = f"{random.choice(nombres)} {random.choice(apellidos)}"
        mail = f"contacto@{nombre.split()[0].lower()}.cl"
        tel = f"+569{random.randint(11111111, 99999999)}"
        convenio = random.choice([0, 1])
        tamano = random.choice([1, 2, 3])

        sql = f"INSERT IGNORE INTO empresa (rut_empresa, nombre, nombre_representante, mail_representante, telefono_representante, convenio_USM, id_tamaño_empresa) VALUES ('{rut}', '{nombre}', '{nom_rep}', '{mail}', '{tel}', {convenio}, {tamano});\n"
        f.write(sql)
    f.write("\n")

    # 2. Generar 50 Usuarios (Integrantes + Credenciales) distribuidos en roles 1,2,3
    print("Generando 50 usuarios y credenciales...")
    ruts_usuarios = []
    for i in range(CANTIDAD_USUARIOS):
        rut = generar_rut()
        ruts_usuarios.append(rut)
        nombre_completo = f"{random.choice(nombres)} {random.choice(nombres)} {random.choice(apellidos)}"
        dpto = random.choice(
            ["Informática", "Telemática", "Redes", "Obras Civiles", "Industrias"]
        )
        mail = f"usuario{i}@usm.cl"
        tel = f"9{random.randint(11111111, 99999999)}"
        sede = random.choice([1, 2, 3, 4, 5])
        tipo_int = random.choice([1, 2])  # 1:Profesor, 2:Estudiante

        # Insertar Integrante
        sql_int = f"INSERT IGNORE INTO integrantes (nombre, rut, dpto, mail, telefono, id_sede, id_tipo) VALUES ('{nombre_completo}', '{rut}', '{dpto}', '{mail}', '{tel}', {sede}, {tipo_int});\n"
        f.write(sql_int)

        # Insertar Credencial (Roles 1, 2, 3 distribuidos equitativamente)
        rol_credencial = (i % 3) + 1
        pass_hash = "$2y$10$YLILR7bbRjTJUCCY8Y63e.roYwEuBg7nPmow5eC3N7M3PRZQognf2"  # Hash genérico de prueba
        sql_cred = f"INSERT IGNORE INTO credenciales (rut, password, id_tipo) VALUES ('{rut}', '{pass_hash}', {rol_credencial});\n"
        f.write(sql_cred)
    f.write("\n")

    # 3. Generar 300 Postulaciones
    print("Generando 300 postulaciones, equipos y etapas...")
    # Asumimos que el auto_increment empezará desde el 20 en adelante por los datos de prueba que ya tienes
    codigo_interno_actual = 20

    for i in range(CANTIDAD_POSTULACIONES):
        num_postulacion = f"POST-1{codigo_interno_actual:03d}"
        fecha = datetime(2026, random.randint(1, 5), random.randint(1, 28)).strftime(
            "%Y-%m-%d"
        )
        nombre_iniciativa = (
            f"{random.choice(iniciativas_nombres)} Fase {random.randint(1, 5)}"
        )
        obj = f"Optimizar procesos usando tecnologías de la información."
        sol = f"Implementación de arquitectura robusta y escalable."
        res = f"Reducción de latencia en un {random.randint(10, 40)}%."
        presupuesto = random.randint(1, 50) * 1000000
        empresa = random.choice(ruts_empresas)
        sede = sedes_distribuidas[i]
        reg_ejec = regiones_ejecucion[i]
        reg_impc = regiones_impacto[i]
        tipo_ini = random.choice([1, 2])
        estado = random.choice([1, 2, 3, 4, 5])

        sql_post = f"INSERT INTO postulacion (codigo_interno, numero_postulacion, fecha_postulacion, nombre_iniciativa, objetivo, descripcion_soluciones, resultados_esperados, presupuesto, rut_empresa, id_sede, id_reg_ejec, id_reg_impc, id_tipo_iniciativa, id_estado_postulacion) VALUES ({codigo_interno_actual}, '{num_postulacion}', '{fecha}', '{nombre_iniciativa}', '{obj}', '{sol}', '{res}', {presupuesto}.00, '{empresa}', {sede}, {reg_ejec}, {reg_impc}, {tipo_ini}, {estado});\n"
        f.write(sql_post)

        # 4. Generar Equipo de Trabajo (Mínimo 8, máximo 12)
        tamano_equipo = random.randint(8, 12)
        miembros_asignados = random.sample(ruts_usuarios, tamano_equipo)

        for idx, rut_miembro in enumerate(miembros_asignados):
            rol = "Jefe de Proyecto" if idx == 0 else random.choice(roles_equipo)
            es_resp = 1 if idx == 0 else 0
            sql_eq = f"INSERT IGNORE INTO equipo_trabajo (codigo_interno, rut, rol, es_responsable) VALUES ({codigo_interno_actual}, '{rut_miembro}', '{rol}', {es_resp});\n"
            f.write(sql_eq)

        # 5. Generar Etapas (Mínimo 3, máximo 5)
        num_etapas = random.randint(3, 5)
        etapas_seleccionadas = random.sample(etapas_nombres, num_etapas)

        for etapa in etapas_seleccionadas:
            plazo = random.randint(2, 12)
            entregable = f"Documento de {etapa.lower()}"
            sql_etapa = f"INSERT INTO etapa (nombre_etapa, semanas_plazo, entregable, codigo_interno_e) VALUES ('{etapa}', {plazo}, '{entregable}', {codigo_interno_actual});\n"
            f.write(sql_etapa)

        f.write("\n")
        codigo_interno_actual += 1

print("¡Archivo datos_masivos_ct_usm.sql generado con éxito!")
