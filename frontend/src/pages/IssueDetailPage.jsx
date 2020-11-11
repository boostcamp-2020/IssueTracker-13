import React, { useEffect } from 'react';
import { useParams } from 'react-router-dom';

import IssueDetailHeader from '../components/IssueDetailHeader';
import IssueDetailSidebar from '../components/IssueDetailSidebar';
import CommentInput from '../components/CommentInput';
import CommentList from '../components/CommentList';

import { getIssueDetail } from '../apis/issuesAPI';

const IssueDetailPage = () => {
  const { id } = useParams();

  const fetchIssueDetail = async (id) => {
    const newIssue = await getIssueDetail(id);
  };

  useEffect(() => {
    fetchIssueDetail(id);
  }, []);

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
