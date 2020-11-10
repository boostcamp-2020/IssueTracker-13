'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Labels', [
      {
        title: 'enhancement',
        description: 'New feature or request',
        color: '#000000',
        backgroundColor: '#a2eeef',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        title: 'bug',
        description: "Something isn't working",
        color: '#FFFFFF',
        backgroundColor: '#d73a4a',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        title: 'documentation',
        description: 'Improvements or additions to documentation',
        color: '#FFFFFF',
        backgroundColor: '#0075ca',
        isDeleted: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Labels', null, {});
  },
};
