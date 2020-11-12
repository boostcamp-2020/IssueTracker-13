const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getIssues,
  addIssue,
  updateIssues,
  deleteIssues,
  getIssue,
  updateIssue,
} = require('../services/issueService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/:id', async (req, res, next) => {
  try {
    const issue = await getIssue(req.params.id);
    res.status(200).send(issue);
  } catch (error) {
    next(createError(500));
  }
});

router.get('/', async (req, res, next) => {
  try {
    const { query } = req;
    const issues = await getIssues(query);
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

router.put('/:id', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateIssue(modifiedContents);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    console.log(error);
    next(createError(500));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedContents = req.body;
    await updateIssues(modifiedContents);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

router.delete('/', async (req, res, next) => {
  try {
    const { id } = req.body;
    await deleteIssues(id);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

module.exports = router;
