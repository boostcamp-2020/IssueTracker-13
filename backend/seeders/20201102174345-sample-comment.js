'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Comments', [{
      userId: 1,
      description: '레이블 전체 목록을 볼 수 있는게 어떨까요',
      issueId: 1,
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      userId: 2,
      description: '긍정적인 기능이네요',
      issueId: 1,
      createdAt: new Date(),
      updatedAt: new Date(),
    }]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Comments', null, {});
  },
};
