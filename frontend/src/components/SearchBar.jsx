import React from 'react';

import styled from 'styled-components';

import SearchInput from './SearchInput';
import PropertyButton from './PropertyButton';
import NewIssueButton from './NewIssueButton';

import { labelImgPath, milestoneImgPath } from '../assets/icons';

const Bar = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const Properties = styled.div`
  display: flex;
`;

export default function SearchBar({ labelCount, milestoneCount }) {
  return (
    <Bar>
      <SearchInput />
      <Properties>
        <PropertyButton
          route='/labels'
          text='Labels'
          count={labelCount}
          imgPath={labelImgPath} />
        <PropertyButton
          route='/milestones'
          text='Milestones'
          count={milestoneCount}
          imgPath={milestoneImgPath}/>
      </Properties>
      <NewIssueButton />
    </Bar>
  );
}
