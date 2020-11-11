import React, { useEffect, createContext, useReducer } from 'react';
import { useParams } from 'react-router-dom';

import IssueDetailHeader from '../components/IssueDetailHeader';
import IssueDetailSidebar from '../components/IssueDetailSidebar';
import CommentInput from '../components/CommentInput';
import CommentList from '../components/CommentList';

import { getIssueDetail } from '../apis/issuesAPI';

export const IssueDetailContext = createContext();

const reducer = (state, { type, payload }) => {
  if (type === 'reLoad') {
    return { payload };
  }
  console.log('unknown dispatch action');
  return state;
};

const IssueDetailPage = () => {
  const [issueDetail, dispatch] = useReducer(reducer, { payload: {} });
  const { id } = useParams();

  const fetchIssueDetail = async (id) => {
    const newIssue = await getIssueDetail(id);
    dispatch({ type: 'reLoad', payload: newIssue });
  };

  useEffect(() => {
    fetchIssueDetail(id);
  }, []);

  return (
    <IssueDetailContext.Provider value={ { issueDetail, dispatch } }>
      <IssueDetailHeader />
      <IssueDetailSidebar />
      <CommentList />
      <CommentInput />
    </IssueDetailContext.Provider>
  );
};

export default IssueDetailPage;
