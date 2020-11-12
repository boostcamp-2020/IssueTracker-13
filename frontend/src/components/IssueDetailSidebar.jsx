import React, { useContext } from 'react';

import SelectSidebar from './SelectSidebar/SelectSidebar';

import { IssueDetailContext } from '../pages/IssueDetailPage';
import { updateIssue } from '../apis/issuesAPI';

const updateAndDispatch = (dispatch) => async (issue) => {
  await updateIssue(issue);
  dispatch({ type: 'reLoad', payload: issue });
};

function IssueDetailSidebar () {
  const { issueDetail, dispatch } = useContext(IssueDetailContext);

  return (
    <>
      <SelectSidebar
        initIssue={issueDetail}
        reducerCallback={updateAndDispatch(dispatch)}
      />
    </>
  );
}

export default IssueDetailSidebar;
