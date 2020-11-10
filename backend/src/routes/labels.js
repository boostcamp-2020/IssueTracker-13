const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getLabels,
  addLabel,
  updateLabel,
  deleteLabel,
} = require('../services/labelService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/', async (req, res, next) => {
  try {
    const labels = await getLabels();
    res.json(labels);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', async (req, res, next) => {
  try {
    const newLabel = req.body;
    await addLabel(newLabel);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateLabel(modifiedContents);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.body;
    await deleteLabel(id);
    res.send(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

module.exports = router;
