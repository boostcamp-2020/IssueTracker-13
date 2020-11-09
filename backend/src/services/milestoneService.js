const { Milestone, Issue } = require('../db/models');

// 마일스톤아이디에 해당되는 전체 issue 개수
const getAllIssueCountAboutMilestone = async (milestoneId) => {
  const allIssueCount = await Issue.count({
    where: {
      MilestoneId: milestoneId,
      isDeleted: false,
    },
  });

  return allIssueCount;
};

// 마일스톤아이디에 해당되는 완료된 issue 개수
const getClosedIssueCountAboutMilestone = async (milestoneId) => {
  const cloesdIssueCount = Issue.count({
    where: {
      MilestoneId: milestoneId,
      isOpen: false,
      isDeleted: false,
    },
  });

  return cloesdIssueCount;
};

const addIssueInfoInMilestone = async (milestones) => {
  return await Promise.all(
    milestones.map(async (milestone) => {
      const allIssueCount = await getAllIssueCountAboutMilestone(milestone.id);
      const closedIssueCount = await getClosedIssueCountAboutMilestone(
        milestone.id
      );

      return {
        ...milestone,
        allIssueCount: allIssueCount,
        closedIssueCount: closedIssueCount,
      };
    })
  );
};

const getMilestones = async () => {
  const milestones = await Milestone.findAll({
    raw: true,
    where: {
      isDeleted: false,
    },
    attributes: ['id', 'title', 'description', 'dueDate'],
  });

  return await addIssueInfoInMilestone(milestones);
};

const addMilestone = async (newMilestone) => {
  return await Milestone.create(newMilestone);
};

const updateMilestone = async (modifiedContents) => {
  return await Milestone.update(modifiedContents, {
    where: { id: modifiedContents.id },
  });
};

const deleteMilestone = async (id) => {
  return await Milestone.update(
    { isDeleted: true },
    { where: { id } }
  );
};

module.exports = {
  getMilestones,
  addMilestone,
  updateMilestone,
  deleteMilestone,
};
