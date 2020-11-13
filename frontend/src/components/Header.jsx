import React from 'react';
import { Link } from 'react-router-dom';

import styled from 'styled-components';

const HeaderDiv = styled.header`
  padding: 24px 0;
  text-align: center;
  font-size: 24px;
  font-weight: 600;
  background-color: #000000;
  color: #FFFFFF;
`;

const linkStyle = {
  textDecoration: 'none',
};

export default function Header() {

  return (
    <Link to ='/' style={linkStyle}>
      <HeaderDiv>
        ISSUES
      </HeaderDiv>
    </Link>
  );
}
