import React, { useState } from 'react';

import styled from 'styled-components';

import SelectBoxHeader from './SelectBoxHeader';
import SelectLabelsContents from './SelectLabelsContents';
import FilterModal from '../FilterModal';

const Box = styled.div``;

export default function IssueDetailLabelsBox({ title, labels, allLabels }) {
  const [isShowModal, setIsShowModal] = useState(false);

  const openModal = () => setIsShowModal(true);
  const closeModal = () => setIsShowModal(false);

  return (
    <Box onBlur={closeModal} onFocus={openModal}>
      <SelectBoxHeader title={title} callback={() => setIsShowModal}/>
      {isShowModal && <FilterModal title='Apply labels to this issue' contents={allLabels} setIsShowModal={setIsShowModal}/>}
      <SelectLabelsContents labels={labels} />
    </Box>
  );
}
