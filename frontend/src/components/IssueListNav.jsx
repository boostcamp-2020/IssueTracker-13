import React, { useState, useContext } from 'react';

import styled from 'styled-components';

import IssueListNavButton from './IssueListNavButton';
import IssueListCheckBox from './IssueListCheckBox';
import FilterModal from './FilterModal';
import { IssuesContext } from '../pages/IssueListPage';

const Nav = styled.nav`
	background-color: #f6f8fa;
	border: 1px solid #e1e4e8;
	padding: 16px;
	margin-top: 30px;
	display: flex;
`;

const Buttons = styled.div`
	display: flex;
`;

export default function IssueListNav() {
  const [clickedProperty, setClickedProperty] = useState('');
  const { labels, milestones, users } = useContext(IssuesContext);

  const handleClick = (title) => {
    if (title === clickedProperty) {
      setClickedProperty('');
      return;
    }
    setClickedProperty(title);
  };

  const menuTypes = [
    { title: 'Author', contents: users },
    { title: 'Label', contents: labels },
    { title: 'Milestones', contents: milestones },
    { title: 'Assignee', contents: users },
  ];

  return (
    <Nav>
      <IssueListCheckBox />
      <Buttons>
        {menuTypes.map(({ title, contents }, i) => (
          <div key={i}>
            <IssueListNavButton
              title={title}
              handleClick={handleClick}
            />
            {title === clickedProperty &&
            <FilterModal
              title={title}
              contents={contents}
            />}
          </div>
        ))}
      </Buttons>
    </Nav>
  );
}
