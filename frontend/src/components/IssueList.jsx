import React from 'react';

import IssueListItem from './IssueListItem';

import { getIssues } from '../apis/issuesAPI';

export default function IssueList() {
  const issues = getIssues();

  return (
    <div>
      {issues.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </div>
  );
}
