import React, { useContext } from 'react';

import SelectSidebar from './SelectSidebar/SelectSidebar';

import { NewIssueContext } from '../pages/NewIssuePage';

const updateAndDispatch = (dispatch) => async (issue) => {
  dispatch({ type: 'add', payload: issue });
};

function NewIssueSidebar () {
  const { issueDetail, dispatch } = useContext(NewIssueContext);

  return (
    <>
      <SelectSidebar
        initIssue={issueDetail}
        reducerCallback={updateAndDispatch(dispatch)}
      />
    </>
  );
}

export default NewIssueSidebar;
