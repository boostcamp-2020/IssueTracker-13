const express = require('express');
const passport = require('passport');
const router = express.Router();
const { createToken } = require('../services/authService');
require('../services/passportServices');

router.post('/signIn', async (req, res) => {
  const { userName, password } = req.body;
  const token = await createToken(userName, password);
  res.json({ token });
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
