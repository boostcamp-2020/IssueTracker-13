const express = require('express');
const passport = require('passport');
const router = express.Router();
require('../services/passportServices');

router.post('/signIn', (req, res) => {
  res.json();
});

router.post('/signUp', (req, res) => {
  res.json();
});

router.get(
  '/github/callback',
  passport.authenticate('github', {
    failureRedirect: '/login',
    session: false,
  }),
  (req, res) => res.redirect('/')
);

router.get('/github', passport.authenticate('github', { session: false }));

module.exports = router;
