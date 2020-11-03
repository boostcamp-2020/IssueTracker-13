const { Milestone } = require('../db/models');

const getMilestones = async () => {
  const milestones = await Milestone.findAll({
    whiere: {
      isDeleted: false,
    },
  });
  return milestones;
};

const addMilestone = () => {

};

const updateMilestone = () => {

};

const deleteMilestone = () => {
  //isDeleted true로 변경
};

module.exports = { getMilestones };
