import axios from 'axios';

export const signInWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signIn', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
    storeUserInfo(data);
    return data;
  } else {
    throw new Error('login failed');
  }
};

export const signUpWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signUp', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
    storeUserInfo(data);
    return data;
  } else {
    throw new Error('singUp failed');
  }
};

export const signInWithGitHub = async () => {
};

const storeToken = (token) => {
  window.localStorage.setItem('token', token);
};

const storeUserInfo = (user) => {
  const { userName, profile } = user;
  window.localStorage.setItem('userName', userName);
  window.localStorage.setItem('profile', profile);
};

export const getAuthConfig = () => {
  const token = window.localStorage.getItem('token');
  return {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  };
};

export const getUserInfo = () => {
  const userName = window.localStorage.getItem('userName');
  const profile = window.localStorage.getItem('profile');
  return { userName, profile };
};
