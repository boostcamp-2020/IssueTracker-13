import React, { useState, useEffect } from 'react';
import styled from 'styled-components';

import LabelMilestoneHeader from '../components/LabelMilestoneHeader';
import MilestoneListNav from '../components/MilestoneListNav';
import MilestoneList from '../components/MilestoneList';

import { getMilestones } from '../apis/milestonesAPI';

const Page = styled.div`
  padding: 48px 200px;
`;

export default function MilestonesPage() {
  const [milestones, setMilestones] = useState([]);

  useEffect(() => {
    const fetchSetMilestones = async () => {
      const newMilestones = await getMilestones();
      setMilestones(newMilestones);
    };

    fetchSetMilestones();
  }, []);

  return (
    <Page>
      <LabelMilestoneHeader type='milestone'/>
      <MilestoneListNav milestones={ milestones }/>
      <MilestoneList milestones={ milestones }/>
    </Page>
  );
}
