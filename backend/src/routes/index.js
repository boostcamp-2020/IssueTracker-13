const express = require('express');
const router = express.Router();

const authRouter = require('./auth');
const issueRouter = require('./issues');
const labelRouter = require('./labels');
const milestoneRouter = require('./milestones');
const userRouter = require('./users');
const commentRouter = require('./comments');

router.use('/auth', authRouter);
router.use('/issues', issueRouter);
router.use('/labels', labelRouter);
router.use('/milestones', milestoneRouter);
router.use('/users', userRouter);
router.use('/comments', commentRouter);

module.exports = router;
