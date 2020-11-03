const express = require('express');
const router = express.Router();
const createError = require('http-errors');

const {
  getComments,
  addComment,
  updateComment,
} = require('../services/commentService');

const SUCCESS_MESSAGE = { message: 'success' };

router.get('/', async (req, res, next) => {
  try {
    const { issueId } = req.query;
    const comments = await getComments(issueId);
    res.status(200).json(comments);
  } catch (error) {
    next(createError(500));
  }
});

router.post('/', async (req, res, next) => {
  try {
    const newComment = req.body;
    await addComment(newComment);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(400));
  }
});

router.put('/', async (req, res, next) => {
  try {
    const modifiedComment = req.body;
    await updateComment(modifiedComment);
    res.status(200).json(SUCCESS_MESSAGE);
  } catch (error) {
    next(createError(500));
  }
});

module.exports = router;
