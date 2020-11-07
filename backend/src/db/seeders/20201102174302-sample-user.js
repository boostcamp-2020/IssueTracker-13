'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Users', [
      {
        userName: 'junsushin-dev',
        password: 'junsushin-devpw',
        profile:
          'https://avatars3.githubusercontent.com/u/32405358?s=400&u=cbda272c344b4c9e35cc1ee452f0bc4eae7e34c3&v=4',
        authType: 'local',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        userName: 'parkdit94',
        password: 'parkdit94pw',
        profile:
          'https://avatars1.githubusercontent.com/u/52442237?s=400&u=48c1ef65d9f5094f65f99e02dd1191656c57425f&v=4',
        authType: 'local',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        userName: 'passwd10',
        password: 'pwsswd10pw',
        profile: 'https://avatars0.githubusercontent.com/u/68668924?s=400&v=4',
        authType: 'local',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Users', null, {});
  },
};
