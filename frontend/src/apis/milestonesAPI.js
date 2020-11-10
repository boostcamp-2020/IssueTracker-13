import axios from 'axios';

const getMilestones = async() => {
  const { data } = await axios.get('/api/milestones');
  return data;
};

export {
  getMilestones,
};
