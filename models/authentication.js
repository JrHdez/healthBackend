const db = require('../config/config');
const crypto = require("crypto");

const Authentication = {};

Authentication.getAuthPolicia = (numeroID, auth) => {
    console.log(numeroID,auth);
    sql = `
    SELECT 
        * 
    FROM 
        dbpolicia
    WHERE
        cedula=$1 AND placa=$2  
    `;
    return db.oneOrNone(sql,[numeroID,auth]);
}

Authentication.getAuthBombero = (numeroID,auth) => {
    sql = `
    SELECT 
        * 
    FROM 
        dbbomberos
    WHERE
        cedula=$1 AND registro_bomberos=$2
    `;
    return db.oneOrNone(sql,[numeroID,auth]);
}

Authentication.getAuthDefensaCivil = (numeroID,auth) => {
    sql = `
    SELECT 
        * 
    FROM 
        dbdefensacivil
    WHERE
        cedula=$1 ADN registro_defensa_civil=$2
    `;
    return db.oneOrNone(sql,[numeroID,auth]);
}

Authentication.getAuthMedicina = (numeroID,auth) => {
    sql = `
    SELECT 
        * 
    FROM 
        dbmedicina
    WHERE
        cedula=$1 AND registro_medico=$2
    `;
    return db.oneOrNone(sql,[numeroID,auth]);
}

Authentication.findByBandCode = (bandCode) => {
    sql = `
    SELECT 
        * 
    FROM 
        bands
    WHERE
        code=$1
    `;
    return db.oneOrNone(sql,bandCode);
}

Authentication.findUserRBand = (bandCode) => {
    sql = `
    SELECT 
        * 
    FROM 
        users
    WHERE
        bandcode=$1
    `;
    return db.oneOrNone(sql,bandCode);
}


module.exports = Authentication;