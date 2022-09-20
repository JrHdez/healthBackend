const db = require('../config/config');

const Qr = {};

Qr.findByBandCode = (bandCode) => {
    const sql = `
        SELECT
            id,
            bandCode,
            name,
            lastname,
            phone,
            email,
            notificationID
        FROM
            users
        WHERE
            bandCode = $1
    `;
    return db.oneOrNone(sql, bandCode);
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