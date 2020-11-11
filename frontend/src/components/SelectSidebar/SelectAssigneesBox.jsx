import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectAssigneesContents from './SelectAssigneesContents';
import SidebarModal from './SidebarModal';

const Box = styled.div``;

export default function SelectAssigneesBox({ title, assignees, allUsers }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const toggleModal = () => setIsShowModal(!isShowModal);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box>
      <SelectBoxHeader title={title} callback={toggleModal} />
      {isShowModal && <SidebarModal title='Assign up to 10 people to this issue' modalType='Assignees' contents={allUsers} closeModal={closeModal} />}
      <SelectAssigneesContents assignees={assignees} />
    </Box>
  );
}
