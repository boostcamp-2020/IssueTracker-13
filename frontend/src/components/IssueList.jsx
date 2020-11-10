import React, { useState, useEffect, useContext } from 'react';

import IssueListItem from './IssueListItem';
import { IssuesContext } from '../pages/IssueListPage';

import { getIssues } from '../apis/issuesAPI';

export default function IssueList() {
  const [issues, setIssues] = useState([]);
  const { query } = useContext(IssuesContext);

  const fetchIssues = async () => {
    const newIssues = await getIssues(query);
    setIssues(newIssues);
  };

  useEffect(() => {
    fetchIssues();
  }, [query]);

  return (
    <>
      {issues.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </>
  );
}
