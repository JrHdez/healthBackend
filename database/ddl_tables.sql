CREATE TABLE IF NOT EXISTS alergias
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    tipo_alergia character varying(100),
    descripcion character varying(1000),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT alergias_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS antecedentes
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    tipo_antecedente character varying(50),
    descripcion_antecedente character varying(1000),
    fecha_antecedente date,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT antecedentes_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS atecedentes_familiares
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    tipo_antecedente character varying(50),
    parentesco character varying(100),
    descripcion_antecedente character varying(1000),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT atecedentes_familiares_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS codes
(
    id bigint NOT NULL,
    code character varying(100) NOT NULL,
    hashcode character varying(100) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT codes_pkey PRIMARY KEY (id),
    CONSTRAINT codes_code_key UNIQUE (code),
    CONSTRAINT codes_hashcode_key UNIQUE (hashcode)
);

CREATE TABLE IF NOT EXISTS condicion
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    discapacidad character varying(100),
    embarazada character varying(10),
    cicatrices_descripcion character varying(1000),
    tatuajes_descripcion character varying(1000),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT condicion_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS contactos
(
    id bigint NOT NULL,
    id_usuario bigint NOT NULL,
    nombre1 character varying(100),
    telefono1 character varying(50),
    nombre2 character varying(100),
    telefono2 character varying(50),
    nombre3 character varying(100),
    telefono3 character varying(50),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT contactos_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS dbbomberos
(
    id bigint NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula character varying(100) NOT NULL,
    registro_bomberos character varying(100) NOT NULL,
    CONSTRAINT dbbomberos_pkey PRIMARY KEY (id),
    CONSTRAINT dbbomberos_apellidos_key UNIQUE (apellidos),
    CONSTRAINT dbbomberos_cedula_key UNIQUE (cedula),
    CONSTRAINT dbbomberos_nombres_key UNIQUE (nombres),
    CONSTRAINT dbbomberos_registro_bomberos_key UNIQUE (registro_bomberos)
);

CREATE TABLE IF NOT EXISTS dbdefensacivil
(
    id bigint NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula character varying(100) NOT NULL,
    registro_defensa_civil character varying(100) NOT NULL,
    CONSTRAINT dbdefensacivil_pkey PRIMARY KEY (id),
    CONSTRAINT dbdefensacivil_apellidos_key UNIQUE (apellidos),
    CONSTRAINT dbdefensacivil_cedula_key UNIQUE (cedula),
    CONSTRAINT dbdefensacivil_nombres_key UNIQUE (nombres),
    CONSTRAINT dbdefensacivil_registro_defensa_civil_key UNIQUE (registro_defensa_civil)
);

CREATE TABLE IF NOT EXISTS dbmedicina
(
    id bigint NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula character varying(100) NOT NULL,
    registro_medico character varying(100) NOT NULL,
    CONSTRAINT dbmedicina_pkey PRIMARY KEY (id),
    CONSTRAINT dbmedicina_apellidos_key UNIQUE (apellidos),
    CONSTRAINT dbmedicina_cedula_key UNIQUE (cedula),
    CONSTRAINT dbmedicina_nombres_key UNIQUE (nombres),
    CONSTRAINT dbmedicina_registro_medico_key UNIQUE (registro_medico)
);

CREATE TABLE IF NOT EXISTS dbpolicia
(
    id bigint NOT NULL DEFAULT,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    cedula character varying(100) NOT NULL,
    placa character varying(100) NOT NULL,
    CONSTRAINT dbpolicia_pkey PRIMARY KEY (id),
    CONSTRAINT dbpolicia_apellidos_key UNIQUE (apellidos),
    CONSTRAINT dbpolicia_cedula_key UNIQUE (cedula),
    CONSTRAINT dbpolicia_nombres_key UNIQUE (nombres),
    CONSTRAINT dbpolicia_placa_key UNIQUE (placa)
);

CREATE TABLE IF NOT EXISTS enfermedades
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    enfermedad character varying(200),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT enfermedades_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ingreso_salud
(
    id bigint NOT NULL,
    nombres character varying(80) NOT NULL,
    numeroid character varying(80) NOT NULL,
    hora_ingreso timestamp(0) without time zone NOT NULL,
    CONSTRAINT ingreso_salud_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS medicamentos
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    medicamento character varying(100),
    laboratorio character varying(100),
    formula character varying(255),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT medicamentos_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pacientes
(
    id bigint NOT NULL,
    code character varying(100) NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL,
    tipoid character varying(80) NOT NULL,
    numeroid character varying(80) NOT NULL,
    telefono character varying(30) NOT NULL,
    fecha_nacimiento date,
    genero character varying(30) NOT NULL,
    ciudad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    direccion character varying(255) NOT NULL,
    rh character varying(35) NOT NULL,
    eps character varying(50),
    prepagada character varying(50),
    arl character varying(50),
    seguro_funerario character varying(50),
    a_cargo_id bigint NOT NULL,
    image character varying(255),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT pacientes_pkey PRIMARY KEY (id),
    CONSTRAINT pacientes_code_key UNIQUE (code)
);

CREATE TABLE IF NOT EXISTS personal_salud
(
    id bigint NOT NULL,
    tipoid character varying(80) NOT NULL,
    numeroid character varying(80) NOT NULL,
    primer_nombre character varying(255) NOT NULL,
    primer_apellido character varying(255) NOT NULL,
    CONSTRAINT personal_salud_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pertenencias
(
    id bigint NOT NULL,
    id_user bigint NOT NULL,
    hashcode character varying(80) NOT NULL,
    objeto character varying(50) NOT NULL,
    descripcion character varying(500),
    created_at timestamp(0) without time zone,
    CONSTRAINT pertenencias_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users
(
    id bigint NOT NULL,
    code character varying(100) NOT NULL,
    hashcode character varying(200),
    name character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL,
    typeid character varying(100) NOT NULL,
    numberid character varying(80) NOT NULL,
    phone character varying(80) NOT NULL,
    email character varying(255) NOT NULL,
    parentesco character varying(100),
    notificationid character varying(255),
    password character varying(255),
    session_token character varying(255),
    verificado boolean NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_code_key UNIQUE (code),
    CONSTRAINT users_email_key UNIQUE (email),
    CONSTRAINT users_hashcode_key UNIQUE (hashcode),
    CONSTRAINT users_notificationid_key UNIQUE (notificationid)
);

CREATE TABLE IF NOT EXISTS vacunas
(
    id bigint NOT NULL,
    id_paciente bigint NOT NULL,
    vacuna character varying(100),
    updated_at timestamp(0) without time zone NOT NULL,
    CONSTRAINT vacunas_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS alergias
    ADD CONSTRAINT alergias_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS antecedentes
    ADD CONSTRAINT antecedentes_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS atecedentes_familiares
    ADD CONSTRAINT atecedentes_familiares_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS condicion
    ADD CONSTRAINT condicion_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS contactos
    ADD CONSTRAINT contactos_id_usuario_fkey FOREIGN KEY (id_usuario)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS enfermedades
    ADD CONSTRAINT enfermedades_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS medicamentos
    ADD CONSTRAINT medicamentos_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS pacientes
    ADD CONSTRAINT pacientes_a_cargo_id_fkey FOREIGN KEY (a_cargo_id)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS pertenencias
    ADD CONSTRAINT pertenencias_id_user_fkey FOREIGN KEY (id_user)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS users
    ADD CONSTRAINT users_code_fkey FOREIGN KEY (code)
    REFERENCES codes (code) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS users_code_key
    ON users(code);


ALTER TABLE IF EXISTS vacunas
    ADD CONSTRAINT vacunas_id_paciente_fkey FOREIGN KEY (id_paciente)
    REFERENCES pacientes (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


// Drop tables 
DROP TABLE pertenencias;
DROP TABLE alergias;
DROP TABLE antecedentes;
DROP TABLE atecedentes_familiares;
DROP TABLE condicion;
DROP TABLE enfermedades;
DROP TABLE medicamentos;
DROP TABLE vacunas;
DROP TABLE pacientes;
DROP TABLE dbbomberos;
DROP TABLE dbdefensacivil;
DROP TABLE dbmedicina;
DROP TABLE dbpolicia;
DROP TABLE contactos;
DROP TABLE mascotas;
DROP TABLE users;
DROP TABLE codes;
DROP TABLE agreementCodes;




// Testing


DROP TABLE IF EXISTS dbPolicia CASCADE;
CREATE TABLE dbPolicia(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	placa VARCHAR(100)  NOT NULL UNIQUE
);


DROP TABLE IF EXISTS dbBomberos CASCADE;
CREATE TABLE dbBomberos(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_bomberos VARCHAR(100)  NOT NULL UNIQUE
);


DROP TABLE IF EXISTS dbDefensaCivil CASCADE;
CREATE TABLE dbDefensaCivil(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_defensa_civil VARCHAR(100)  NOT NULL UNIQUE
);


DROP TABLE IF EXISTS dbMedicina CASCADE;
CREATE TABLE dbMedicina(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_medico VARCHAR(100)  NOT NULL UNIQUE
);

DROP TABLE IF EXISTS codes CASCADE;
CREATE TABLE codes(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,
	hashcode VARCHAR(100) NOT NULL UNIQUE,
	license VARCHAR(50) NOT NULL UNIQUE,  <- nuevo campo para especificar el tipo de licencia de la pulsera
	created_at TIMESTAMP(0) NOT NULL
);

-> New table asociated to users (customers)

DROP TABLE IF EXISTS license CASCADE;
CREATE TABLE license(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,   <- 9 chatacters Alfanumerical
	agreement VARCHAR(50) NOT NULL UNIQUE,
	discount DECIMAL(10) NOT NULL UNIQUE,
	price NUMBER(100) NOT NULL UNIQUE,
	total NUMBER(100) NOT NULL UNIQUE,
	created_at TIMESTAMP(0) NOT NULL
);



varios convenios con las empresas


DROP TABLE IF EXISTS users CASCADE;  -> Change to customers
CREATE TABLE users(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,
	licenseCode VARCHAR(100) NOT NULL UNIQUE,
	hashcode VARCHAR(200) NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	typePerson VARCHAR(100) NOT NULL,   <- Natural y juridica (nuevo campo)
	typeID VARCHAR(100) NOT NULL,     <- Agregar valor tipo NIT (CC, CE, PASSPORT, ETC)
	numberID VARCHAR(80) NOT NULL,
	phone VARCHAR(80) NOT NULL ,
	email VARCHAR(255) NOT NULL UNIQUE,
	parentesco VARCHAR(100) NULL,
	notificationID VARCHAR(255)  NULL UNIQUE,
	password VARCHAR(255)  NULL,
	session_token VARCHAR(255) NULL,
	verificado BOOLEAN NOT NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (code) REFERENCES codes(code) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (licenseCode) REFERENCES license(code) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS pertenencias;
CREATE TABLE pertenencias(
	id BIGSERIAL PRIMARY KEY,
	id_user BIGINT NOT NULL,
	hashcode VARCHAR(80) NOT NULL,
	objeto VARCHAR(50) NOT NULL,
	descripcion VARCHAR(1000) NULL,
	created_at TIMESTAMP(0) NULL,
	FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);	

DROP TABLE IF EXISTS mascotas;
CREATE TABLE mascotas(
	id BIGSERIAL PRIMARY KEY,
	id_usuario BIGINT NOT NULL,
	hashcode VARCHAR(80) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	especie VARCHAR(50) NOT NULL,
	raza VARCHAR(50) NOT NULL,
	descripcion VARCHAR(1000) NOT NULL,
	created_at TIMESTAMP(0) NULL,
	FOREIGN KEY (id_usuario) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);	


DROP TABLE IF EXISTS pacientes CASCADE;
CREATE TABLE pacientes(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	tipoID VARCHAR(80) NOT NULL,
	numeroID VARCHAR(80) NOT NULL,
	telefono VARCHAR(30) NOT NULL,
	fecha_nacimiento DATE NULL,
	genero VARCHAR(30) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	departamento VARCHAR(50) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	rh VARCHAR(35) NOT NULL,
	eps VARCHAR(50) NULL ,
	prepagada VARCHAR(50) NULL,
	arl VARCHAR(50) NULL,
	seguro_funerario VARCHAR(50) NULL,
	a_cargo_id BIGINT NOT NULL,
	image VARCHAR(255) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (a_cargo_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS enfermedades CASCADE;
CREATE TABLE enfermedades(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	enfermedad VARCHAR(200)  NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE

);



DROP TABLE IF EXISTS condicion CASCADE;
CREATE TABLE condicion(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,	
	discapacidad VARCHAR(100) NULL,
	embarazada VARCHAR(10) NULL,
	cicatrices_descripcion VARCHAR(1000) NULL,
	tatuajes_descripcion VARCHAR(1000) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS antecedentes;
CREATE TABLE antecedentes(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	tipo_antecedente VARCHAR(50) NULL,
	descripcion_antecedente VARCHAR(1000) NULL,
	fecha_antecedente DATE NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS atecedentes_familiares;
CREATE TABLE atecedentes_familiares(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	tipo_antecedente VARCHAR(50) NULL,
	parentesco VARCHAR(100) NULL,
	descripcion_antecedente VARCHAR(1000) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS medicamentos;
CREATE TABLE medicamentos(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	medicamento VARCHAR(100) NULL,
	laboratorio VARCHAR(100) NULL,
	formula VARCHAR(255) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS alergias;
CREATE TABLE alergias(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	tipo_alergia VARCHAR(100) NULL,
	descripcion VARCHAR(1000) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS vacunas;
CREATE TABLE vacunas(
	id BIGSERIAL PRIMARY KEY,
	id_paciente BIGINT NOT NULL,
	vacuna VARCHAR(100) NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	created_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS contactos;
CREATE TABLE contactos(
	id BIGSERIAL PRIMARY KEY,
	id_usuario BIGINT NOT NULL,
	nombre VARCHAR(100) NULL,
	telefono VARCHAR(50) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);



DROP TABLE IF EXISTS personal_salud;
CREATE TABLE personal_salud(
	id BIGSERIAL PRIMARY KEY,
	tipoID VARCHAR(80) NOT NULL,
	numeroID VARCHAR(80) NOT NULL,
    primer_nombre VARCHAR(255) NOT NULL,
	primer_apellido VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ingreso_salud;
CREATE TABLE ingreso_salud(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(80) NOT NULL,
	numeroID VARCHAR(80) NOT NULL,
	hora_ingreso TIMESTAMP(0) NOT NULL
);	



ALTER TABLE users
ADD COLUMN agreementCode VARCHAR;


ALTER TABLE users
   ADD CONSTRAINT agreementCode
   FOREIGN KEY (codes) 
   REFERENCES agreementCodes (code);