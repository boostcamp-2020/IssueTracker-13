const createError = require('http-errors');
const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const router = require('./src/routes');

const app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/', router);

app.use((req, res, next) => {
  next(createError(404));
});

app.use((req, res) => {
  res.status(404).send('error');
});

module.exports = app;
