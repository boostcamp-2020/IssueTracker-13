'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable(
      'Assignees',
      {
        userId: {
          type: Sequelize.INTEGER,
          primaryKey: true,
        },
        issueId: {
          type: Sequelize.INTEGER,
          primaryKey: true,
        },
        createdAt: {
          allowNull: false,
          type: Sequelize.DATE,
        },
        updatedAt: {
          allowNull: false,
          type: Sequelize.DATE,
        },
      },
    );
    await queryInterface.createTable(
      'IssueLabels',
      {
        issueId: {
          type: Sequelize.INTEGER,
          primaryKey: true,
        },
        labelId: {
          type: Sequelize.INTEGER,
          primaryKey: true,
        },
        createdAt: {
          allowNull: false,
          type: Sequelize.DATE,
        },
        updatedAt: {
          allowNull: false,
          type: Sequelize.DATE,
        },
      },
    );
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('Assignees');
    await queryInterface.dropTable('IssueLabels');
  },
};
