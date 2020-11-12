import React from 'react';

import styled from 'styled-components';

import PropertyButton from './PropertyButton';
import NewButton from './NewButton';

import { labelImgPath, milestoneImgPath } from '../assets/icons';

const Bar = styled.div`
  display: flex;
  position: relative;
`;

export default function LabelMilestoneHeader({ type }) {
  const currentPath = window.location.pathname;

  return (
    <Bar>
      <PropertyButton
        route='/labels'
        text='Labels'
        imgPath={labelImgPath}
        selected={currentPath === '/labels'} />
      <PropertyButton
        route='/milestones'
        text='Milestones'
        imgPath={milestoneImgPath}
        selected={currentPath === '/milestones'} />
      <NewButton
        route={`/${type}/new`}
        text={type}
      />
    </Bar>
  );
}
