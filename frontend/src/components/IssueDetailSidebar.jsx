import React from 'react';

import SelectSidebar from './SelectSidebar/SelectSidebar';

import { IssueDetailContext } from '../pages/IssueDetailPage';
import { updateIssue } from '../apis/issuesAPI';

const updateAndDispatch = (dispatch) => async (issue) => {
  await updateIssue(issue);
  dispatch({ type: 'reLoad', payload: issue });
};

const IssueDetailSidebar = () => {
  return (
    <IssueDetailContext.Consumer>
      {value => <SelectSidebar initIssue={value.issueDetail.payload} reducerCallback={updateAndDispatch(value.dispatch)} />}
    </IssueDetailContext.Consumer>
  );
};

export default IssueDetailSidebar;
