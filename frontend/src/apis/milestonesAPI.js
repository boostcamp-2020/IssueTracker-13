import axios from 'axios';

import { getAuthConfig } from './authAPI';

const getMilestones = async () => {
  const { data } = await axios.get('/api/milestones', getAuthConfig());
  return data;
};

export {
  getMilestones,
};
