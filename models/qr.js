const db = require('../config/config');

const Qr = {};

Qr.addQrCode = (code) => {
    const sql = `
        INSERT INTO
            codes(
                code,
                created_at
            )
        VALUES($1, $2) RETURNING id
    `;
    return db.oneOrNone(sql, [code, new Date()])
}

Qr.findByCode = (code) => {
    const sql = `
        SELECT
            id,
            hashcode,
            name,
            lastname,
            phone,
            email,
            notificationID
        FROM
            users
        WHERE
            hashcode = $1
    `;
    console.log('sql',sql);
    return db.oneOrNone(sql, code);
}

Qr.findContacts = (idUsuario) => {

    const sql = `
    SELECT
            telefono1,
            telefono2,
            telefono3
        FROM
            public.contactos
        WHERE
            id_usuario = $1
    `;
    return db.oneOrNone(sql, idUsuario);
}


module.exports = Qr;