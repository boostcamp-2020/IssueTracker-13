'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.bulkInsert('Issues', [{
      title: '레이블 목록 보기 구현',
      isOpen: true,
      isDeleted: false,
      preview: '레이블 전체 목록을 볼 수 있어야 한다. 2줄까지 보입니다.',
      createdAt: new Date(),
      updatedAt: new Date(),
      authorId: 1,
      milestoneId: 1,
    },
    {
      title: '마일스톤 목록 보기 구현',
      isOpen: true,
      isDeleted: false,
      preview: '마일스톤 전체 목록을 볼 수 있어야 한다. 길면 뒷부분이 ... 잘린다',
      createdAt: new Date(),
      updatedAt: new Date(),
      authorId: 2,
      milestoneId: 2,
    }]);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Issues', null, {});
  },
};

