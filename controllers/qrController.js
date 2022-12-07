const QR = require('../models/qr');
const axios = require('axios');
const cheerio = require('cheerio');

// const client = require('../whats-app/whatsapp');
const e = require('express');
const utilidades = require('../utils/utilidades');

const accountSid = 'AC3af222142270c82efd77831c6772b863'; 
const authToken = 'fe17acd033e313f5bfe40fa5e593c4ef'; 
// const client = require('twilio')(accountSid, authToken);


module.exports = {
    async findByCode(req, res, next){

        try{
            const code_request = req.query.code_request;
            const latitude = req.query.latitude;
            const longitude = req.query.longitude;
            const objeto = req.query.objeto;
            const data = await QR.findByCode(code_request);
            // console.log('dataunde',data);
            // const contacts = await QR.findContacts(data.id);
            // console.log("contacts",contacts);

            let contacts;




            if (data){
                contacts = await QR.findContacts(data.id);
                // console.log("contacts",contacts);
                let mensajeEspanol = `${data.name}, el código QR ha sido escaneado`;
                let mensajeIngles = `${data.name}, the QR code has been scanned`;
                console.log('objeto',objeto);
                if (objeto != ''){
                    mensajeEspanol = `${data.name}, tú código QR ha sido escaneado en tu objeto: ${objeto}.`
                }



                let telefonos = Object.values(contacts);

                //REACTIVAR NOTIFICACIONES POR WHATSAPPPPOP

                for(let i=0; i< telefonos.length; i++){
                    if (telefonos[i] != null && telefonos[i] != ""){
                        try{
                            client.sendMessage(`57${telefonos[i]}@c.us`, `${mensajeEspanol}. Toca para mirar la ubicación:
https://maps.google.com/?q=${latitude},${longitude}`);
                        }catch(e){
                            console.log('Error mandando mensaje whatsapp');
                        }

                    }
                    
                  }

                const notification = {
                    "app_id": "d972c946-2ec3-48b7-bf2b-cc89f84320db",
                    "data": {"userId": "PostMan1234"},
                    "contents": {"en": `${mensajeIngles}. Tap to see location`, "es": `${mensajeEspanol}. Toca para mirar la ubicación`},
                    "heading": {"en": "Alerta", "es": "Este es el título"},
                    "include_player_ids": [`${data.notificationid}`],
                    "url": `https://maps.google.com/?q=${latitude},${longitude}`
                };

                // NOTIFICACION TODO: DESCOMENTAR
                axios.post("https://onesignal.com/api/v1/notifications",notification,{
                    headers: {
                        'Content-type': 'application/json',
                        'Authorization': 'Basic MzliM2VmN2EtNDBjNy00ZjY1LTlhYmQtYjNjOTM5MTU0YThh'
                    }
                }).then(response => console.log("response")).catch(error => console.log('Axios error mandando notificacion android by onesignal'));

                return res.status(201).json({
                    message: 'Se ha identificado el código',
                    success: true,
                    data: data
                });
            }else{
                return res.status(401).json({
                    message: 'No se pudo identificar el código',
                    success: false,
                })
            }
        }catch(error){
            console.log('Error en qrControler findbycode',error);
            return res.status(501).json({
                message: 'Hubo un error al tratar de obtener la informacion del usuario',
                error: error,
                success: false
            })
        }


    },
    async newCode(req,res,next){
        try{
            const adminpw = req.body.adminPassword;   
            if (adminpw === process.env.ADMINPW){
                let codes = [];
                const qty = req.body.qty;

                if(!qty || qty === 0){
                    return res.status(401).json({
                        message: "Se debe especificar el parametro 'qty'",
                        success: false,
                    })
                }
                for (var i = 0; i < qty; i++) {
                    const code = utilidades.randomString(16);
                    codes.push(code)     
                    const id = QR.addQrCode(code);
                  }

                return res.status(201).json({
                    message: 'Se ha(n) registrado con exito',
                    success: true,
                    data: codes
                });
            }else{
                return res.status(401).json({
                    message: 'No válido',
                    success: false,
                })
            }
    
            

        }catch(error){
            console.log('Error creando QR',error);
            return res.status(501).json({
                message: 'Hubo un error al tratar de crear el codigo QR',
                error: error,
                success: false
            })
        }
    },

    async autenticarCop(req, res, next){
        const qrUrl = req.query.qrUrl;
        let validQrCop = false;
    
        await axios.get(`${qrUrl}`).then(response => {
                let $ = cheerio.load(response.data);
                $('span').each(function () {
                    if($(this).text().includes('placa')){
                        validQrCop = true;
                    }
                });

        }).catch(error => console.log('Hubo un error mandando req',error));

        if (validQrCop){
            return res.status(201).json({
                message: 'Se ha verificado el policia',
                success: true,
                data: null
            });
        }else{
            return res.status(401).json({
                message: 'No se ha verificado el policia',
                success: false,
                data: null
            });
        }

    }
}

