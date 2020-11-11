import React from 'react';
import { Link } from 'react-router-dom';

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
  text-decoration: none;
  outline: none;
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

const StyledLink = styled(Link)`
  text-decoration: none;
  color: #000;
  &:focus, &:hover, &:visited, &:link, &:active {
    text-decoration: none;
  }
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
          <StyledLink to={`/issues/${id}`}>
            <Title>
              {title}
            </Title>
          </StyledLink>
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
