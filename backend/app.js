var express = require('express');
var app = express();
var cors = require('cors')
var bodyParser = require('body-parser');
var routes = require('./routes/router');
const port = process.env.port || 8081
const dotenv = require('dotenv');

dotenv.config;
app.use(bodyParser.urlencoded())
app.use(bodyParser.json())

app.use('/', routes);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('404 Error');
    err.status = 404;
    next(err);
});
app.use(cors())

// error handler, define as the last app.use callback
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.send(err.message);
});
// listen on port 8081
app.listen(port, function () {
    console.log('Listening on port ' + port + '...');
});

