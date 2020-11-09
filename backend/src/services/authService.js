const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const jwt = require('jsonwebtoken');
const passport = require('passport');
const { User } = require('../db/models');

const options = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET,
};

passport.use(
  new JwtStrategy(options, async (jwtPayload, done) => {
    try {
      const user = await User.findOne({ id: jwtPayload.sub });
      if (user) {
        done(null, user);
      } else {
        done(null, false);
      }
    } catch (error) {
      done(error, false);
    }
  })
);

const privateKey = process.env.JWT_SECRET;

const createToken = async (userName, password) => {
  const user = await User.findOne({
    where: {
      userName,
      password,
      authType: 'local',
      isDeleted: false,
    },
  });
  const token = jwt.sign({ id: user.id }, privateKey);
  return token;
};

module.exports = { createToken };
