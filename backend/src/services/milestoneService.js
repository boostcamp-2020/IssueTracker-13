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
    { where: { id: modifiedContents.id } },
  );
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
