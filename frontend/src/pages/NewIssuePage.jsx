import React, { createContext, useReducer, useState } from 'react';

import styled from 'styled-components';

import { addIssue } from '../apis/issuesAPI';

import NewIssueSidebar from '../components/NewIssueSidebar';

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

const reducer = (state, { type, payload }) => {
  if (type === 'add') {
    return payload;
  }
  console.log('unknown dispatch action');
  return state;
};

const initIssue = {
  title: '',
  comment: '',
  Assignee: [],
  Labels: [],
  Milestone: '',
};

export const NewIssueContext = createContext([]);

export default function NewIssuePage() {
  const [issueDetail, dispatch] = useReducer(reducer, initIssue);
  const [title, setTitle] = useState('');
  const [comment, setComment] = useState('');

  const postIssue = async (issue, title, comment) => {
    await addIssue({ ...issue, title, comment });
  };

  const handleTitleChange = (e) => {
    setTitle(e.target.value);
  };

  const handleCommentChange = (e) => {
    setComment(e.target.value);
  };

  return (
    <Page>
      <NewIssueContext.Provider value={ { issueDetail, dispatch }}>
        <Profile>
          <img src='https://avatars1.githubusercontent.com/u/52442237?s=80&v=4'/>
        </Profile>
        <InputBox>
          <InputTitle
            placeholder='Title'
            onChange={handleTitleChange}
          />
          <WriteBar>
          Write
          </WriteBar>
          <InputComment
            placeholder='Leave a comment'
            onChange={handleCommentChange}
          />
          <Buttons>
            <CancelButton>
            Cancel
            </CancelButton>
            <SubmitButton onClick={() => postIssue(issueDetail, title, comment)}>
            Submit new issue
            </SubmitButton>
          </Buttons>
        </InputBox>
        <NewIssueSidebar />
      </NewIssueContext.Provider>
    </Page>
  );
}
