const { Comment, User, Issue } = require('../db/models');

const getComments = async (issueId) => {
  const comments = await Comment.findAll({
    attributes: {
      exclude: ['UserId', 'IssueId', 'updatedAt'],
    },
    include: {
      model: User,
      attributes: ['userName', 'profile'],
    },
    where: { issueId },
  });
  return comments;
};

const addComment = async (newComment) => {
  const issue = await Issue.findOne({ where: { id: newComment.issueId } });
  const user = await User.findOne({ where: { id: newComment.userId } });
  const comment = await Comment.create(newComment);
  await comment.setUser(user);
  await comment.setIssue(issue);
};

const updateComment = async (modifiedComment) => {
  const { id, ...modifiedTarget } = modifiedComment;

  return await Comment.update(modifiedTarget, { where: { id: id } });
};

module.exports = {
  getComments,
  addComment,
  updateComment,
};
