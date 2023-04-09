const db = require('../config/db');
const encrypted = require('../config/encrypt');
const util = require('util');
const jwt = require('../config/jwt');
var connection = null;

exports.register = async function (req, res, next) {
    connection = db.createConnection();
    connection.connect();
    var sql = "INSERT INTO USERS (USERNAME, PASSWORD) VALUES (?, ?)";
    var password = await encrypted.hashPassword(req.body.password);
    var values = [req.body.username, password]
    connection.query(sql, values, (err, result, fields) => {
        if (err) {
            res.json({ "status": 0, "reason": err.message })
            return
        }
        res.json({ "status": 1, "reason": "" })
    });
    connection.end();
}

exports.login = async function (req, res, next) {
    connection = db.createConnection();
    var sql = 'SELECT * FROM USERS WHERE USERNAME = "' + req.body.username + '"';
    const query = util.promisify(connection.query).bind(connection);
    (async () => {
        try {
            const rows = await query(sql);
            if (rows.length > 0) {
                if (await encrypted.comparePassword(req.body.password, rows[0].password)) {
                    let data = {
                        username: req.body.username,
                        date: Date()
                    }
                    let token = jwt.generateAccessToken(data);
                    res.json({ "status": 1, "reason": "", "username": req.body.username, "accessToken": token })
                    return;
                }
                else {
                    res.json({ "status": 0, "reason": "Login Fail", "username": "", "accessToken": "" });
                    return;
                }
            }
            else {
                res.json({ "status": 0, "reason": "Login Fail", "username": "", "accessToken": "" });
                return;
            }
        }
        catch (error) {
            res.json({ "status": 0, "reason": error.message, "username": "", "accessToken": "" })
            return;
        }
        finally {
            connection.end();
        }
    })()
}

exports.refreshToken = async function (req, res, next) {
    try {
        const token = jwt.generateRefreshToken(req.body.username);
        res.json({ "status": 1, "reason": "", "username": req.body.username, "accessToken": token })
        return;
    }
    catch (error) {
        res.json({ "status": 0, "reason": error.message, "username": req.body.username, "accessToken": "" })
        return;
    }
}