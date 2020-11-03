const { Milestone } = require('../db/models');

const getMilestones = async () => {
  const milestones = await Milestone.findAll({
    where: {
      isDeleted: false,
    },
  });
  return milestones;
};

const addMilestone = () => {

};

const updateMilestone = () => {

};

const deleteMilestone = async (id) => {
  return await Milestone.update(
    { isDeleted: true },
    { where: { id: id } },
  );
};

module.exports = {
  getMilestones,
  addMilestone,
  updateMilestone,
  deleteMilestone,
};
