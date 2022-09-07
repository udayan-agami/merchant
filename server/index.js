var express = require('express');
var cors = require('cors');

var app = express();
app.use(cors({
   origin: '*'
}));

app.get('/phone', function(req, res, next){
   res.json({error: false, message: "Otp sent"})
   console.warn('otp sent to '+req.query.phone)
});
app.listen(3000);