import React, { useContext } from 'react';

import styled from 'styled-components';

import { IssuesContext } from '../pages/IssueListPage';

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
  cursor: pointer;
`;

const Content = styled.li`
  padding: 8px 12px;
  list-style: none;
  border: 1px solid #e1e4e8;
`;

export default function FilterModal ({ title: modalTitle, contents = [], setIsShowModal }) {
  const { dispatch } = useContext(IssuesContext);

  const setFilterQuery = (query) => {
    dispatch({ type: 'setFilterQuery', query });
    setIsShowModal(false);
  };

  const addFilterQuery = (query, key) => {
    dispatch({ type: 'addFilterQuery', query, key });
    // setIsShowModal(false);
  };

  return (
    <Modal>
      <Title>{modalTitle}</Title>
      <ContentsList>
        {contents.map(({ userName, title, query }, i) => {
          query = query || `${modalTitle.toLowerCase()}=${title || userName}`;

          return (
            <Content
              key={i}
              onClick={() => modalTitle === 'Filter Issues' ? setFilterQuery(query) : addFilterQuery(query, modalTitle.toLowerCase())}>
              {title || userName}
            </Content>
          );
        })
        }
      </ContentsList>
    </Modal>
  );
}
