import React from 'react';

import { getLabels } from '../apis/labelsAPI';

const LabelsPage = () => {
  const labels = getLabels();

  return (
    <div>Labels Page {labels.length}</div>
  );
};

export default LabelsPage;
