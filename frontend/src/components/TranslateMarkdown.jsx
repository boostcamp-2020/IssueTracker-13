import React from 'react';

import ReactMarkdown from 'react-markdown';
import gfm from 'remark-gfm';
import htmlParser from 'react-markdown/plugins/html-parser';

import styled from 'styled-components';

const ShowComment = styled.div`
  height: 200px;
  background-color:white;
  min-height: 200px;
  max-height: 500px;
  border: 1px solid #dfe2e5;
  padding: 8px;
  box-sizing: border-box;
  font-size: 16px;
`;

export default function TranslateMarkdown({ markdown }) {
  const parseHtml = htmlParser({
    isValidNode: (node) => node.type !== 'script',
    processingInstructions: [],
  });

  return (
    <ShowComment>
      <ReactMarkdown astplugins={[parseHtml]}
        plugins={[gfm]}
        allowDangerousHtml
        source={markdown} />
    </ShowComment>
  );
}
