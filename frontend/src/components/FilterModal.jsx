import React from 'react';

import styled from 'styled-components';

const Modal = styled.div`
  position: fixed;
  background-color: #fff;
  width: 300px;
  border: 1px solid #e1e4e8;
`;

const Title = styled.div`
  padding: 8px 12px;
  background-color: #f6f8fa;
  border: 1px solid #e1e4e8;
  font-weight: bold;
`;

const ContentsList = styled.ul`
  padding: 0;
  margin: 0;
`;

const Content = styled.li`
  padding: 8px 12px;
  list-style: none;
  border: 1px solid #e1e4e8;
`;

export default function FilterModal ({ title, contents }) {
  const filterIssues = (url) => {
    console.log(url);
  };

  return (
    <Modal>
      <Title>{title}</Title>
      <ContentsList>
        {contents.map((content, i) =>
          <Content
            key={i}
            onClick={() => filterIssues(content.url)}>
            {content.title}
          </Content>)}
      </ContentsList>
    </Modal>
  );
}
