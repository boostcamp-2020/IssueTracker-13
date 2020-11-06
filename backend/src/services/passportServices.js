const passport = require('passport');
const GitHubStrategy = require('passport-github2').Strategy;
const { User } = require('../db/models');

passport.use(new GitHubStrategy({
  clientID: process.env.CLIENT_ID_GITHUB,
  clientSecret: process.env.CLIENT_SECRET_GITHUB,
  callbackURL: 'http://localhost:3000/api/auth/github/callback',
  session: false,
},
async (accessToken, refreshToken, profile, callback) => {
  console.log(profile);
  const user = await User.findOrCreate({
    where: { userName: profile.username },
    defaults: { password: null, profile: profile._json.avatar_url, authType: 'github', isDeleted: false },
  });
  return callback(null, user);
},
));
