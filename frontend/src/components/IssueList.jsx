import React from 'react';

import IssueListItem from './IssueListItem';

import { issues } from '../mocks/issues.json';

const IssueList = () => {
  return (
    <div>
      {issues.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </div>
  )
}

export default IssueList;