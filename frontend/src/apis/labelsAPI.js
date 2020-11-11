import axios from 'axios';

const getLabels = async () => {
  const { data } = await axios.get('/api/labels');
  return data;
};

export {
  getLabels,
};
