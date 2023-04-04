const jwt = require('jsonwebtoken');
function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET)
}

function generateRefreshToken(user) {
  const refreshToken = jwt.sign({ "username": user }, process.env.REFRESH_TOKEN_SECRET);
  return refreshToken;
}

const isAuthenticated = async (req, res, next) => {
  const token =
    req.body.token || req.query.token || req.headers["x-access-token"];

  if (!token) {
    return res.status(403).json({ "status": 0, "reason": "A token is required for authentication", "data": {} });
  }
  try {
    const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    req.username = decoded;
  } catch (err) {
    return res.status(401).json({ "status": 0, "reason": err.message, "data": {} });
  }
  return next();
};

module.exports = { generateAccessToken, generateRefreshToken, isAuthenticated };