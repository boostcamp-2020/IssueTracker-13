import React from 'react';

import styled from 'styled-components';

const ContentContainer = styled.div`
  padding: 5px 10px;
`;

export default function SetMilestoneContents({ milestone }) {
  return (
    <ContentContainer>{milestone && milestone.title}</ContentContainer>
  );
}
