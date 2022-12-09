const db = require('../config/config');
const crypto = require("crypto");
const { oneOrNone } = require('../config/config');

const User = {};

User.getAll = () => {
    const sql = `
    SELECT 
        * 
    FROM
        users
    `;

    return db.manyOrNone(sql);
}

User.findbyId = (id, callback)=>{

    const sql = `
    SELECT 
        id,
        name,
        lastname,
        typeID,
        numberID,
        phone,
        email,
        password,
        session_token
    FROM
        users
    WHERE
        id = $1
    `
    return db.oneOrNone(sql,id).then(user => {callback(null, user);})

}


User.findByEmail = (email) => {
    const sql = `
    SELECT
        id,
        hashcode,
        name,
        lastname,
        typeID,
        numberID,
        phone,
        email,
        password,
        verificado
    FROM
        users
    WHERE
        email = $1    
    `;
    return db.oneOrNone(sql,email);
}

User.confirmEmail = (idUser) => {
    const sql = `
    UPDATE
        users
    SET
        verificado = true
    WHERE
        id = $1
    `
    return db.none(sql,idUser);
}

User.create = (user) => {

    const myPasswordHashed = crypto.createHash('md5').update(user.password).digest('hex');
    user.password = myPasswordHashed;

    const sql = `
    INSERT INTO 
        users(
            code,
            name,
            lastname,
            typeID,
            numberID,
            phone,
            email,
            parentesco,
            password,
            verificado,
            created_at,
            updated_at
        )
    VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) RETURNING id
    `;
    return db.oneOrNone(sql, [
        user.code,
        user.name,
        user.lastname,
        user.typeID,
        user.numberID,
        user.phone,
        user.email,
        user.parentesco,
        user.password,
        false,
        new Date(),
        new Date()
    ]);
}

User.updateHashCode = (hashcode, code) => {
    const sql = `
        UPDATE
            users
        SET 
            hashcode = $1
        WHERE
            code = $2
    `;
    return db.none(sql,[hashcode, code])
}

User.deleteUser = (user_email) => {

    const sql = `
    DELETE FROM 
        users
    WHERE
        email = $1
    `;
    return db.none(sql,user_email);

}


User.createForm1 = (user) => {
    const sql = `
    INSERT INTO 
        pacientes(
            code,
            nombre,
            apellido,
            tipoID,
            numeroID,
            telefono,
            edad,
            genero,
            ciudad,
            departamento,
            direccion,
            rh,
            eps,
            prepagada,
            arl,
            seguro_funerario,
            a_cargo_id,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19) RETURNING id
    `;

    return db.oneOrNone(sql, [
        user.code,
        user.nombres,
        user.apellidos,
        user.tipoID,
        user.numeroID,
        user.telefono,
        user.edad,
        user.genero,
        user.ciudad,
        user.departamento,
        user.direccion,
        user.rh,
        user.eps,
        user.prepagada,
        user.arl,
        user.seguroFunerario,
        user.aCargoId,
        new Date(),
        new Date()
    ]);
}

User.createFormEnfermedad = (idPaciente, enfermedad) => {

    const sql = `
    INSERT INTO 
        enfermedades(
            id_paciente,
            enfermedad,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4)
    `;

    return db.oneOrNone(sql, [
        idPaciente,
        enfermedad,
        new Date(),
        new Date()
    ]);
}

User.createForm2 = (info) => {


    const sql = `
    INSERT INTO 
        condicion(
            id_paciente,
            discapacidad,
            embarazada,
            cicatrices_descripcion,
            tatuajes_descripcion,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6, $7)
    `;

    return db.oneOrNone(sql, [
        info.idPaciente,
        info.discapacidad,
        info.embarazada,
        info.cicatricesDescripcion,
        info.tatuajesDescripcion,
        new Date(),
        new Date()
    ]);
}

