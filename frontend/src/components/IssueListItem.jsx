import React from 'react';

import styled from 'styled-components';

import { warningIcon } from '../assets/icons';

const ListItem = styled.li`
  list-style: none;
  display: flex;
  padding: 16px;
  border: 1px solid #eaecef;
`;

const CheckBox = styled.input`
  margin-right: 20px;
`;

const Svg = styled.span`
  padding: 3px;
`;

const Title = styled.span`
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
`;

const Label = styled.span`
  border: 1px solid #000000;
  padding: 1px 4px;
  margin: 0 5px;
`;

const Description = styled.span`
  font-size: 12px;
`;

const Milestone = styled.span`
  font-size: 12px;
`;

export default function IssueListItem({ issue }) {
  const { id, title, milestone, labels, author, createdAt } = issue;

  return (
    <ListItem>
      <CheckBox type='checkbox' />
      <Svg>
        {warningIcon}
      </Svg>
      <div>
        <div>
          <Title>{title}</Title>
          <Label>{labels.map(label => label.title)}</Label>
        </div>
        <div>
          <Description>#{id} opened{createdAt} by {author}</Description>
          <Milestone>milestone{milestone}</Milestone>
        </div>
      </div>
    </ListItem>
  );
}
