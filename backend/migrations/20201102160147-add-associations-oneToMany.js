'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.addColumn(
      'Issues',
      'author',
      {
        type: Sequelize.INTEGER,
        references: {
          model: 'Users',
          key: 'id',
        },
      },
    );
    await queryInterface.addColumn(
      'Issues',
      'milestoneId',
      {
        type: Sequelize.INTEGER,
        references: {
          model: 'Milestones',
          key: 'id',
        },
      },
    );
    await queryInterface.addColumn(
      'Comments',
      'userId',
      {
        type: Sequelize.INTEGER,
        references: {
          model: 'Users',
          key: 'id',
        },
      },
    );
    await queryInterface.addColumn(
      'Comments',
      'issueId',
      {
        type: Sequelize.INTEGER,
        references: {
          model: 'Issues',
          key: 'id',
        },
      },
    );
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.removeColumn(
      'Issues',
      'author',
    );
    await queryInterface.removeColumn(
      'Issues',
      'milestoneId',
    );
    await queryInterface.removeColumn(
      'Comments',
      'userId',
    );
    await queryInterface.removeColumn(
      'Comments',
      'issueId',
    );
  },
};
