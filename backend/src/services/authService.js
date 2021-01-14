const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const jwt = require('jsonwebtoken');
const passport = require('passport');
const { User } = require('../db/models');

const jwtPrivateKey = process.env.JWT_SECRET;

const options = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET,
};

passport.use(
  new JwtStrategy(options, async (jwtPayload, done) => {
    try {
      const user = await User.findOne({
        where: {
          id: jwtPayload.id
        },
      });
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

const createToken = (id) => {
  return jwt.sign({ id }, jwtPrivateKey);
};

const signInAsLocal = async (email, password) => {
  const user = await User.findOne({
    where: {
      email,
      password,
      authType: 'local',
      isDeleted: false,
    },
  });
  if (!user) {
    return { message: 'login failed' };
  }
  const { id, userName, profile } = user;
  const token = createToken(id);
  return { name: userName, profile, token };
};

const signUpAsLocal = async (email, password) => {
  const newUserName = email.slice(0, email.search('@'));
  const defaultProfile =
    'https://avatars0.githubusercontent.com/u/68668924?s=400&v=4';
  const user = await User.create({
    email,
    password,
    userName: newUserName,
    profile: defaultProfile,
    authType: 'local',
    isDeleted: false,
  });

  if (!user) {
    return { message: 'signUp failed' };
  }
  const { id, userName, profile } = user;
  const token = createToken(id);
  return { name: userName, profile, token };
};

module.exports = { loginAsLocal: signInAsLocal, signUpAsLocal };
