var express = require('express');
var router = express.Router();
var user = require('./user')
require('dotenv').config();

//Users
router.post('/register', user.register);
router.post('/login', user.login);

module.exports = router;