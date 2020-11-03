const express = require('express');
const router = express.Router();
const createError = require('http-errors');
const { getLabels, addLabel, updateLabel, deleteLabel } = require('../services/labelService');

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
    await addLabel(req.body);
    res.sendStatus(201);
  } catch (error) {
    next(createError(500));
  }
});

router.put('/', async (req, res, next) => {
  try {
    await updateLabel(req.body);
    res.sendStatus(204);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    await deleteLabel(req.body);
    res.sendStatus(204);
  } catch (error) {
    next(createError(500));
  }
});

module.exports = router;
