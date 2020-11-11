import React from 'react';

import styled from 'styled-components';

const Button = styled.button`
  padding: 2px 5px;
  font-size: 14px;
  line-height: 20px;
  cursor: pointer;
  border: 0;
  background-color: transparent;
  display: inline-flex;
  flex-flow: row nowrap;
  align-items: center;
`;

const Count = styled.span`
  padding: 0 5px;
`;

const Svg = styled.svg`
  margin: 0 5px 0 0;
`;

export default function OpenClosedButton({ text, imgPath, count }) {
  return (
    <Button>
      <Svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
        <path fillRule="evenodd" d={imgPath} />
      </Svg>
      <Count>{count}</Count>
      {text}
    </Button>
  );
}
