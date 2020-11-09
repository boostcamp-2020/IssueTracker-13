'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('IssueLabels', [
      {
        issueId: 1,
        labelId: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        issueId: 1,
        labelId: 2,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('IssueLabels', null, {});
  },
};
