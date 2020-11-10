import axios from 'axios';

const getIssues = async (query) => {
  const { data } = await axios.get(`/api/issues?${query}`);
  return data.map(({ id, isOpen, preview, title, createdAt, Assignee, Labels, Milestone, author }) => {
    return {
      id,
      isOpen,
      preview,
      title,
      createdAt,
      assignee: Assignee,
      author: author.userName,
      labels: Labels,
      milestone: Milestone.title,
    };
  });
};

export {
  getIssues,
};
