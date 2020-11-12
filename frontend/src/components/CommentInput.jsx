import React, { useState, useContext } from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

import TranslateMarkdown from './TranslateMarkdown';

import { IssueDetailContext } from '../pages/IssueDetailPage';

import { addComment } from '../apis/commentsAPI';
import { getIssueDetail } from '../apis/issuesAPI';

const Page = styled.div`
  display: flex;
  position: relative;
  width: 100%;
`;

const InputBox = styled.div`
  width: 100%;
  margin: 18px;
  border: 1px solid #dfe2e5;
  border-radius: 5px;
  display: flex;
  flex-direction: column;
`;

const InputComment = styled.textarea`
  height: 200px;
  padding: 8px;
  font-size: 16px;
  margin:10px;
  width:96%;
  border: 1px solid #dfe2e5;
`;

const HeaderBar = styled.div`
  background-color:#f0f0f0;
  display: flex;
  flex-direction: column;
`;

const Buttons = styled.div`
  position: relative;
  padding: 5px;
`;

const CommentButton = styled.button`
  float:right;
  background-color:#28a745; 
  font-size: 16px;
  border-radius:5px;
  color:white;
  border-width : 1px;
  padding: 8px 16px;
  cursor: pointer;
`;

const CloseissueButton = styled.button`
  float:right;
  font-size: 16px;
  background-color:white;
  border-radius:5px;
  border-width : 1px;
  padding: 8px 16px;
  margin-right: 10px;
  cursor: pointer;
`;

const WritePreviewButton = styled.button`
  border:none;
  font-size: 22px;
  margin: 4px;
  cursor: pointer;
  background-color: #C8C8C8;
  color: white;
  padding: 5px;
  border-radius: 5px;
`;

const Tabs = styled.div`
  display: flex;
  margin: 4px;
`;

export default function CommentInput({ id }) {
  const [text, setText] = useState('');
  const [currentTab, setCurrentTab] = useState('write');
  const { dispatch } = useContext(IssueDetailContext);

  const placeholder = 'Leave a comment';

  const handleInputComment = (event) => {
    const text = event.target.value;
    setText(text);
  };

  const tabs = [
    {
      title: 'write',
      content: <InputComment placeholder={placeholder} value={text} onChange={handleInputComment} />,
    },
    {
      title: 'preview',
      content: <TranslateMarkdown markdown={text} />,
    },
  ];

  const changeTab = (i) => {
    setCurrentTab(tabs[i].title);
  };

  const postComment = async () => {
    await addComment({ description: text, issueId: id });
    const newIssue = await getIssueDetail(id);
    dispatch({ type: 'reLoad', payload: newIssue });
    setText('');
  };

  return (
    <Page>
      <InputBox>
        <HeaderBar>
          <Tabs>
            {tabs.map((tab, index) => (
              <WritePreviewButton key={index} onClick={() => changeTab(index)}>
                {tab.title}
              </WritePreviewButton>
            ))}
          </Tabs>
          <div>{tabs.filter(tab => tab.title === currentTab)[0].content}</div>
        </HeaderBar>
        <Buttons>
          <CommentButton onClick={() => postComment()}>
              Comment
          </CommentButton>
          <Link to='/'>
            <CloseissueButton>
              Close issue
            </CloseissueButton>
          </Link>
        </Buttons>
      </InputBox>
    </Page>
  );
}
