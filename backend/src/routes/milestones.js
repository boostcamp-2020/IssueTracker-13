const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getMilestones,
  addMilestone,
  updateMilestone,
  deleteMilestone,
} = require('../services/milestoneService');

const SUCCESS_MESSAGE = (method) => `${method} success`;

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

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateMilestone(modifiedContents);
    res.json(SUCCESS_MESSAGE('put'));
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.body;
    await deleteMilestone(id);
    res.json(SUCCESS_MESSAGE('delete'));
  } catch (error) {
    next(createError(500));
  }
});


module.exports = router;
