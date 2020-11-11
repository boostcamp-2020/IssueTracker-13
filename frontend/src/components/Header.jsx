import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const HeaderDiv = styled.header`
  padding: 24px 0;
  text-align: center;
  background-color: #000000;
  color: #FFFFFF;
`;

export default function Header() {

  return (
    <Link to ='/'>
      <HeaderDiv>
        ISSUES
      </HeaderDiv>
    </Link>
  );
}
