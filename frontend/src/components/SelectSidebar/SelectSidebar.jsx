import React, { createContext, useEffect, useState, useReducer } from 'react';

import styled from 'styled-components';

import SelectLabelsBox from './SelectLabelsBox';
import SelectMilestoneBox from './SelectMilestoneBox';
import SelectAssigneesBox from './SelectAssigneesBox';

import { getLabels } from '../../apis/labelsAPI';
import { getMilestones } from '../../apis/milestonesAPI';
import { getUsers } from '../../apis/usersAPI';

export const IssueContext = createContext();

const Sidebar = styled.div`
  width: 400px;
`;

const callbackReducer = (callback) => (issue, { type, key, data }) => {
  let newIssue = { ...issue };

  console.log({ type, key, data });

  switch (type) {
    case 'setIssue':
      newIssue = data;
      return newIssue;
    case 'toggleAssignee':
      if (issue.Assignee.some((user) => user.id === key)) {
        newIssue.Assignee = issue.Assignee.filter((user) => user.id !== key);
      } else {
        newIssue.Assignee = [...issue.Assignee, data];
      }
      break;
    case 'toggleLabel':
      if (issue.Labels.some((label) => label.id === key)) {
        newIssue.Labels = issue.Labels.filter((label) => label.id !== key);
      } else {
        newIssue.Labels = [...issue.Labels, data];
      }
      break;
    case 'toggleMilestone':
      if (issue.Milestone.id === key) {
        newIssue.Milestone = {};
      } else {
        newIssue.Milestone = data;
      }
      break;
    default:
      console.log('unknown dispatch action', { type, key, data });
  }

  callback(newIssue);
  console.log('new issue: ', newIssue);
  return newIssue;
};

const SelectSidebar = ({ initIssue, reducerCallback }) => {
  const [allUsers, setUsers] = useState([]);
  const [allLabels, setLabels] = useState([]);
  const [allMilestones, setMilestones] = useState([]);
  const [issue, dispatch] = useReducer(callbackReducer(reducerCallback), initIssue);

  const fetchItems = async (getItems, setItems) => {
    setItems(await getItems());
  };

  useEffect(() => {
    fetchItems(getUsers, setUsers);
    fetchItems(getLabels, setLabels);
    fetchItems(getMilestones, setMilestones);
    dispatch({ type: 'setIssue', data: initIssue });
  }, [initIssue]);

  return (
    <IssueContext.Provider value={ { issue, dispatch } }>
      <Sidebar>
        <SelectAssigneesBox title='Assignees' assignees={issue.Assignee} allUsers={allUsers} />
        <SelectLabelsBox title='Labels' labels={issue.Labels} allLabels={allLabels} />
        <SelectMilestoneBox title='Milestone' milestone={issue.Milestone} allMilestones={allMilestones} />
      </Sidebar>
    </IssueContext.Provider>
  );
};

export default SelectSidebar;
