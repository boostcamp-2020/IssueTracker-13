'use strict';
const {
  Model,
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Issue extends Model {
    static associate(models) {
      // define association here
    }
  }
  Issue.init({
    title: DataTypes.STRING,
    isOpen: DataTypes.BOOLEAN,
    isDeleted: DataTypes.BOOLEAN,
    preview: DataTypes.STRING,
  }, {
    sequelize,
    modelName: 'Issue',
  });
  return Issue;
};
