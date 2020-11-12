import React, { useEffect, createContext, useReducer } from 'react';
import { useParams } from 'react-router-dom';

import styled from 'styled-components';

import IssueDetailHeader from '../components/IssueDetailHeader';
import IssueDetailSidebar from '../components/IssueDetailSidebar';
import CommentList from '../components/CommentList';

import { getIssueDetail } from '../apis/issuesAPI';

const Page = styled.div`
  padding: 48px 200px;
`;

const Div = styled.div`
  display: flex;
`;

const Comments = styled.div`
  width: 100%;
`;

export const IssueDetailContext = createContext();

const reducer = (state, { type, payload }) => {
  if (type === 'reLoad') {
    return payload;
  }
  console.log('unknown dispatch action');
  return state;
};

const IssueDetailPage = () => {
  const [issueDetail, dispatch] = useReducer(reducer, {});
  const { id } = useParams();

  const fetchIssueDetail = async (id) => {
    const newIssue = await getIssueDetail(id);
    dispatch({ type: 'reLoad', payload: newIssue });
  };

  useEffect(() => {
    fetchIssueDetail(id);
  }, []);

  return (
    <Page>
      <IssueDetailContext.Provider value={ { issueDetail, dispatch } }>
        <IssueDetailHeader />
        <Div>
          <Comments>
            <CommentList id={id} />
          </Comments>
          <div>
            <IssueDetailSidebar />
          </div>
        </Div>
      </IssueDetailContext.Provider>
    </Page>
  );
};

export default IssueDetailPage;