User.createForm3 = (info) => {


    const sql = `
    INSERT INTO 
        antecedentes(
            id_paciente,
            tipo_antecedente,
            descripcion_antecedente,
            fecha_antecedente,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6)
    `;

    return db.oneOrNone(sql, [
        info.idPaciente,
        info.tipoAntecedente,
        info.descripcionAntecedente,
        info.fechaAntecedente,
        new Date(),
        new Date()
    ]);
}

User.createForm6 = (info) => {


    const sql = `
    INSERT INTO 
        atecedentes_familiares(
            id_paciente,
            tipo_antecedente,
            parentesco,
            descripcion_antecedente,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6)
    `;

    return db.oneOrNone(sql, [
        info.idPaciente,
        info.tipoAntecedenteF,
        info.parentescoF,
        info.descripcionAntecedenteF,
        new Date(),
        new Date()
    ]);
}

User.createForm4 = (info) => {


    const sql = `
    INSERT INTO 
        medicamentos(
            id_paciente,
            medicamento,
            laboratorio,
            formula,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6);
    `;

    return db.oneOrNone(sql, [
        info.idPaciente,
        info.medicamento,
        info.laboratorio,
        info.formula,
        new Date(),
        new Date()        
    ]);
}

User.createForm5 = (info) => {


    const sql = `
    INSERT INTO 
         alergias(
            id_paciente,
            tipo_alergia,
            descripcion,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5)
    `;

    return db.oneOrNone(sql, [
        info.idPaciente,
        info.tipoAlergia,
        info.descripcion,
        new Date(),
        new Date()
    ]);
}

User.createContact = (info) => {
    const sql = `
    INSERT INTO 
         contactos(
            id_usuario,
            nombre1,
            telefono1,
            nombre2,
            telefono2,
            nombre3,
            telefono3,
            created_at,
            updated_at
        )   
    VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id
    `;

    return db.oneOrNone(sql, [
        info.idUsuario,
        info.nombre1,
        info.telefono1,
        info.nombre2,
        info.telefono2,
        info.nombre3,
        info.telefono3,
        new Date(),
        new Date()
    ]);
}

User.updateContact = (info) => {
    const sql = `
    UPDATE 
        contactos
    SET
		nombre1 = $2,
        telefono1 = $3,
        nombre2 = $4,
        telefono2 = $5,
        nombre3 = $6,
        telefono3 = $7,
        updated_at = $8
    WHERE 
        id_usuario = $1
        `;

    return db.none(sql,[
        info.idUsuario,
        info.nombre1,
        info.telefono1,
        info.nombre2,
        info.telefono2,
        info.nombre3,
        info.telefono3,
        new Date()
    ]);
}


User.findByCod = (cod) => {
    const sql = `
    SELECT
    a_cargo_id, 
        pacientes.id, 
        nombre as "Nombre del paciente",
        apellido as "Apellido del paciente",
        tipoid as "Tipo de identificación",
        numeroid as "Número de identificación",
        telefono,
        edad,
        genero,
        direccion,
        ciudad,
        departamento,
        rh,
        eps,
        prepagada,
        arl,
        seguro_funerario as "Seguro funerario",
        name as "Nombre del pariente",
        parentesco,
        phone as "Teléfono de pariente"
    FROM 
        pacientes
    LEFT JOIN users ON pacientes.a_cargo_id = users.id
    WHERE 
        pacientes.code = $1
        `;
    return db.manyOrNone(sql,cod);

    // id,
    // nombre AS "nombres",
    // apellido AS "apellidos",
    // edad,
    // genero AS Género,
    // ciudad,
    // departamento,
    // direccion,
    // rh,
    // eps,
    // prepagada,
    // arl,
    // seguro_funerario AS "Seguro funerario"

}

User.findContactsById = (id_usuario) => {
    const sql = `
    SELECT 
		nombre1,
        telefono1,
        nombre2,
        telefono2,
        nombre3,
        telefono3
    FROM 
        contactos 
    WHERE 
        id_usuario = $1
        `;

    return db.oneOrNone(sql,id_usuario);
}



