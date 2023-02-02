










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
DROP TABLE IF EXISTS bands CASCADE;
CREATE TABLE bands(
	id BIGSERIAL PRIMARY KEY,
	code VARCHAR(20) NOT NULL UNIQUE,
	pin VARCHAR(100) NOT NULL UNIQUE,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL
);

INSERT INTO bands VALUES(1,'SHB001A','1234','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(2,'SHB002A','1235','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(3,'SHB003A','1236','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(4,'SHB004A','12345','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(5,'SHB005A','12346','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(6,'SHB006A','12347','2021-01-01','2021-01-01');

-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO stcolomb_junior-smarteK;

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
	id BIGSERIAL PRIMARY KEY,
	bandCode VARCHAR(20) NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	typeID VARCHAR(100) NOT NULL,
	numberID VARCHAR(80) NOT NULL ,
	phone VARCHAR(80) NOT NULL ,
	email VARCHAR(255) NOT NULL UNIQUE,
	parentesco VARCHAR(100) NOT NULL,
	notificationID VARCHAR(255)  NULL UNIQUE,
	password VARCHAR(255)  NULL,
	session_token VARCHAR(255) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
	FOREIGN KEY (bandCode) REFERENCES bands(code) ON UPDATE CASCADE ON DELETE CASCADE
);

-- INSERT INTO users VALUES(100,'SHB001A','Javier','Perez','CC','123123123','#01311129', 'javi','Padre','12345','token','2020-12-12','2020-12-12');
-- INSERT INTO users VALUES(200,'SHB002A','Javier','Perez','CC','123123113','#01112129', 'javiER','Hijo','12345','token','2020-12-12','2020-12-12');




DROP TABLE IF EXISTS pacientes CASCADE;
CREATE TABLE pacientes(
	id BIGSERIAL PRIMARY KEY,
	bandCode VARCHAR(20) NOT NULL UNIQUE,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	tipoID VARCHAR(80) NOT NULL,
	numeroID VARCHAR(80) NOT NULL,
	telefono VARCHAR(30) NOT NULL,
	edad VARCHAR(20) NULL,
	genero VARCHAR(30) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	departamento VARCHAR(50) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	rh VARCHAR(35) NOT NULL,
	eps VARCHAR(50) NULL ,
	prepagada VARCHAR(50) NULL,
	arl VARCHAR(50) NULL,
	seguro_funerario VARCHAR(50) NULL,
	a_cargo_id BIGINT NULL,
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

	SELECT 
			pac.id,
			nombre,
			apellido,
			fecha_nacimiento,
			genero AS Género,
			ciudad,
			departamento,
			direccion,
			rh,
			prepagada,
			arl,
			seguro_funerario AS "Seguro funerario",
			a_cargo AS "Persona a Cargo",
			a_cargo_parentesco AS "Parentesco",
			a_cargo_telefono AS "Telefono persona a cargo",
			
			discapacidad,
			cod_diagnostico AS "Cód. diagnóstico",
			diagnostico,
			condicion_especial AS "Condicion especial",
			cod_diagnostico_condicion_especial AS "Cód. diagnóstico",
			diagnostico_condicion_especial AS "Diagnostico condición",
			embarazada,
			cicatrices,
			cicatrices_lugar AS "Lugar Cicatriz",
			cicatrices_descripcion AS "Descripción cicatriz",
			tatuajes,
			tatuajes_lugar AS "Lugar tatuajes",
			tatuajes_descripcion AS "Descripción tatuajes",
			
			tipo_antecedente as "Tipo de antecedente",
			descripcion_antecedente as "Descripción antecedente",
			fecha_antecedente,
			tipo_antecedente_f as "Antecedente familiar",
			parentesco_f as "Parentesco",
			descripcion_antecedente_f as "Descripcion"
		FROM 
			pacientes as pac
		LEFT JOIN 
			condicion as cond
		ON 
			pac.id=cond.id_paciente
		LEFT JOIN 
			medicamentos as med
		ON 
			pac.id=med.id_paciente
		LEFT JOIN
			antecedentes as ant
		ON
			pac.id=ant.id_paciente
		WHERE 
			cod = 'SHB01A'
		



-- QUERY BANDAS

DELETE FROM bands;

INSERT INTO bands VALUES(1,'SHB001A','esmartb01A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(2,'SHB002A','esmartb02A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(3,'SHB003A','esmartb03A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(4,'SHB004A','esmartb04A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(5,'SHB005A','esmartb05A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(6,'SHB006A','esmartb06A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(7,'SHB006A','esmartb07A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(8,'SHB006A','esmartb08A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(9,'SHB006A','esmartb09A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(10,'SHB006A','esmartb10A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(11,'SHB006A','esmartb11A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(12,'SHB006A','esmartb12A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(13,'SHB006A','esmartb13A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(14,'SHB006A','esmartb14A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(15,'SHB006A','esmartb15A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(16,'SHB006A','esmartb16A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(17,'SHB006A','esmartb17A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(18,'SHB006A','esmartb18A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(19,'SHB006A','esmartb19A','2021-01-01','2021-01-01');
INSERT INTO bands VALUES(20,'SHB006A','esmartb20A','2021-01-01','2021-01-01');


