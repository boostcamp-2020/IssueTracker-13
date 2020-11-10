const { Issue, User, Label, Milestone } = require('../db/models');

const applyOptionInQuery = (query) => {
  const finalOption = { isDeleted: false };
  const tableOption = {
    milestone: { model: Milestone, attributes: [] },
    author: { model: User, as: 'author' },
    assignee: { model: User, as: 'Assignee', through: { attributes: [] } },
    label: { model: Label, through: { attributes: [] } },
  };

  for (const key in query) {
    if (key === 'isOpen') {
      finalOption[key] = query[key] === 'true';
    }
    if (key === 'author') {
      tableOption.author.where = { userName: query[key] };
    }
    if (key === 'label') {
      tableOption.label.where = { title: query[key] };
    }
    if (key === 'milestone') {
      tableOption.milestone.where = { title: query[key] };
    }
    if (key === 'assignee') {
      tableOption.assignee.where = { userName: query[key] };
    }
  }

  return [finalOption, tableOption];
};

const getFilteredIssueIds = async (query) => {
  const [
    finalOption,
    { milestone, author, assignee, label },
  ] = applyOptionInQuery(query);

  const issueIds = await Issue.findAll({
    include: [milestone, author, assignee, label],
    where: finalOption,
    attributes: ['id'],
  });

  return issueIds;
};

const getIssues = async (query) => {
  const issueIds = [...(await getFilteredIssueIds(query))].map(
    (issueId) => issueId.id
  );

  const SEARCH_OPTION = {
    milestone: {
      model: Milestone,
      attributes: ['title'],
    },
    author: {
      model: User,
      as: 'author',
      attributes: ['userName'],
    },
    assignee: {
      model: User,
      as: 'Assignee',
      attributes: ['userName', 'profile'],
      through: { attributes: [] },
    },
    label: {
      model: Label,
      attributes: ['title', 'color', 'backgroundColor'],
      through: { attributes: [] },
    },
  };

  const issues = await Issue.findAll({
    include: [
      SEARCH_OPTION.milestone,
      SEARCH_OPTION.author,
      SEARCH_OPTION.assignee,
      SEARCH_OPTION.label,
    ],
    where: { id: issueIds },
    attributes: ['id', 'title', 'isOpen', 'preview', 'createdAt'],
  });

  return issues;
};

const addIssue = async (newIssue) => {
  await Issue.create(newIssue);
};

const updateIssues = async (modifiedContents) => {
  const ids = modifiedContents.id;

  delete modifiedContents.id;

  return await Issue.update(modifiedContents, {
    where: { id: ids, isDeleted: false },
  });
};

const deleteIssues = async (id) => {
  return await Issue.update({ isDeleted: true }, { where: { id: id } });
};

module.exports = {
  getIssues,
  addIssue,
  updateIssues,
  deleteIssues,
};
