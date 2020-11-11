import axios from 'axios';

const getUsers = async () => {
  const { data } = await axios.get('/api/users');
  return data;
};

export {
  getUsers,
};
