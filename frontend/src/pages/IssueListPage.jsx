import React from 'react';

import styled from 'styled-components';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

import { getLabels } from '../apis/labelsAPI';
import { getMilestones } from '../apis/milestonesAPI';

const Page = styled.div`
  padding: 48px 36px;
`;

export default function IssueListPage() {
  const labels = getLabels();
  const milestones = getMilestones();

  return (
    <Page>
      <SearchBar labelCount={labels.length} milestoneCount={milestones.length}/>
      <IssueListNav />
      <IssueList />
    </Page>
  );
}
