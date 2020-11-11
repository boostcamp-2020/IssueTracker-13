'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      User.hasMany(models.Issue, {
        foreignKey: 'authorId',
      });
      User.hasMany(models.Comment);
      User.belongsToMany(models.Issue, {
        through: 'Assignees',
      });
    }
  }
  User.init(
    {
      email: DataTypes.STRING,
      password: DataTypes.STRING,
      userName: DataTypes.STRING,
      profile: DataTypes.STRING,
      authType: DataTypes.STRING,
      isDeleted: DataTypes.BOOLEAN,
      oAuthId: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: 'User',
    }
  );
  return User;
};
