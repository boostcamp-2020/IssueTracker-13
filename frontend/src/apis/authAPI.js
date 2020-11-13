import axios from 'axios';

export const signInWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signIn', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
    return data;
  } else {
    throw new Error('login failed');
  }
};

export const signUpWithLocal = async ({ email, password }) => {
  const { data } = await axios.post('/api/auth/signUp', { email, password, authType: 'local' });
  if (data.token) {
    storeToken(data.token);
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

export const getAuthConfig = () => {
  const token = window.localStorage.getItem('token');
  return {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  };
};
