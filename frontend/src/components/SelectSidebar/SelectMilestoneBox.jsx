import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectMilestoneContents from './SelectMilestoneContents';
import FilterModal from '../FilterModal';

const Box = styled.div``;

export default function IssueDetailMilestoneBox({ title, milestone, allMilestones }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const openModal = () => setIsShowModal(true);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box onBlur={closeModal} onFocus={openModal}>
      <SelectBoxHeader title={title} />
      {isShowModal && <FilterModal title='Set milestone' contents={allMilestones} setIsShowModal={setIsShowModal}/>}
      <SelectMilestoneContents milestone={milestone} />
    </Box>
  );
}
