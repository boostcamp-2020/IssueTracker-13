import React from 'react';

import MilestoneListItem from './MilestoneListItem';

export default function MilestoneList({ milestones, setMilestones, isOpen }) {
  const shownMilestones = milestones.filter((milestone) => milestone.isOpen == isOpen);
  return (
    <div>
      {shownMilestones.map((milestone, i) => <MilestoneListItem key={i} milestone={milestone} setMilestones={setMilestones} />)}
    </div>
  );
}
