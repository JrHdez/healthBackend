require('dotenv').config();
const express = require('express'); //Importar paquete
const app = express();  //Inicializar nuestra app
const http = require('http'); //Importar Http
const server = http.createServer(app);//Crear servidorcoi
const logger = require('morgan'); //Error handler
const cors = require('cors');
const passport = require('passport');
const session = require('express-session')
const cookieParser = require('cookie-parser');
const Keys = require('./config/keys');
/*
* RUTAS
*/
const users = require('./routes/usersRoutes');
// const wp = require('./whats-app/whatsapp');

// if(process.env.NODE_ENV !== 'production')


const port = process.env.PORT || 3000; //Definir puerto que escucha nuestro servidor
app.use(logger('dev')); //Logger para desarrollo para debugar erroes
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use(cors());



// app.use(cookieParser(Keys.secretOrKey));
// app.use(session({
//     secret: Keys.secretOrKey,
//     resave: false,
//     saveUninitialized: false
// }));

app.use(passport.initialize());
app.use(passport.session());

require('./config/passport')(passport);

app.disable('x-powered-by');


app.set('port', port); //Confiturar puerto

//Llamandoa las rutas
users(app);


// server.listen(3000,'10.14.50.181' || 'localhost', function(){
server.listen(app.get('port'), function(){
    console.log('Aplicacion de NodeJS ' + port + ' Iniciada...')
});

app.get('/',(req,res)=>{
    res.send('Ruta raiz del backend para SMARTHEALTH');
})

//  ERROR HANDLER
app.use((err,req,res,next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
})