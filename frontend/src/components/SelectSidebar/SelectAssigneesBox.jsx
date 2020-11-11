import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectAssigneesContents from './SelectAssigneesContents';
import FilterModal from '../FilterModal';

const Box = styled.div``;

export default function SelectAssigneesBox({ title, assignees, allUsers }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const openModal = () => setIsShowModal(true);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box onBlur={closeModal} onFocus={openModal}>
      <SelectBoxHeader title={title} />
      {isShowModal && <FilterModal title='Assign up to 10 people to this issue' contents={allUsers} setIsShowModal={setIsShowModal} />}
      <SelectAssigneesContents assignees={assignees} />
    </Box>
  );
}
