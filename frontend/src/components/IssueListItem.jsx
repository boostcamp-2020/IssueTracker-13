import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

import { warningIcon } from '../assets/icons';
import { labelImgPath, milestoneImgPath } from '../assets/icons';

const ListItem = styled.li`
  list-style: none;
  display: flex;
  padding: 16px 0px 8px 16px;
  border: 1px solid #eaecef;
`;

const CheckBox = styled.input`
  margin-right: 20px;
`;

const Svg = styled.span`
  fill: #28a745;
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
  padding: 3px 6px;
  margin: 0 5px;
  background-color: ${props => props.backgroundColor};
  color: ${props => props.color};
  border: 1px solid transparent;
  border-radius: 10px;
`;

const SubTitle = styled.div`
  margin-top: 10px;
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
          {
            labels.length > 0 &&
            labels.map((label, i) =>
              <Label
                key={i}
                backgroundColor={label.backgroundColor}
                color={label.color}
              >
                {label.title}
              </Label>,
            )
          }
        </div>
        <SubTitle>
          <Description>#{id} opened {createdAt.split('T')[0]} by {author}  </Description>
          <Milestone>
            <svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
              <path fillRule="evenodd" d={milestoneImgPath} />
            </svg>
            {milestone}
          </Milestone>
        </SubTitle>
      </div>
    </ListItem>
  );
}
