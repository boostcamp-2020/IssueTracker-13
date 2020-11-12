import axios from 'axios';

import { getAuthConfig } from './authAPI';

const addComment = async (comment) => {
  const { data } = await axios.get('/api/comments', comment, getAuthConfig());
  return data;
};

export { addComment };
