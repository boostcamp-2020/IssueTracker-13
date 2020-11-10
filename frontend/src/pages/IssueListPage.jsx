import React, { createContext, useReducer } from 'react';

import styled from 'styled-components';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

import { getLabels } from '../apis/labelsAPI';
import { getMilestones } from '../apis/milestonesAPI';

const Page = styled.div`
  padding: 48px 200px;
  width: 1500px;
  max-width: none !important;
`;

export const IssuesContext = createContext([]);

const reducer = (state, action) => {
  switch (action.type) {
    case 'setFilterQuery':
      return action.query;
    case 'addFilterQuery':
      return state + action.query;
    default:
      console.log('unknown dispatch action');
      return state;
  }
};

export default function IssueListPage() {
  const [query, dispatch] = useReducer(reducer, []);

  const labels = getLabels();
  const milestones = getMilestones();

  return (
    <Page>
      <IssuesContext.Provider value={ { query, dispatch } }>
        <SearchBar labelCount={labels.length} milestoneCount={milestones.length} />
        <IssueListNav />
        <IssueList />
      </IssuesContext.Provider>
    </Page>
  );
}
