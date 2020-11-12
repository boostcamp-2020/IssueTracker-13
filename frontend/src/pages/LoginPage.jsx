import React from 'react';

import styled from 'styled-components';

const Page = styled.div`
  padding: 48px 200px;
  max-width: none !important;
  text-align: center;
`;

const Title = styled.h1``;

const LoginBox = styled.div`
  margin: 0 auto;
  width: 500px;
`;

const LabelInputContainer = styled.label`
  display: flex;
  flex-flow: column nowrap;
  align-items: left;
  text-align: left;
`;

const InputLabel = styled.label``;

const EmailInput = styled.input``;

const PasswordInput = styled.input``;

const RowContainer = styled.div``;

const Button = styled.button``;

const GitHubButton = styled.button``;

export default function LoginPage() {
  return (
    <Page>
      <Title>이슈 트래커</Title>
      <LoginBox>
        <LabelInputContainer>
          <InputLabel>아이디</InputLabel>
          <EmailInput></EmailInput>
        </LabelInputContainer>
        <LabelInputContainer>
          <InputLabel>비밀번호</InputLabel>
          <PasswordInput></PasswordInput>
        </LabelInputContainer>
        <RowContainer>
          <Button>로그인</Button>
          <Button>회원가입</Button>
        </RowContainer>
        <GitHubButton>Sign in with GitHub</GitHubButton>
      </LoginBox>
    </Page>
  );
}
