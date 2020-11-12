import React, { createContext, useReducer, useState } from 'react';

import styled from 'styled-components';

import { addIssue } from '../apis/issuesAPI';

import NewIssueSidebar from '../components/NewIssueSidebar';

const Page = styled.div`
  padding: 100px 400px;
  display: flex;
  position: relative;
`;

const Box = styled.div`
  width: 100%;
  padding: 10px;
  border: 1px solid #d1d5da;
  border-radius: 5px;
`;

const Profile = styled.div`
  padding: 10px;
`;

const InputBox = styled.div`
  width: 100%;
  border-radius: 5px;
  display: flex;
  flex-direction: column;
`;

const InputTitle = styled.input`
  display: block;
  font-size: 16px;
  padding: 8px;
  margin-bottom: 16px;
  border: 1px solid #d1d5da;
  border-radius: 5px;
  background-color: #fff8f2;
`;

const InputComment = styled.textarea`
  height: 350px;
  padding: 8px;
  font-size: 16px;
  border: 1px solid #d1d5da;
  border-radius: 5px;
  background-color: #fff8f2;
`;

const BoxFooter = styled.div`
  position: relative;
  height: 50px;
`;

const SubmitButton = styled.button`
  position: absolute;
  right: 0px;
  top: 12px;
  background-color: #2ea44f;
  font-size: 14px;
  border: none;
  color: #fff;
  padding: 8px;
  border-radius: 5px;
  cursor: pointer;
  outline: none;
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
    const message = await addIssue({ ...issue, title, comment });

    if (message === 'fail') {
      alert('이슈등록에 실패했습니다');
      return;
    }
    alert('이슈가 등록되었습니다');
    return;
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
        <Box>
          <InputBox>
            <InputTitle
              placeholder='Title'
              onChange={handleTitleChange}
            />
            <InputComment
              placeholder='Leave a comment'
              onChange={handleCommentChange}
            />
            <BoxFooter>
              <SubmitButton onClick={() => postIssue(issueDetail, title, comment)}>
                  Submit new issue
              </SubmitButton>
            </BoxFooter>
          </InputBox>
        </Box>
        <NewIssueSidebar />
      </NewIssueContext.Provider>
    </Page>
  );
}
