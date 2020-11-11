import React from 'react';

import styled from 'styled-components';

const ContentContainer = styled.div`
  height: 50px;

`;

const RowContainer = styled.div`
  display: flex;
  flex-flow: row nowrap;
  align-items: center;
`;

const Img = styled.img`
  width: 20px;
  height: 20px;
`;

function UserProfileAndName({ user }) {
  return (
    <RowContainer>
      <Img src={user.profile} />
      {user.userName}
    </RowContainer>
  );
}

export default function SetAssigneesContents({ assignees }) {
  return (
    <ContentContainer>
      {assignees && assignees.map((user, i) => <UserProfileAndName key={i} user={user}/>)}
    </ContentContainer>
  );
}
