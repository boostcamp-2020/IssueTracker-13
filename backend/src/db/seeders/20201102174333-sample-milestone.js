'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Milestones', [
      {
        title: '1주차 - Web',
        description: '1주차 Web Milestone',
        dueDate: new Date('2020-10-30'),
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        title: '1주차 - iOS',
        description: '1주차 iOS Milestone',
        dueDate: new Date('2020-10-30'),
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Milestones', null, {});
  },
};
