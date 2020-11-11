import React from 'react';

import IssueDetailHeader from '../components/IssueDetailHeader';
import IssueDetailSidebar from '../components/IssueDetailSidebar';
import CommentInput from '../components/CommentInput';
import CommentList from '../components/CommentList';

const IssueDetailPage = () => {
  return (
    <>
      <IssueDetailHeader />
      <IssueDetailSidebar />
      <CommentList />
      <CommentInput />
    </>
  );
};

export default IssueDetailPage;
