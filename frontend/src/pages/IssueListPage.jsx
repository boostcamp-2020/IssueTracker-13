import React, { createContext, useState, useEffect } from 'react';

import styled from 'styled-components';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

import { getLabels } from '../apis/labelsAPI';
import { getMilestones } from '../apis/milestonesAPI';
import { getIssues } from '../apis/issuesAPI';

const Page = styled.div`
  padding: 48px 200px;
  width: 1500px;
  max-width: none !important;
`;

export const IssuesContext = createContext([]);

export default function IssueListPage() {
  const [issues, setIssues] = useState([]);

  const labels = getLabels();
  const milestones = getMilestones();

  const fetchIssues = async () => {
    const newIssues = await getIssues();
    setIssues(newIssues);
  };

  useEffect(() => {
    fetchIssues();
  }, []);

  return (
    <Page>
      <IssuesContext.Provider value={ issues }>
        <SearchBar labelCount={labels.length} milestoneCount={milestones.length} />
        <IssueListNav />
        <IssueList />
      </IssuesContext.Provider>
    </Page>
  );
}
