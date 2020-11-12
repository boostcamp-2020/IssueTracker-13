import axios from 'axios';
import { Redirect } from 'react-router-dom';

export const signInWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signIn', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
  }
};

export const signUpWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signUp', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
  }
};

export const signInWithGitHub = async () => {
};

const storeToken = (token) => {
  window.localStorage.setItem('token', token);
};

export const getAuthConfig = () => {
  const token = window.localStorage.getItem('token');
  return {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  };
};
