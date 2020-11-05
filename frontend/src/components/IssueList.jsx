import React from 'react';

import IssueListItem from './IssueListItem';

import { getIssues } from '../apis/issuesAPI';

function IssueList() {
  const issues = getIssues();

  return (
    <div>
      {issues.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </div>
  );
}

export default IssueList;
