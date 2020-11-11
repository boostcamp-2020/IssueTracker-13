import React from 'react';

import MilestoneListItem from './MilestoneListItem';

export default function MilestoneList({ milestones }) {
  return (
    <div>
      {milestones.map((milestone, i) => <MilestoneListItem key={i} milestone={milestone}/>)}
    </div>
  );
}
