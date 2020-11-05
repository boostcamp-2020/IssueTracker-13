import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const Button = styled.button`
  padding: 8px 12px;
  background-color: white;
  font-weight: bold;
  border: 1px solid #d1d5da;
`;

const Count = styled.span`
  padding: 3px 7px;
  border: 1px solid #e1e4e8;
  background-color: #e1e4e8;
  border-radius: 50%;
`;

export default function PropertyButton({ route, text, img, count }) {
  return (
    <Link to={route}>
      <Button>
        <img src={img}></img>
        {text}
        <Count>{count}</Count>
      </Button>
    </Link>
  );
}

