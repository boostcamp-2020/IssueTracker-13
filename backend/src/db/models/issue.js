'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Issue extends Model {
    static associate(models) {
      Issue.belongsTo(models.User, { foreignKey: 'authorId', as: 'author' }); // author
      Issue.belongsToMany(models.User, {
        through: 'Assignees',
        as: 'Assignee',
      });
      Issue.hasMany(models.Comment);
      Issue.belongsToMany(models.Label, {
        through: 'IssueLabels',
      });
      Issue.belongsTo(models.Milestone);
    }
  }
  Issue.init(
    {
      title: DataTypes.STRING,
      isOpen: DataTypes.BOOLEAN,
      isDeleted: DataTypes.BOOLEAN,
      preview: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: 'Issue',
    }
  );
  return Issue;
};
