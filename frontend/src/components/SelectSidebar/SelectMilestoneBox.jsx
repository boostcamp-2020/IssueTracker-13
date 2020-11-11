import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectMilestoneContents from './SelectMilestoneContents';
import SidebarModal from './SidebarModal';

const Box = styled.div`
  margin: 10px 10px;
  padding: 0 0 10px 0;
  border-bottom: 1px solid #DDDDDD;
`;

export default function IssueDetailMilestoneBox({ title, milestone, allMilestones }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const toggleModal = () => setIsShowModal(!isShowModal);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box>
      <SelectBoxHeader title={title} callback={toggleModal} />
      {isShowModal && <SidebarModal title='Set milestone' modalType='Milestones' contents={allMilestones} closeModal={closeModal} />}
      <SelectMilestoneContents milestone={milestone} />
    </Box>
  );
}
