'use strict';
const {
  Model,
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Milestone extends Model {
    static associate(models) {
      // define association here
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
