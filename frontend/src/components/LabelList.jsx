import React from 'react';

import LabelListItem from './LabelListItem';

export default function LabelList({ labels }) {
  return (
    <div>
      {labels.map((label, i) => <LabelListItem key={i} label={label}/>)}
    </div>
  );
}
