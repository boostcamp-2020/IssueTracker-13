import React from 'react';

import styled from 'styled-components';

const ListItem = styled.div`
  display: flex;
  flex-flow: row nowrap;
  border: 1px solid #e1e4e8;
`;

const InlineBox = styled.div`
  display: flex;
  flex-flow: column;
  flex: 1;
  padding: 15px 20px;
  gap: 5px;
`;

const Title = styled.div`
  font-size: 24px;
  font-weight: 600;
  cursor: pointer;
`;

const DueDate = styled.div`
  color: #6A737D;
  font-size: 14px;
`;

const Description = styled.div`
  color: #6A737D;
  font-size: 16px;
`;

const ProgressBar = styled.svg`
  height: 30px;
`;

const BarContainer = styled.div`
  color: #586069;
  display: flex;
  flex-flow: row nowrap;
  gap: 20px;
`;

const Button = styled.button`
  padding: 0;
  border: none;
  font-size: 14px;
  background-color: transparent;
  color: #0366D6;
  cursor: pointer;

  ${props => props.isDelete && `
    color: #CB2431;
  `}
`;

function NumberAndDesc({ number, desc }) {
  return (
    <span>
      <strong>{number}</strong>
      {' ' + desc}
    </span>
  );
}

export default function MilestoneListItem({ milestone }) {
  const { closedIssueCount, allIssueCount } = milestone;
  const openIssueCount = allIssueCount - closedIssueCount;
  const completionRate = Math.round(closedIssueCount / allIssueCount * 100);
  const dueBy = new Date(milestone.dueDate).toDateString();

  return (
    <ListItem>
      <InlineBox>
        <Title>{milestone.title}</Title>
        <DueDate>Due By {dueBy}</DueDate>
        <Description>{milestone.description}</Description>
      </InlineBox>
      <InlineBox>
        <ProgressBar></ProgressBar>
        <BarContainer>
          <NumberAndDesc number={`${completionRate}%`} desc='Complete' />
          <NumberAndDesc number={openIssueCount} desc='Open' />
          <NumberAndDesc number={closedIssueCount} desc='Closed' />
        </BarContainer>
        <BarContainer>
          <Button>Edit</Button>
          <Button>Close</Button>
          <Button isDelete>Delete</Button>
        </BarContainer>
      </InlineBox>
    </ListItem>
  );
}
