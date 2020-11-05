import React from 'react';

import { getLabels } from '../apis/labelsAPI';

export default function LabelsPage() {
  const labels = getLabels();

  return (
    <div>Labels Page {labels.length}</div>
  );
}
