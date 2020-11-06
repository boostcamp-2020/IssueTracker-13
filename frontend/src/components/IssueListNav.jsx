import React, { useState } from 'react';

import styled from 'styled-components';

import IssueListNavButton from './IssueListNavButton';
import IssueListCheckBox from './IssueListCheckBox';

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
  const [clickedProperty, setClickedProperty] = useState('null');

  const handleClick = (title) => {
    setClickedProperty(title);
    console.log(clickedProperty);
  };

  const menuTypes = ['Author', 'Label', 'Milestones', 'Assignee'];

  return (
    <Nav>
      <IssueListCheckBox />
      <Buttons>
        {menuTypes.map((menuType, i) =>
          <IssueListNavButton
            key={i}
            title={menuType}
            handleClick={handleClick}
          />,
        )}
      </Buttons>
    </Nav>
  );
}
