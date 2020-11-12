import React from 'react';

import styled from 'styled-components';

const Nav = styled.nav`
  background-color: #f6f8fa;
  border: 1px solid #e1e4e8;
  padding: 10px 10px;
  margin-top: 30px;
  display: flex;
`;

const Div = styled.div`
  padding: 2px 5px;
  font-size: 14px;
  line-height: 20px;
  cursor: pointer;
  border: 0;
  background-color: transparent;
  display: inline-flex;
  flex-flow: row nowrap;
  align-items: center;
  gap: 5px;
`;

export default function LabelListNav({ labels }) {
  return (
    <Nav>
      <Div>
        <span><strong>{labels.length}</strong></span>
        <span>labels</span>
      </Div>
    </Nav>
  );
}
