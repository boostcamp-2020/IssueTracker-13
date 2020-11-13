import React from 'react';
import { Link } from 'react-router-dom';

import styled, { css } from 'styled-components';

const Button = styled.button`
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
  padding: 5px 16px;
  background-color: #FFFFFF;
  font-size: 14px;
  font-weight: 600;
  text-decoration: none;
  border: 1px solid #d1d5da;
  border-radius: 5px;
  line-height: 20px;
  cursor: pointer;

  ${props => props.selected && css`
    background-color: #0366D6;
    color: white;
  `};
`;

const Count = styled.span`
  padding: 3px 7px;
  border: 1px solid #e1e4e8;
  background-color: #e1e4e8;
  border-radius: 50%;
`;

const Svg = styled.svg`
  margin: 0 10px 0 0;
  fill: currentColor;
`;

export default function PropertyButton({ route, text, imgPath, count, selected }) {
  return (
    <Link to={route} style={{ textDecoration: 'none' }}>
      <Button selected={selected}>
        <Svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
          <path fillRule="evenodd" d={imgPath} />
        </Svg>
        {text}
        {count && <Count>{count}</Count>}
      </Button>
    </Link>
  );
}
