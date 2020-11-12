import axios from 'axios';

import { getAuthConfig } from './authAPI';

const getLabels = async () => {
  const { data } = await axios.get('/api/labels', getAuthConfig());
  return data;
};

export {
  getLabels,
};
