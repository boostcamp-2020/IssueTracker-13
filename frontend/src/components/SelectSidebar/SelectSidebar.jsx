import React, { useEffect, useState } from 'react';

import styled from 'styled-components';

import SelectLabelsBox from './SelectLabelsBox';
import SelectMilestoneBox from './SelectMilestoneBox';
import SelectAssigneesBox from './SelectAssigneesBox';

import { getLabels } from '../../apis/labelsAPI';
import { getMilestones } from '../../apis/milestonesAPI';
import { getUsers } from '../../apis/usersAPI';

const Sidebar = styled.div`
  width: 400px;
  border: 1px solid gray;
`;

const IssueDetailSidebar = ({ issue, dispatch }) => {
  const [allUsers, setUsers] = useState([]);
  const [allLabels, setLabels] = useState([]);
  const [allMilestones, setMilestones] = useState([]);

  const fetchItems = async (getItems, setItems) => {
    setItems(await getItems());
  };

  useEffect(() => {
    fetchItems(getUsers, setUsers);
    fetchItems(getLabels, setLabels);
    fetchItems(getMilestones, setMilestones);
  }, []);

  return (
    <Sidebar>
      <SelectAssigneesBox title='Assignees' assignees={issue.Assignee} allUsers={allUsers} dispatch={dispatch}/>
      <SelectLabelsBox title='Lables' labels={issue.Labels} allLabels={allLabels} dispatch={dispatch}/>
      <SelectMilestoneBox title='Milestone' milestone={issue.Milestone} allMilestones={allMilestones} dispatch={dispatch}/>
    </Sidebar>
  );
};

export default IssueDetailSidebar;
