var mysql = require('mysql2');

function createConnection() {
    var connection = mysql.createConnection({
        host: 'localhost',
        database: 'Financial_Program',
        user: 'root',
        password: 'Abcd1234'
    });
    return connection;
}


module.exports.createConnection = createConnection;