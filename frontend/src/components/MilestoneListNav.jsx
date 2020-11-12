import React from 'react';

import styled from 'styled-components';

import OpenClosedButton from './OpenClosedButton';

const Nav = styled.nav`
  background-color: #f6f8fa;
  border: 1px solid #e1e4e8;
  padding: 10px 10px;
  margin-top: 30px;
  display: flex;
`;

const milestoneImgPath = 'M7.75 0a.75.75 0 01.75.75V3h3.634c.414 0 .814.147 1.13.414l2.07 1.75a1.75 1.75 0 010 2.672l-2.07 1.75a1.75 1.75 0 01-1.13.414H8.5v5.25a.75.75 0 11-1.5 0V10H2.75A1.75 1.75 0 011 8.25v-3.5C1 3.784 1.784 3 2.75 3H7V.75A.75.75 0 017.75 0zm0 8.5h4.384a.25.25 0 00.161-.06l2.07-1.75a.25.25 0 000-.38l-2.07-1.75a.25.25 0 00-.161-.06H2.75a.25.25 0 00-.25.25v3.5c0 .138.112.25.25.25h5z';
const checkImgPath = 'M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z';

export default function MilestoneListNav({ milestones, setIsOpen }) {
  const openMilestonesCount = milestones.filter((milestone) => milestone.isOpen).length;
  const closedMilestonesCount = milestones.length - openMilestonesCount;

  const clickHandler = (type) => () => {
    if (type === 'Open') {
      setIsOpen(true);
    }
    if (type === 'Close') {
      setIsOpen(false);
    }
  };

  return (
    <Nav>
      <OpenClosedButton text='Open' callback={clickHandler('Open')} imgPath={milestoneImgPath} count={openMilestonesCount}></OpenClosedButton>
      <OpenClosedButton text='Closed' callback={clickHandler('Close')} imgPath={checkImgPath} count={closedMilestonesCount}></OpenClosedButton>
    </Nav>
  );
}