User.findCondById = (id_paciente) => {
    const sql = `
    SELECT 
		discapacidad,
		embarazada,
		cicatrices_descripcion AS "cicatrices",
		tatuajes_descripcion AS "tatuajes"
    FROM 
        condicion 
    WHERE 
        id_paciente = $1
        `;

    return db.manyOrNone(sql,id_paciente);


}

User.findEnfById = (id_paciente) => {
    const sql = `
    SELECT 
		enfermedad
    FROM 
        enfermedades 
    WHERE 
        id_paciente = $1
        `;

    return db.manyOrNone(sql,id_paciente);


}

User.findAntById = (id_paciente) => {
    const sql = `
    SELECT 
        tipo_antecedente as "tipoAntecedente",
        descripcion_antecedente as "descripcionAntecedente",
        TO_CHAR(fecha_antecedente :: DATE, 'yyyy-mm-dd') as "fechaAntecedente"

        
    FROM 
        antecedentes 
    WHERE 
        id_paciente = $1
        `;
    return db.manyOrNone(sql,id_paciente);

}


User.findAntFById = (id_paciente) => {
    const sql = `
    SELECT 
        tipo_antecedente as "tipoAntecedenteF",
        parentesco as "parentescoF",
        descripcion_antecedente as "descripcionAntecedenteF"
    FROM 
        atecedentes_familiares
    WHERE 
        id_paciente = $1
        `;
    return db.manyOrNone(sql,id_paciente);

}

User.findMedById = (id_paciente) => {
    const sql = `
    SELECT 
        medicamento,
        laboratorio,
        formula AS "Dosis"
    FROM 
        medicamentos 
    WHERE 
        id_paciente = $1
        `;
    return db.manyOrNone(sql,id_paciente);

}

User.findAlerById = (id_paciente) => {
    const sql = `
    SELECT 
        tipo_alergia AS "tipoAlergia",
        descripcion
    FROM 
        alergias 
    WHERE 
        id_paciente = $1
        `;
    return db.manyOrNone(sql,id_paciente);
}

User.updateToken = (id, token) => {
    const sql = `
    UPDATE  
        users
    SET
        session_token = $2
    WHERE
        id = $1
    `;

    return db.none(sql, [id,token]);
}

User.updateNotificationID = (id, notificationID) => {

    const sql = `
    UPDATE  
        users
    SET
        notificationid = null
    WHERE
        notificationid = $2;
    UPDATE  
        users
    SET
        notificationid = $2
    WHERE
        id = $1
    `;
    return db.none(sql, [id,notificationID]);
    }






User.isPasswordMatched = (candidatePassword, hash) => {
    const myPasswordHashed = crypto.createHash('md5').update(candidatePassword).digest('hex');
    if(myPasswordHashed === hash) {
        return true;
    }
    return false;
}




//EDICION DE LA INFORMACION POR EL CLIENTE

User.deleteInfo = (id_paciente,tabla) => {
    sql = `
    DELETE FROM
        ${tabla}
    WHERE
        id_paciente = $1
    `
    return db.none(sql, id_paciente);
}

User.updatePaciente = info => {
    sql = `
    UPDATE
        pacientes
    SET
        nombre = $1,
        apellido = $2,
        tipoID = $3,
        numeroID = $4,
        telefono = $5,
        edad = $6,
        genero = $7,
        ciudad = $8,
        departamento = $9,
        direccion = $10,
        rh = $11,
        eps = $12,
        prepagada = $13,
        arl = $14,
        seguro_funerario = $15,
        updated_at = $16
    WHERE
        id = $17
    `
    return db.none(sql,[
        info.nombres,
        info.apellidos,
        info.tipoID,
        info.numeroID,
        info.telefono,
        info.edad,
        info.genero,
        info.ciudad,
        info.departamento,
        info.direccion,
        info.rh,
        info.eps,
        info.prepagada,
        info.arl,
        info.seguroFunerario,
        new Date(),
        info.idPaciente
    ]);
}


module.exports = User;