import React, { useEffect, useState } from 'react';
import styled from 'styled-components';

import LabelMilestoneHeader from '../components/LabelMilestoneHeader';
import LabelListNav from '../components/LabelListNav';
import LabelList from '../components/LabelList';

import { getLabels } from '../apis/labelsAPI';

const Page = styled.div`
  padding: 48px 200px;
`;

export default function LabelsPage() {
  const [labels, setLabels] = useState([]);

  useEffect(() => {
    const fetchSetLabels = async () => {
      const newLabels = await getLabels();
      setLabels(newLabels);
    };
    fetchSetLabels();
  }, []);

  return (
    <Page>
      <LabelMilestoneHeader type='label'/>
      <LabelListNav labels={ labels }/>
      <LabelList labels={ labels }/>
    </Page>
  );
}
