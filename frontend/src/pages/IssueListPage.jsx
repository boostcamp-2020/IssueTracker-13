import React from 'react';

import SearchBar from '../components/SearchBar';
import IssueListNav from '../components/IssueListNav';
import IssueList from '../components/IssueList';

const IssueListPage = () => {
  return (
    <div>
      <SearchBar />
      <IssueListNav />
      <IssueList />
    </div>
  );
}

export default IssueListPage;