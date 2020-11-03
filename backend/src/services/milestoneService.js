const { Milestone } = require('../db/models');

const getMilestones = async () => {
  const milestones = await Milestone.findAll({
    where: {
      isDeleted: false,
    },
  });
  return milestones;
};

const addMilestone = async (newMilestone) => {
  return await Milestone.create(newMilestone);
};

const updateMilestone = async (modifiedContents) => {
  return await Milestone.update(
    modifiedContents,
    { where: { title: modifiedContents.title } },
  );
};

const deleteMilestone = async (title) => {
  return await Milestone.update(
    { isDeleted: true },
    { where: { title: title } },
  );
};

module.exports = {
  getMilestones,
  addMilestone,
  updateMilestone,
  deleteMilestone,
};
