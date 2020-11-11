import React from 'react';

import SelectSidebar from './SelectSidebar/SelectSidebar';

import { IssueDetailContext } from '../pages/IssueDetailPage';

const IssueDetailSidebar = () => {
  return (
    <IssueDetailContext.Consumer>
      {value => <SelectSidebar issue={value.issueDetail.payload} dispatch={value.dispatch} />}
    </IssueDetailContext.Consumer>
  );
};

export default IssueDetailSidebar;
