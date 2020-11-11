import React, { useContext } from 'react';

import { IssueDetailContext } from '../pages/IssueDetailPage';

const IssueDetailHeader = () => {
  const { issueDetail, dispatch } = useContext(IssueDetailContext);
  console.log('issueDetail : ', issueDetail);
  console.log('dispatch : ', dispatch);
  return (
    <>
    </>
  );
};

export default IssueDetailHeader;
