import React from 'react';

import styled from 'styled-components';

const ListItem = styled.li`
  list-style: none;
  display: flex;
  padding: 16px;
  border: 1px solid #eaecef;
`;

const CheckBox = styled.input`
  margin-right: 20px;
`;

const Svg = styled.svg`
  padding: 3px;
`;

const Title = styled.span`
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
`;

const Label = styled.span`
  border: 1px solid black;
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
  const { id, title, milestone, labels, author, createAt } = issue;

  return (
    <ListItem>
      <CheckBox type='checkbox' />
      <Svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
        <path fillRule="evenodd" d="M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z"></path></Svg>
      <div>
        <div>
          <Title>{title}</Title>
          <Label>{labels.map(label => label.title)}</Label>
        </div>
        <div>
          <Description>#{id} opened{createAt} by {author}</Description>
          <Milestone>milestone{milestone}</Milestone>
        </div>
      </div>
    </ListItem>
  );
}

