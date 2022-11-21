const nodemailer = require("nodemailer");
let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
      user: process.env.EMAIL, // generated ethereal user
      pass: process.env.EMAILPW, // generated ethereal password
    },
  });

  transporter.verify().then( () => {
    console.log('Ready to send emails')
  });

  module.exports = transporter;