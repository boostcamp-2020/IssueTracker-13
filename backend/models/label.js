'use strict';
const {
  Model,
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Label extends Model {
    static associate(models) {
      Label.belongsToMany(models.Issue, {
        through: 'IssueLabels',
      });
    }
  }
  Label.init({
    title: DataTypes.STRING,
    description: DataTypes.STRING,
    color: DataTypes.STRING,
    backgroundColor: DataTypes.STRING,
    isDeleted: DataTypes.BOOLEAN,
  }, {
    sequelize,
    modelName: 'Label',
  });
  return Label;
};
