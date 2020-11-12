import React from 'react';

import styled from 'styled-components';

const Box = styled.div`
  border: 1px solid #dfe2e5;
  margin: 20px;
  border-radius: 5px;
`;

const User = styled.div`
  border: 1px solid #dfe2e5;
  background-color: #fff8f2;
  padding: 16px;
`;

const Description = styled.div`
  border: 1px solid #dfe2e5;
  padding: 16px;
`;

export default function CommentListItem({ description, author }) {
  return (
    <Box>
      <User>
        {author.userName}
      </User>
      <Description>
        {description}
      </Description>
    </Box>
  );
}
