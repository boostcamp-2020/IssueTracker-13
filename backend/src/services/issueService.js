const { Issue } = require('../db/models');

const getIssues = async () => {
  const issues = await Issue.findAll({
    where: {
      isDeleted: false,
    },
  });
  console.log('issue : ', issues);
  return issues;
};

const addIssue = async (newIssue) => {
  return await Issue.create(newIssue);
};

const updateIssue = async (modifiedContents) => {
  return await Issue.update(
    modifiedContents,
    { where: { title: modifiedContents.title } },
  );
};

const deleteIssue = async (title) => {
  return await Issue.update(
    { isDeleted: true },
    { where: { title: title } },
  );
};

module.exports = {
  getIssues,
  addIssue,
  updateIssue,
  deleteIssue,
};
