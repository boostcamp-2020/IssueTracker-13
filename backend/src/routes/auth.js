const express = require('express');
const passport = require('passport');
const router = express.Router();
const {
  loginAsLocal: signInAsLocal,
  signUpAsLocal,
} = require('../services/authService');
require('../services/passportServices');

router.post('/signIn', async (req, res) => {
  const { email, password, authType } = req.body;
  if (authType === 'local') {
    try {
      const signInResponse = await signInAsLocal(email, password);
      res.json(signInResponse);
    } catch (error) {
      res.json({ message: '로그인에 실패했습니다' });
    }
  }
  if (authType === 'apple') {
    // TBD - Apple Oauth 로그인 구현
  }
});

router.post('/signUp', async (req, res) => {
  try {
    const { email, password } = req.body;
    const signUpResponse = await signUpAsLocal(email, password);
    res.json(signUpResponse);
  } catch (error) {
    res.json({ message: '회원가입에 실패했습니다' });
  }
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
