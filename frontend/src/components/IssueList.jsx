import React, { useState, useEffect } from 'react';

import { getIssues } from '../apis/issuesAPI';

import IssueListItem from './IssueListItem';

export default function IssueList() {
  const [issues, setIssues] = useState();

  const fetchIssues = async () => {
    const newIssues = await getIssues();
    setIssues(newIssues);
  };

  useEffect(() => {
    fetchIssues();
  }, []);

  return (
    <div>
      {issues && issues.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </div>
  );
}
