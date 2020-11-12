import React from 'react';

import styled from 'styled-components';

const Page = styled.div`
  padding: 48px 400px;
  display: flex;
  position: relative;
`;

const Profile = styled.div`

`;

const InputBox = styled.div`
  width: 100%;
  border: 1px solid #000;
  display: flex;
  flex-direction: column;
`;

const InputTitle = styled.input`
  display: block;
  font-size: 16px;
  padding: 8px;
`;

const InputComment = styled.textarea`
  height: 200px;
  min-height: 200px;
  max-height: 500px;
  padding: 8px;
  font-size: 16px;
`;

const SideBar = styled.div`

`;

const Buttons = styled.div`
  position: relative;
  padding: 8px;
`;

const CancelButton = styled.button`

`;

const SubmitButton = styled.button`
  position: absolute;
  right: 8px;
`;

const WriteBar = styled.div`

`;

export default function NewIssuePage() {
  return (
    <Page>
      <Profile>
        <img src='https://avatars1.githubusercontent.com/u/52442237?s=80&v=4'/>
      </Profile>
      <InputBox>
        <InputTitle placeholder='Title' />
        <WriteBar>
          Write
        </WriteBar>
        <InputComment placeholder='Leave a comment'/>
        <Buttons>
          <CancelButton>
            Cancel
          </CancelButton>
          <SubmitButton>
            Submit new issue
          </SubmitButton>
        </Buttons>
      </InputBox>
      <SideBar>
        사이드바
      </SideBar>
    </Page>
  );
}
