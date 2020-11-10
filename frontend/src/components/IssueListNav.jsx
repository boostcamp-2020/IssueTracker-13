import React, { useState, useContext, useEffect } from 'react';

import styled from 'styled-components';

import IssueListNavButton from './IssueListNavButton';
import IssueListCheckBox from './IssueListCheckBox';
import FilterModal from './FilterModal';
import { IssuesContext } from '../pages/IssueListPage';

const Nav = styled.nav`
	background-color: #f6f8fa;
	border: 1px solid #e1e4e8;
	padding: 16px;
	margin-top: 30px;
	display: flex;
`;

const Buttons = styled.div`
	display: flex;
`;

export default function IssueListNav() {
  const [clickedProperty, setClickedProperty] = useState('');
  const [isShowModal, setIsShowModal] = useState(false);
  const { labels, milestones, users } = useContext(IssuesContext);

  const handleClick = (title) => {
    if (title === clickedProperty) {
      setClickedProperty('');
      return;
    }
    setClickedProperty(title);
  };

  useEffect(() => {
    if (!isShowModal) {
      setClickedProperty('');
      setIsShowModal(true);
    }
  }, [isShowModal]);

  const menuTypes = [
    { title: 'Author', contents: [...users] },
    { title: 'Label', contents: [{ id: 0, title: 'Unabled' }, ...labels] },
    { title: 'Milestones', contents: [{ id: 0, title: 'Issues with no milestone' }, ...milestones] },
    { title: 'Assignee', contents: [{ id: 0, userName: 'Assigned to nobody' }, ...users] },
  ];

  return (
    <Nav>
      <IssueListCheckBox />
      <Buttons>
        {menuTypes.map(({ title, contents }, i) => (
          <div key={i}>
            <IssueListNavButton
              title={title}
              handleClick={handleClick}
            />
            {title === clickedProperty && isShowModal &&
            <FilterModal
              title={title}
              contents={contents}
              setIsShowModal={setIsShowModal}
            />}
          </div>
        ))}
      </Buttons>
    </Nav>
  );
}
