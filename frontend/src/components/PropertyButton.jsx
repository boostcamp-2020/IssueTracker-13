import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const Button = styled.button`
  padding: 5px 16px;
  background-color: white;
  font-size: 14px;
  border: 1px solid #d1d5da;
  border-radius: 5px;
  line-height: 20px;
  cursor: pointer;
`;

const Count = styled.span`
  padding: 3px 7px;
  border: 1px solid #e1e4e8;
  background-color: #e1e4e8;
  border-radius: 50%;
`;

const Svg = styled.svg`
  margin: 0 10px 0 0;
`;

export default function PropertyButton({ route, text, imgPath, count }) {
  return (
    <Link to={route}>
      <Button>
        <Svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
          <path fillRule="evenodd" d={imgPath} />
        </Svg>
        {text}
        <Count>{count}</Count>
      </Button>
    </Link>
  );
}

