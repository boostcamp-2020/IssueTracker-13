import React from 'react';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

import { getLabels } from '../apis/labelsAPI';
import { getMilestones } from '../apis/milestonesAPI';

const IssueListPage = () => {
  const labels = getLabels();
  const milestones = getMilestones();

  return (
    <div>
      <SearchBar labelCount={labels.length} milestoneCount={milestones.length}/>
      <IssueListNav />
      <IssueList />
    </div>
  );
};

export default IssueListPage;
