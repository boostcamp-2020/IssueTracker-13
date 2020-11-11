import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectLabelsContents from './SelectLabelsContents';
import SidebarModal from './SidebarModal';

const Box = styled.div``;

export default function IssueDetailLabelsBox({ title, labels, allLabels }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const toggleModal = () => setIsShowModal(!isShowModal);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box>
      <SelectBoxHeader title={title} callback={toggleModal}/>
      {isShowModal && <SidebarModal title='Apply labels to this issue' modalType='Labels' contents={allLabels} closeModal={closeModal} />}
      <SelectLabelsContents labels={labels} />
    </Box>
  );
}
