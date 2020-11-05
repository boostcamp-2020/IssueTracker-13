import React from 'react';

import styled from 'styled-components';

const Button = styled.button`
  display: flex;
  border: none;
  background-color: transparent;
  margin: 0 10px;
`;

const DropDown = styled.img`
  width: 20px;
`;

export default function IssueListNavButton({ title, handleClick }) {
  return (
    <Button onClick={() => handleClick(title)}>
      {title}
      <DropDown src="https://upload.wikimedia.org/wikipedia/commons/e/e4/Ic_arrow_drop_down_36px.svg"/>
    </Button>
  );
}
