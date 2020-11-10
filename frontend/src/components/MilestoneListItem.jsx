import React from 'react';

import styled from 'styled-components';

const ListItem = styled.div`
  display: flex;
  flex-flow: row nowrap;
`;

const InlineBox = styled.div`
  display: flex;
  flex-flow: column;
`;

const Title = styled.div`
  font-size: 24px;
  font-weight: 600;
  cursor: pointer;
`;

const DueDate = styled.div`
  font-size: 14px;
`;

const Description = styled.div`
  font-size: 16px;
`;

const ProgressBar = styled.svg`
`;

const BarContainer = styled.div`
  display: flex;
  flex-flow: row nowrap;
`;

const NumberAndDesc = styled.span`
`;

const Button = styled.button`
`;

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
          <NumberAndDesc>{completionRate}% completed</NumberAndDesc>
          <NumberAndDesc>{openIssueCount} open</NumberAndDesc>
          <NumberAndDesc>{closedIssueCount} closed</NumberAndDesc>
        </BarContainer>
        <BarContainer>
          <Button>Edit</Button>
          <Button>Close</Button>
          <Button>Delete</Button>
        </BarContainer>
      </InlineBox>
    </ListItem>
  );
}
