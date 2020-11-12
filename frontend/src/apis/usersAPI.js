import axios from 'axios';

import { getAuthConfig } from './authAPI';

const getUsers = async () => {
  const { data } = await axios.get('/api/users', getAuthConfig());
  return data;
};

export {
  getUsers,
};
