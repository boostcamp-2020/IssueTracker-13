import React from 'react';

import styled from 'styled-components';

const ContentContainer = styled.div`
  display: flex;
  height: 50px;
  padding: 5px;
  gap: 10px;
`;

const Label = styled.span`
  height: 20px;
  border-radius: 20px;
  padding: 5px 10px;
  ${props => `
    color: ${props.label.color};
    background-color: ${props.label.backgroundColor};
  `}
`;

export default function SetLabelsContents({ labels }) {
  return (
    <ContentContainer>
      {labels && labels.map((label, i) => <Label key={i} label={label} >{label.title}</Label>)}
    </ContentContainer>
  );
}
