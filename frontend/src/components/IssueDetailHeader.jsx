import React, { useContext } from 'react';

import styled from 'styled-components';

import { IssueDetailContext } from '../pages/IssueDetailPage';

import { warningIcon } from '../assets/icons';

const MainTitle = styled.div`
  margin-bottom: 10px;
`;

const SubTitle = styled.div`
  padding-bottom: 30px;
  border-bottom: 1px solid #e1e4e8;
`;

const IssueTitle = styled.span`
  font-size: 32px;
  font-weight: 400px;
`;

const IssueId = styled.span`
  font-size: 32px;
  font-weight: 400px;
  color: #6a737d;
`;

const EditButton = styled.button`
  position: absolute;
  right: 200px;
  background-color: #f3f4f6;
  padding: 3px 12px;
  font-size: 12px;
  line-height: 20px;
  border: 1px solid rgba(27, 31, 35, 0.15);
  border-radius: 5px;
`;

const OpenCloseButton = styled.button`
  background-color: #28a745;
  color: #fff;
  border: none;
  margin-right: 8px;
  padding: 5px 12px;
  font-size: 14px;
  font-weight: 500;
  border-radius: 2em;
`;

const Svg = styled.div`
  fill: #fff;
  padding: 3px;
  font-size: 14px;
`;

const Author = styled.span`
  font-size: 14px;
  color: #586069;
  font-weight: bold;
`;

const Date = styled.span`
  font-size: 14px;
  color: #586069;
`;

const isEmpty = (param) => {
  return Object.keys(param).length === 0;
};

const IssueDetailHeader = () => {
  const { issueDetail, dispatch } = useContext(IssueDetailContext);
  console.log('issueDetail : ', issueDetail);
  const date = !isEmpty(issueDetail) && issueDetail.createdAt.split('T')[0];
  return (
    <>
      <MainTitle>
        <IssueTitle>
          {!isEmpty(issueDetail) && `${issueDetail.title}`}
        </IssueTitle>
        &nbsp;
        <IssueId>
          #{!isEmpty(issueDetail) && issueDetail.id}
        </IssueId>
        <EditButton>
          Edit
        </EditButton>
      </MainTitle>
      <SubTitle>
        <OpenCloseButton>
          <Svg>
            {warningIcon}
            {!isEmpty(issueDetail) && issueDetail.isOpen && 'Open' || 'Closed'}
          </Svg>
        </OpenCloseButton>
        <Author>
          {!isEmpty(issueDetail) && issueDetail.author.userName}
        </Author>
        <Date> opened the issue at {date}</Date>
      </SubTitle>
    </>
  );
};

export default IssueDetailHeader;
