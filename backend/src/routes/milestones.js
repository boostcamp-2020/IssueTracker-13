const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const { getMilestones } = require('../services/milestoneService');

router.get('/', async (req, res, next) => {
  try {
    const milestones = await getMilestones();
    res.json(milestones);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', (req, res) => {
  res.json();
});

router.put('/', (req, res) => {
  res.json();
});

router.delete('/', (req, res) => {
  res.json();
});


module.exports = router;
