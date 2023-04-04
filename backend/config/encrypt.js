const bcrypt = require("bcryptjs")

async function hashPassword(plaintextPassword) {
    return await bcrypt.hash(plaintextPassword, 10);
}

async function comparePassword(plaintextPassword, hash) {
    const result = await bcrypt.compare(plaintextPassword, hash);
    return result;
}

module.exports = { hashPassword, comparePassword };