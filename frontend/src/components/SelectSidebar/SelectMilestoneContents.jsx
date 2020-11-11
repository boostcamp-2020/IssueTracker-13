import React from 'react';

import styled from 'styled-components';

const ContentContainer = styled.div`
  height: 50px;
`;

export default function SetMilestoneContents({ milestone }) {
  return (
    <ContentContainer>{milestone && milestone.title}</ContentContainer>
  );
}
