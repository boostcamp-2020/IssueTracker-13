import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const Button = styled.button`
  padding: 10px 16px;
  background-color: #28a745;
  font-weight: bold;
  color: #FFFFFF;
  border: 1px solid #e1e4e8;
  border-radius: 5px;
  font-size: 14px;
  position: absolute;
  right: 0;
  cursor: pointer;
`;

export default function NewButton({ route, text }) {
  return (
    <Link to={route}>
      <Button>New {text}</Button>
    </Link>
  );
}
