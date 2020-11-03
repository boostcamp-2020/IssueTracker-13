const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getMilestones,
  addMilestone,
  updateMilestone,
  deleteMilestone,
} = require('../services/milestoneService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/', async (req, res, next) => {
  try {
    const milestones = await getMilestones();
    res.status(200).json(milestones);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', async (req, res, next) => {
  try {
    const newMilestone = req.body;
    await addMilestone(newMilestone);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(400));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateMilestone(modifiedContents);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.body;
    await deleteMilestone(id);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});


module.exports = router;
