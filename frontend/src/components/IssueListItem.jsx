import React from 'react';

const IssueListItem = ({ issue }) => {
  const { id, title, preview, milestone, labels, author, createAt } = issue;

  return (
    <li>
      {title} {labels.map(label => label.title)} {preview}
      {id} opened{createAt} by {author} milestone{milestone}
    </li>
  );
};

export default IssueListItem;
