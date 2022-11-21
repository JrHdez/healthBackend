const Auth = require('../models/authentication');

module.exports = {
    async getAuth(req, res, nect){
        try{
            const numeroID = req.query.numeroID;
            const authentication = req.query.authentication;
            const persona = req.query.persona;
            // console.log(authentication);
            switch(persona){
                case 'Policia':
                    var authFound = await Auth.getAuthPolicia(numeroID,authentication);
                    break
                case 'Bombero':
                    var authFound = await Auth.getAuthBombero(numeroID,authentication);
                    break
                case 'Defensa civíl':
                    var authFound = await Auth.getAuthDefensaCivil(numeroID,authentication);
                    break    
                case 'Personal médico':
                var authFound = await Auth.getAuthMedicina(numeroID,authentication);
                break
            }
            console.log(authFound);

            // console.log(`Cotizacion ${JSON.stringify(auth)}`);
            if  (!authFound){
                return res.status(401).json({
                    success: false,
                    message: 'No fue posible autenticar',
        
                });
            }

            return res.status(201).json({
                success: true,
                message: 'Se ha autenticado correctamente',
                data: authFound
            });
            
        }catch(error){
            console.log(`Error al obtener cotizaciones ${error}`);
            return res.status(501).json({
                message: 'Hubo un error al tratar de obtener la autenticacion',
                error: error,
                success: false
            })
        }


    },
    async bandAuth(req,res,next){
        try {
            
            const code = req.body.code;      
            const pin = req.body.pin;
            const myBand = await Auth.findByBandCode(code);

            if  (!myBand){
                return res.status(401).json({
                    success: false,
                    message: 'Código o pin de la banda no es válido',
        
                });
            }

            const userRband = await Auth.findUserRBand(code);

            if (userRband){
                return res.status(401).json({
                    success: false,
                    message: 'Esta banda ya se encuentra en uso',
        
                });
            }

            if( pin == myBand.pin ){
                return res.status(201).json({
                    success: true,
                    message: 'Banda autenticada correctamente',
                    data: ''
                });
            }
            else{
                return res.status(401).json({
                    success: false,
                    message: 'Pin de la banda no es válido',
                    data: {}
                });
            } 
        } 
        
        catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Error al momento de autenticación',
                error: error
            })
        }
                
        },


        async ingresoMedico(req, res, nect){
            try{
                const nombres = req.query.nombres
                const numeroID = req.query.numeroID;

                const data = await Auth.insertMed(nombres,numeroID);
                
                console.log(data);
    
                if  (!data){
                    return res.status(401).json({
                        success: false,
                        message: 'Hubo un error en la base de datos',
            
                    });
                }
    
                return res.status(201).json({
                    success: true,
                    message: 'Se ha registrado su informacion',
                    data
                });
                
            }catch(error){
                console.log(`Error al obtener cotizaciones ${error}`);
                return res.status(501).json({
                    message: 'Hubo un error al registrar su información médica',
                    error: error,
                    success: false
                })
            }
    
    
        },




}