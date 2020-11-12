const { Issue, User, Label, Milestone, Comment } = require('../db/models');

const SEARCH_OPTION = {
  milestone: {
    model: Milestone,
    attributes: ['id', 'title'],
  },
  author: {
    model: User,
    as: 'author',
    attributes: ['userName', 'profile'],
  },
  assignee: {
    model: User,
    as: 'Assignee',
    attributes: ['id', 'userName', 'profile'],
    through: { attributes: [] },
  },
  label: {
    model: Label,
    attributes: ['id', 'title', 'color', 'backgroundColor'],
    through: { attributes: [] },
  },
  comment: {
    model: Comment,
    attributes: ['id', 'description', 'createdAt'],
    include: {
      model: User,
      attributes: ['userName', 'profile'],
    },
  },
};

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
  const issue = await Issue.create({
    ...newIssue,
    preview: newIssue.comment,
    isOpen: true,
    isDeleted: false,
  });

  const author = await User.findOne({ where: newIssue.authorId });
  const comment = await Comment.create({ description: newIssue.comment });
  await comment.setUser(author);
  await comment.setIssue(issue);

  if (newIssue.Assignee !== undefined) {
    const assigneeIds = newIssue.Assignee.map((user) => user.id);
    const assignees = await User.findAll({ where: { id: assigneeIds } });
    await issue.setAssignee(assignees);
  }

  if (newIssue.Labels !== undefined) {
    const labelIds = newIssue.Labels.map((label) => label.id);
    const labels = await Label.findAll({ where: { id: labelIds } });
    await issue.setLabels(labels);
  }

  if (newIssue.Milestone !== undefined) {
    const milestoneId = newIssue.Milestone.id;
    const milestone = await Milestone.findOne({ where: { id: milestoneId } });
    await issue.setMilestone(milestone);
  }
};

const updateIssues = async (modifiedContents) => {
  const ids = modifiedContents.id;

  delete modifiedContents.id;

  return await Issue.update(modifiedContents, {
    where: { id: ids, isDeleted: false },
  });
};

const updateIssue = async (modifiedContents) => {
  const id = modifiedContents.id;

  const issue = await Issue.findOne({ where: { id } });

  if (modifiedContents.Assignee !== undefined) {
    const assigneeIds = modifiedContents.Assignee.map((user) => user.id);
    const assignees = await User.findAll({ where: { id: assigneeIds } });
    await issue.setAssignee(assignees);
  }

  if (modifiedContents.Lables !== undefined) {
    const labelIds = modifiedContents.Labels.map((label) => label.id);
    const labels = await Label.findAll({ where: { id: labelIds } });
    await issue.setLabels(labels);
  }

  if (modifiedContents.Milestone !== undefined) {
    const milestoneId = modifiedContents.Milestone.id;
    const milestone = await Milestone.findOne({ where: { id: milestoneId } });
    await issue.setMilestone(milestone);
  }

  if (modifiedContents.title !== undefined) {
    issue.title = modifiedContents.title;
  }

  if (modifiedContents.isOpen !== undefined) {
    issue.isOpen = modifiedContents.isOpen;
  }

  await issue.save();
};

const deleteIssues = async (id) => {
  return await Issue.update({ isDeleted: true }, { where: { id: id } });
};

const getIssue = async (id) => {
  return await Issue.findOne({
    include: [
      SEARCH_OPTION.milestone,
      SEARCH_OPTION.author,
      SEARCH_OPTION.assignee,
      SEARCH_OPTION.label,
      SEARCH_OPTION.comment,
    ],
    where: { id, isDeleted: false },
    attributes: ['id', 'title', 'isOpen', 'preview', 'createdAt'],
  });
};

module.exports = {
  getIssues,
  addIssue,
  updateIssues,
  deleteIssues,
  getIssue,
  updateIssue,
};
