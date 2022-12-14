const User = require('../models/user');
const jwt = require('jsonwebtoken');
const keys = require('../config/keys');
const transporter = require('../config/mailer');

module.exports = {
    async getAll(req, res, next){
        try {
            const data = await User.getAll();
            // console.log(`Usuarios: ${data}`);
            return  res.status(201).json(data);
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Error al obtener los usuarios'
            });
        }
    },

    async login(req,res,next){
        try {
            
            const email = req.body.email;      
            const password = req.body.password;
            const notificationID = req.body.notificationID;
            const myUser = await User.findByEmail(email);
            console.log('myuser',myUser);

            if  (!myUser){
                return res.status(401).json({
                    success: false,
                    message: 'El usuario no fue encontrado',
        
                });
            }else if (!myUser.verificado){
                return res.status(401).json({
                    success: false,
                    message: 'Por favor revisa tu bandeja de entrada para verificar tu email.',
        
                });
            }

            if(User.isPasswordMatched(password,myUser.password)){
                const token = jwt.sign({id: myUser.id, email: myUser.email}, keys.secretOrKey, {
                //    expiresIn: (60*60*24) 
                });
                const data = { 
                    id: myUser.id,
                    hashcode: myUser.hashcode,
                    name: myUser.name,
                    lastname: myUser.lastname,
                    typeID: myUser.typeid,
                    numberID: myUser.numberid,
                    email: myUser.email,
                    phone: myUser.phone,
                    session_token: `JWT ${token}`
                    // roles: myUser.roles
                }
 

                await User.updateToken(myUser.id, `JWT ${token}`);
                await User.updateNotificationID(myUser.id, notificationID);

                // console.log(`Usuaario enviado: ` + data);

                return res.status(201).json({
                    success: true,
                    message: 'Se ha autenticado correctamente',
                    data: data
                });
            }
            else{
                return res.status(401).json({
                    success: false,
                    message: 'La contrase??a es incorrecta',
                    data: {}
                });
            } 
        } 
        
        catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Error al momento de hacer el login',
                error: error
            })
        }
                
        },

    async registerForm(req, res, next){
        try {
            const Info = req.body;
            const form = Info.form;

            if (form == 1){
                const data = await User.createForm1(Info);
                
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 1 (paciente) se realiz?? correctamente.',
                    data: data.id 
                });
            }else if(form == 2){
                console.log('Info condicion',Info);
                for (const i in Info.enfermedades){
                    await User.createFormEnfermedad(Info.idPaciente,Info.enfermedades[i].enfermedad);
                }

                await User.createForm2(Info);
                   
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 2 (condicion) y la enfermedad se realiz?? correctamente.',
                           
                });
            }else if (form == 3){  
                const antecedentes = Info.antecedentes;
                antecedentes.forEach(async element => {
                    await User.createForm3({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });               
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 3 (antecedentes) se realiz?? correctamente.',
                              
                });
            }else if (form == 6){
                const antecedentesF = Info.antecedentesF;
                antecedentesF.forEach(async element => {
                    await User.createForm6({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });      
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 6 (antecedentes fam) se realiz?? correctamente.',
                          
                });
            }
            else if (form == 4){
                const medicamentos = Info.medicamentos;
                medicamentos.forEach(async element => {
                    await User.createForm4({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });  
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 4 (medicamentos) se realiz?? correctamente.',
                           
                });
            }else if (form == 5){
                const alergias = Info.alergias;
                alergias.forEach(async element => {
                    await User.createForm5({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });
                
                return res.status(201).json({
                    success: true,
                    message: 'El formulario 5 (alergias) se realiz?? correctamente.',
                          
                });
            }
        
        } catch (error) {
            console.log(`Error creating: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error con el registro de la informaci??n.',
                error: error
            });
        }
    },

    async registerContact(req, res, next){
        try {
            const contacts = req.body;

            const savedContacts = await User.findContactsById(contacts.idUsuario);
            if (!savedContacts){
                await User.createContact(contacts);
                return res.status(201).json({
                    success: true,
                    message: 'Se ha guardado la informaci??n de contactos correctamente.',
                });
            }else{
                await User.updateContact(contacts);
                return res.status(201).json({
                    success: true,
                    message: 'Se ha actualizado la informaci??n de contactos correctamente.',
                });
            }
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error con el registro de los contactos.',
                error: error
            });
        }
    },

    async registerUser(req, res, next){
        try {
            const user = req.body;   
            const code = req.body.code; 
            console.log('req',req.body);
            const usuarioExiste = await User.findByEmail(user.email);      
            
            if(usuarioExiste){
                return res.status(501).json({
                    success: false,
                    message: 'El usuario ya se encuentra registrado en el sistema.',
                });
            }          
            
            const data = await User.create(user);
            const id = parseInt(data);
            //Creamos un contactos por defecto
            await User.createContact({
                idUsuario: data.id, 
                nombre1: user.name,
                telefono1: user.phone
            });

            let toBas4 = Buffer.from(code).toString('base64');
            const charToReplace = ['=','%','?','/','+']
            charToReplace.forEach((x,i) => {
                toBas4 = toBas4.replaceAll(x,'');
              });
            await User.updateHashCode(toBas4,code);

        try {
            const emailToken = jwt.sign(
                {
                    user: data.id
                },
                keys.emailSecret,
                {
                    expiresIn: '1d'
                }
            );

        const url = `https://api.cuidame.tech/api/users/confirmation/${emailToken}`;
        await transporter.sendMail({
                        to: user.email,
                        subject: '??Confirmaci??n email Cuidame!',
                        html: `Hola ${user.name} Gracias por adquirir nuestros servicios, por favor para confirmar tu email haz click en el siguiente enlace: <a href="${url}">${url}</a>`,
        });
      } catch (e) {
        console.log(e);
      }


            return res.status(201).json({
                success: true,
                message: 'Se ha guardado la informacion correctamente.',
                data: data.id      
            });

        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error con el registro del usuario.',
                error: error
            });
        }
    },

    async verifyUserEmail(req, res, next){ //CREADNO FUNCION DONDE GENERAREMOS EMAIL Y JWT PARA EMAIL.
        try {

            const token = req.params.token;

    
            const tokenInfo = jwt.verify(token,keys.emailSecret);



            const resp = await User.confirmEmail(tokenInfo.user);      

            return res.send('Email confirmado satisfactoriamente');

            return res.status(401).json({
                success: true,
                message: 'Se ha confirmado el email de usuario correctamente.',
            });


        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error con el registro del usuario.',
                error: error
            });
        }
    }, 

    async deleteUser(req, res, next){
        try {
            const email = req.body.email;

            await User.deleteUser(email);
            // await Rol.create(data.id, 1); //Estableciedo rol por defecto (cliente)
            return res.status(201).json({
                success: true,
                message: 'Se ha eliminado su cuenta de usuario y su informaci??n.',
       
                
            });

        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error con el procedimiento.',
                error: error
            });
        }
    },

    async retrieveInfo(req, res, nect){
        try{
            const cod = req.query.codigo;
            const ref = req.query.ref;
            const idPaciente = req.query.id;

            console.log('debug',cod,ref,idPaciente);
            
            if (ref == 'contacts'){
                const idUsuario = req.query.id;
                var data = await User.findContactsById(idUsuario);
            }

            if (ref == 'paciente'){
                var data = await User.findByCod(cod);
                console.log('??debugdata',data);
            }
            if (ref == 'condicion'){
                const enfermedad = await User.findEnfById(idPaciente);
                console.log('enf',enfermedad);
                const enfermedadL = enfermedad.length;
                const condicion = await User.findCondById(idPaciente);
                var data =  [
                    ...enfermedad,
                    ...condicion,
                    enfermedadL
                ];
            }
            if (ref == 'antecedentes'){
                const antP = await User.findAntById(idPaciente);
                const antF = await User.findAntFById(idPaciente);
                const antPL = antP.length;
                const antFL = antF.length;
                var data = [    
                    ...antP,
                    ...antF,
                    antPL, 
                    antFL
                ];

            }
            if (ref == 'medAlergias'){
                const med = await User.findMedById(idPaciente);
                const alergias = await User.findAlerById(idPaciente);
                const medL = med.length;
                const alergiasL = alergias.length;
                var data = [
                    ...med,
                    ...alergias,
                    medL,
                    alergiasL
                ];
            }

            if  (data.length == 0){
                return res.status(401).json({
                    success: false,
                    message: 'Error al traer la informacion (no encontrada)',
        
                });
            }

            return res.status(201).json({
                success: true,
                message: 'Se ha traido la informacion correctamente',
                data: data
            });

        }catch(error){
            console.log(`Hubo un error al tratar de obtener la informacion usersController retrieveInfo${error}`);
            return res.status(501).json({
                message: 'Hubo un error al tratar de obtener la informacion',
                error: error,
                success: false
            })
        }


    },











    //edicion de datos por parte del usuario

   async updateInfo(req,res,next){
        try {
           
            const Info = req.body;
            const form = Info.form;

            if (form == 1){
                await User.updatePaciente(Info);    
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 1 (paciente) se actualiz?? correctamente.'
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                });
            }else if(form == 2){
                await User.deleteInfo(Info.idPaciente,'enfermedades');
                await User.deleteInfo(Info.idPaciente,'condicion');
                for (const i in Info.enfermedades){
                    await User.createFormEnfermedad(Info.idPaciente,Info.enfermedades[i].enfermedad);
                }

                await User.createForm2(Info);
                   
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 2 (condicion) y la enfermedad se actualiz?? correctamente.',
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                           
                });
            }else if (form == 3){ 
                await User.deleteInfo(Info.idPaciente,'antecedentes'); 
                const antecedentes = Info.antecedentes;
                antecedentes.forEach(async element => {
                    await User.createForm3({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });               
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 3 (antecedentes) se actualiz?? correctamente.',
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                              
                });
            }else if (form == 6){
                await User.deleteInfo(Info.idPaciente,'atecedentes_familiares');
                const antecedentesF = Info.antecedentesF;
                antecedentesF.forEach(async element => {
                    await User.createForm6({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });      
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 6 (antecedentes fam) se actualiz?? correctamente.',
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                          
                });
            }
            else if (form == 4){
                await User.deleteInfo(Info.idPaciente,'medicamentos');
                const medicamentos = Info.medicamentos;
                medicamentos.forEach(async element => {
                    await User.createForm4({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });  
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 4 (medicamentos) se actualiz?? correctamente.',
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                           
                });
            }else if (form == 5){
                await User.deleteInfo(Info.idPaciente,'alergias');
                const alergias = Info.alergias;
                alergias.forEach(async element => {
                    await User.createForm5({
                        idPaciente: Info.idPaciente,
                        ...element,
                    });
                });
                return res.status(201).json({
                    success: true,
                    // message: 'El formulario 5 (alergias) se actualiz?? correctamente.',
                    message: 'Proceso exitoso. Los cambios se veran reflejados al iniciar sesi??n.'
                           
                });
            }
        }catch (error) {
                console.log(`Error creating: ${error}`);
                return res.status(501).json({
                    success: false,
                    message: 'Hubo un error con el registro de la informaci??n.',
                    error: error
                });
            }
    }

    

    

}