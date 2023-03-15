import { user } from '../controllers/usersController'
let d = new Date();
document.body.innerHTML = "<h1>Time right now is:   "+ user + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()