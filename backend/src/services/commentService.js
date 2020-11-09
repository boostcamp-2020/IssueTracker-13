const { Comment } = require('../db/models');

const getComments = async (issueId) => {
  const comments = await Comment.findAll({
    where: { issueId: issueId },
  });
  return comments;
};

const addComment = async (newComment) => {
  await Comment.create(newComment);
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
