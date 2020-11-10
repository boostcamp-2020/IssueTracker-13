import React, { useState, useEffect, createContext, useReducer } from 'react';

import styled from 'styled-components';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

import { getLabels } from '../apis/labelsAPI';
import { getMilestones } from '../apis/milestonesAPI';
import { getUsers } from '../apis/usersAPI';

const Page = styled.div`
  padding: 48px 200px;
  width: 1500px;
  max-width: none !important;
`;

export const IssuesContext = createContext([]);

const filterUsedQuery = (state, key) => state.length > 0 ? state.split('&').filter(queryParam => queryParam.split('=')[0] !== key).join('&') : state;

const reducer = (state, { type, query, key }) => {
  if (type === 'setFilterQuery') {
    return query;
  }
  if (type === 'addFilterQuery') {
    const originState = filterUsedQuery(state, key);
    return `${originState}&${query}`;
  }
  console.log('unknown dispatch action');
  return state;
};

export default function IssueListPage() {
  const [query, dispatch] = useReducer(reducer, []);
  const [labels, setLabels] = useState([]);
  const [milestones, setMilestones] = useState([]);
  const [users, setUsers] = useState([]);

  const fetchItems = async (getItems, setItems) => {
    const newItems = await getItems();
    setItems(newItems);
  };

  useEffect(() => {
    fetchItems(getLabels, setLabels);
    fetchItems(getMilestones, setMilestones);
    fetchItems(getUsers, setUsers);
  }, []);

  const providerValue = { query, dispatch, labels, milestones, users };

  return (
    <Page>
      <IssuesContext.Provider value={ providerValue }>
        <SearchBar labelCount={labels.length} milestoneCount={milestones.length} />
        <IssueListNav />
        <IssueList />
      </IssuesContext.Provider>
    </Page>
  );
}
