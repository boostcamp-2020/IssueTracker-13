const { Issue } = require('../db/models');

const getIssues = async () => {
  const issues = await Issue.findAll({
    where: { isDeleted: false },
  });
  return issues;
};

const addIssue = async (newIssue) => {
  await Issue.create(newIssue);
};

const updateIssues = async (modifiedContents) => {
  const ids = modifiedContents.id;
  delete modifiedContents.id;
  return await Issue.update(
    modifiedContents,
    { where: { id: ids, isDeleted: false } },
  );
};

const deleteIssues = async (id) => {
  return await Issue.update(
    { isDeleted: true },
    { where: { id: id } },
  );
};

module.exports = {
  getIssues,
  addIssue,
  updateIssues,
  deleteIssues,
};
