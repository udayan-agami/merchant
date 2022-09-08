var express = require('express');
var cors = require('cors');
var jwt = require('jsonwebtoken');
var app = express();

app.use(cors({
   origin: '*'
}));

app.get('/phone', function(req, res){
   res.json({error: false, message: "Otp sent"})
   console.warn('otp sent to '+req.query.phone)
});

app.get('/verifyotp', function(req, res){
   res.json({error: req.query.code == '111-111' ? false : true, message: "verified", token: jwt.sign({ phone: req.query.phone }, 'B1Dus8WL!o&qmdIBJnPyMzXlg0I*WQ*XG2g0aHGS1tSigwztj1', { expiresIn: '100d' })})
});


app.listen(3000);