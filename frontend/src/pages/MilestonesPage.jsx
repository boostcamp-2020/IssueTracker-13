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
  const [isOpen, setIsOpen] = useState(true);
  const [milestones, setMilestones] = useState([]);

  useEffect(() => {
    const fetchSetMilestones = async () => {
      const newMilestones = await getMilestones();
      setMilestones(newMilestones);
    };

    fetchSetMilestones();
  }, [setIsOpen]);

  return (
    <Page>
      <LabelMilestoneHeader type='milestone'/>
      <MilestoneListNav milestones={ milestones } setIsOpen={ setIsOpen }/>
      <MilestoneList milestones={ milestones } setMilestones={ setMilestones } isOpen={ isOpen }/>
    </Page>
  );
}
