import axios from 'axios';

export const signInWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signIn', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
    storeUserInfo(data);
    return data;
  } else {
    throw new Error('로그인을 할 수 없습니다. 아이디와 비밀번호를 확인해주세요');
  }
};

export const signUpWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signUp', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
    storeUserInfo(data);
    return data;
  } else {
    throw new Error('회원가입을 할 수 없습니다. 아이디와 비밀번호를 확인해주세요');
  }
};

export const signInWithGitHub = async () => {
};

const storeToken = (token) => {
  window.localStorage.setItem('token', token);
};

const storeUserInfo = (user) => {
  const { name, profile } = user;
  window.localStorage.setItem('userName', name);
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
