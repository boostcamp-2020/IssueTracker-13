const passport = require('passport');
const GitHubStrategy = require('passport-github2').Strategy;
const { User } = require('../db/models');

passport.use(new GitHubStrategy({
  clientID: process.env.GITHUB_CLIENT_ID,
  clientSecret: process.env.GITHUB_CLIENT_SECRET,
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
