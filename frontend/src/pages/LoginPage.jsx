import React, { useState, useEffect } from 'react';
import { useHistory } from 'react-router-dom';

import styled from 'styled-components';

import { useAuth } from '../App';

const Page = styled.div`
  padding: 48px 200px;
  max-width: none !important;
  text-align: center;
`;

const Title = styled.h1``;

const LoginBox = styled.div`
  padding: 20px;
  margin: 40px auto;
  width: 500px;
  box-shadow: 0 0 3px gray;
  font-size: 16px;
`;

const LabelInputContainer = styled.label`
  display: flex;
  margin-bottom: 30px;
  flex-flow: column nowrap;
  align-items: left;
  text-align: left;
  gap: 10px;
`;

const InputLabel = styled.label`
  font-size: 20px;
  font-weight: 600;
`;

const EmailInput = styled.input`
  height: 30px;
  font-size: 16px;
  padding: 3px 3px 3px 10px;
`;

const PasswordInput = styled.input`
  height: 30px;
  font-size: 16px;
  padding: 3px 3px 3px 10px;
`;

const RowContainer = styled.div`
  display: flex;
  justify-content: space-evenly;
`;

const Button = styled.button`
  font-size: 16px;
  font-weight: 600;
  border: none;
  color: white;
  padding: 8px 92px;
  border-radius: 5px;
  cursor: pointer;
  background-color : ${props => props.disabled ? '#B8B8B8' : '#505050'};
`;

const GitHubButton = styled.button`
  color: white;
  padding: 8px 140px;
  font-size: 16px;
  font-weight: 600;
  margin-top: 10px;
  border-radius: 5px;
  background-color: #B8B8B8;
  border: none;
`;

const Warning = styled.div`
  text-align: center;
  color: red;
`;

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [emailWarning, setEmailWarning] = useState('');
  const [passwordWarning, setPasswordWarning] = useState('');

  let history = useHistory();
  let auth = useAuth();

  const clickHandler = (type) => async () => {
    if (type === 'SignIn') {
      auth.signIn({ email, password }, () => history.push('/'));
    }
    if (type === 'SignUp') {
      auth.signUp({ email, password }, () => history.push('/'));
    }
  };

  const changeHandler = (type) => (event) => {
    if (type === 'Email') {
      setEmail(event.target.value);
      return;
    }
    if (type === 'Password') {
      setPassword(event.target.value);
      return;
    }
  };

  useEffect(() => {
    const conditions = ['@', '.', 'com'];
    const validationEmail = conditions.every(condition => email.includes(condition));
    if (!validationEmail) {
      setEmailWarning('잘못된 이메일 형식입니다(ex. test@boostcamp.com)');
    }
    if (email.length === 0 || validationEmail) {
      setEmailWarning('');
    }
  }, [email]);

  useEffect(() => {
    if (password.length < 4) {
      setPasswordWarning('네자리 이상 입력해주세요');
    }
    if (password.length === 0 || password.length >= 4) {
      setPasswordWarning('');
    }
  }, [password]);

  return (
    <Page>
      <Title>이슈 트래커</Title>
      <LoginBox>
        <LabelInputContainer>
          <InputLabel>이메일</InputLabel>
          <EmailInput
            type='email'
            id='email'
            value={email}
            onChange={changeHandler('Email')}
            placeholder='test@boostcamp.com'
          />
          <Warning>
            {emailWarning}
          </Warning>
        </LabelInputContainer>
        <LabelInputContainer>
          <InputLabel>비밀번호</InputLabel>
          <PasswordInput type='password' id='password' value={password} onChange={changeHandler('Password')}></PasswordInput>
          <Warning>
            {passwordWarning}
          </Warning>
        </LabelInputContainer>
        <RowContainer>
          <Button onClick={clickHandler('SignIn')}>로그인</Button>
          <Button onClick={clickHandler('SignUp')}>회원가입</Button>
        </RowContainer>
        <GitHubButton disabled>Sign in with GitHub(준비중)</GitHubButton>
      </LoginBox>
    </Page>
  );
}
