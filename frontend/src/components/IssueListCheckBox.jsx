import React from 'react';

import styled from 'styled-components';

const Div = styled.div`
  width: 100%;
  display: flex;
  align-items: center;
`;

export default function IssueListCheckBox() {
  return (
    <Div>
      <input type='checkbox'/>
    </Div>
  );
}

