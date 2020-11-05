const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const { getUsers, addUser, updateUser, deleteUser } = require('../services/userService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/', async (req, res, next) => {
  try {
    const users = await getUsers();
    res.json(users);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', async (req, res, next) => {
  try {
    const newUser = req.body;
    await addUser(newUser);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateUser(modifiedContents);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.body;
    await deleteUser(id);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

module.exports = router;