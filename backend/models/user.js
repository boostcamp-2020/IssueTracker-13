'use strict';
const {
  Model,
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      // define association here
    }
  }
  User.init({
    userName: DataTypes.STRING,
    password: DataTypes.STRING,
    profile: DataTypes.STRING,
    authType: DataTypes.STRING,
    isDeleted: DataTypes.BOOLEAN,
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};
