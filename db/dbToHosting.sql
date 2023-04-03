
CREATE USER stcolomb_junior WITH PASSWORD 'Espinosa99.';

DROP TABLE IF EXISTS dbPolicia CASCADE;
CREATE TABLE dbPolicia(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	placa VARCHAR(100)  NOT NULL UNIQUE
);

insert into dbPolicia values('1','Julian','Perez','2312312','PA1245');


DROP TABLE IF EXISTS dbBomberos CASCADE;
CREATE TABLE dbBomberos(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_bomberos VARCHAR(100)  NOT NULL UNIQUE
);

insert into dbBomberos values('1','Carlos','López','1231235','BF4510');

DROP TABLE IF EXISTS dbDefensaCivil CASCADE;
CREATE TABLE dbDefensaCivil(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_defensa_civil VARCHAR(100)  NOT NULL UNIQUE
);

insert into dbDefensaCivil values('1','Alirio','Vásquez','1231235','DC9045');

DROP TABLE IF EXISTS dbMedicina CASCADE;
CREATE TABLE dbMedicina(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(100) NOT NULL UNIQUE,
	apellidos VARCHAR(100) NOT NULL UNIQUE,
	cedula VARCHAR(100) NOT NULL UNIQUE,
	registro_medico VARCHAR(100)  NOT NULL UNIQUE
);

insert into dbMedicina values('1','Cristian','Hernandez','12355232','MG2131');


-- CREATE USER stcolomb_junior-smartek WITH PASSWORD 'esmart2021health';

DROP TABLE IF EXISTS codes CASCADE;
CREATE TABLE codes(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,
	hashcode VARCHAR(100) NOT NULL UNIQUE,
	created_at TIMESTAMP(0) NOT NULL
);


DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(100) NOT NULL UNIQUE,
	hashcode VARCHAR(200) NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	typeID VARCHAR(100) NOT NULL,
	numberID VARCHAR(80) NOT NULL ,
	phone VARCHAR(80) NOT NULL ,
	email VARCHAR(255) NOT NULL UNIQUE,
	parentesco VARCHAR(100) NULL,
	notificationID VARCHAR(255)  NULL UNIQUE,
	password VARCHAR(255)  NULL,
	session_token VARCHAR(255) NULL,
	verificado BOOLEAN NOT NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (code) REFERENCES codes(code) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Update users SET verificado = true WHERE id=1;

-- GRANT ALL PRIVILEGES ON TABLE users TO stcolomb_junior-smartek;
-- GRANT ALL PRIVILEGES ON TABLE users TO postgres;
-- INSERT INTO users VALUES(100,'SHB001A','Javier','Perez','CC','123123123','#01311129', 'javi','Padre','12345','token','2020-12-12','2020-12-12');
-- INSERT INTO users VALUES(200,'SHB002A','Javier','Perez','CC','123123113','#01112129', 'javiER','Hijo','12345','token','2020-12-12','2020-12-12');

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
	FOREIGN KEY (id_user) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
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

-- INSERT INTO pacientes VALUES (1,'SHB001A','Child','Hdez','CC','41241234','17','masc','flordia','santander','doag','o+','am','na','na','na',1,'','2020-01-01','2020-01-01');
-- INSERT INTO pacientes VALUES (2,'SHB002A','Child','Hdez','CC','41261234','17','masc','flordia','santander','doag','o+','am','na','na','na',1,'','2020-01-01','2020-01-01');

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
	-- cicatrices_lugar VARCHAR(50) NULL,
	cicatrices_descripcion VARCHAR(1000) NULL,
	-- tatuajes_lugar VARCHAR(50) NULL,
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
	FOREIGN KEY (id_paciente) REFERENCES pacientes(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS contactos;
CREATE TABLE contactos(
	id BIGSERIAL PRIMARY KEY,
	id_usuario BIGINT NOT NULL,
	nombre1 VARCHAR(100) NULL,
	telefono1 VARCHAR(50) NULL,
	nombre2 VARCHAR(100) NULL,
	telefono2 VARCHAR(50) NULL,
	nombre3 VARCHAR(100) NULL,
	telefono3 VARCHAR(50) NULL,
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


COPY public.producto FROM 'C:\PSQL\cuidame\personal_medico.csv' DELIMITER ';' CSV HEADER;
COPY public.personal_medico FROM '/home/junior_hernandeze/personal_medico.csv' DELIMITER ';' CSV HEADER;

DROP TABLE IF EXISTS ingreso_salud;
CREATE TABLE ingreso_salud(
	id BIGSERIAL PRIMARY KEY,
	nombres VARCHAR(80) NOT NULL,
	numeroID VARCHAR(80) NOT NULL,
	hora_ingreso TIMESTAMP(0) NOT NULL
);	

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to stcolomb_junior;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to stcolomb_junior;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public to stcolomb_junior;