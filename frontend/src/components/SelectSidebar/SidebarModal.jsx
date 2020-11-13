import React, { useContext } from 'react';

import styled from 'styled-components';

import { IssueContext } from './SelectSidebar';

const Modal = styled.div`
  position: absolute;
  background-color: #fff;
  width: 300px;
  border: 1px solid #e1e4e8;
  z-index: 1; 
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

export default function SidebarModal ({ modalType, title: modalTitle, contents = [], closeModal }) {
  const { dispatch } = useContext(IssueContext);

  const toggleAssignee = (id) => {
    const data = contents.find((user) => user.id === id);
    dispatch({ type: 'toggleAssignee', key: id, data });
  };

  const toggleLabel = (id) => {
    const data = contents.find((label) => label.id === id);
    dispatch({ type: 'toggleLabel', key: id, data });
  };

  const toggleMilestone = (id) => {
    const data = contents.find((milestone) => milestone.id === id);
    dispatch({ type: 'toggleMilestone', key: id, data });
  };

  const clickHandler = (event) => {
    const id = parseInt(event.target.dataset.id);

    if (modalType === 'Assignees') {
      toggleAssignee(id);
      closeModal();
      return;
    }
    if (modalType === 'Labels') {
      toggleLabel(id);
      closeModal();
      return;
    }
    if (modalType === 'Milestones') {
      toggleMilestone(id);
      closeModal();
      return;
    }
  };

  return (
    <Modal>
      <Title>{modalTitle}</Title>
      <ContentsList>
        {contents.map(({ id, userName, title }) => {
          return (
            <Content
              key={id}
              data-id={id}
              onClick={clickHandler}>
              {title || userName}
            </Content>
          );
        })
        }
      </ContentsList>
    </Modal>
  );
}
