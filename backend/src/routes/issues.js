const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getIssues,
  addIssue,
  updateIssue,
  deleteIssue,
} = require('../services/issueService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/', async (req, res, next) => {
  try {
    const issues = await getIssues();
    res.status(200).json(issues);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', async (req, res, next) => {
  try {
    const newIssue = req.body;
    await addIssue(newIssue);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(400));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateIssue(modifiedContents);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { title } = req.body;
    await deleteIssue(title);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});


module.exports = router;
