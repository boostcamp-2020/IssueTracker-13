import React from 'react';

import IssueListItem from './IssueListItem';
import { IssuesContext } from '../pages/IssueListPage';

export default function IssueList() {
  return (
    <IssuesContext.Consumer>
      {value => value.map((issue, i) => <IssueListItem key={i} issue={issue}/>)}
    </IssuesContext.Consumer>
  );
}
