const UsersController = require('../controllers/usersController');
const AuthController = require('../controllers/authController');
const QrController = require('../controllers/qrController');
const passport = require('passport');
// const QuotesController = require('../controllers/quotesController');
// const CostsController = require('../controllers/costsController');
// const ProductsController = require('../controllers/productsController');
module.exports = (app, upload) => {

    app.get('/api/users/getAll',passport.authenticate('jwt', {session: false}),UsersController.getAll);

    // app.post('/api/users/create2', upload.array('image', 1), UsersController.registerWithImage);
    app.post('/api/users/registerForm', passport.authenticate('jwt', {session: false}),UsersController.registerForm);
    app.get('/api/users/retrieve', UsersController.retrieveInfo);
    app.post('/api/users/registerUser', UsersController.registerUser);
    app.get('/api/users/confirmation/:token', UsersController.verifyUserEmail);//Confirm email to be done  
    app.post('/api/users/deleteUser', UsersController.deleteUser);
    app.post('/api/users/registerContact', passport.authenticate('jwt', {session: false}), UsersController.registerContact);
    
    app.post('/api/users/updateInfo', passport.authenticate('jwt', {session: false}), UsersController.updateInfo);
    app.get('/api/users/verification', UsersController.verifyUserEmail);

    app.post('/api/users/login',UsersController.login);
    app.post('/api/users/bandAuth',AuthController.bandAuth);

    app.get('/api/auth/insertMed',AuthController.ingresoMedico);
    app.get('/api/auth',AuthController.getAuth);
    app.get('/api/auth/bandreq',QrController.findByBandCode);
    app.get('/api/auth/qrCop',QrController.autenticarCop);
    // app.get('/api/qr-sh/:id_user',QuotesController.findByUser);



}   