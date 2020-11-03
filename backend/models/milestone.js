'use strict';
const {
  Model,
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Milestone extends Model {
    static associate(models) {
      Milestone.hasMany(models.Issue);
    }
  }
  Milestone.init({
    title: DataTypes.STRING,
    description: DataTypes.STRING,
    dueDate: DataTypes.DATE,
    isDeleted: DataTypes.BOOLEAN,
  }, {
    sequelize,
    modelName: 'Milestone',
  });
  return Milestone;
};
