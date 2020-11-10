import axios from 'axios';

const getIssues = async (query) => {
  const { data } = await axios.get(`/api/issues?${query}`);
  console.log('query : ', query);
  return data.map(issue => {
    return { ...issue,
      author: issue.author.userName,
      labels: issue.Labels,
      milestone: issue.Milestone.title,
    };
  });
};

export {
  getIssues,
};
