import React from 'react';

const IssueListItem = ({ issue }) => {
  const { id, title, preview, milestone, labels, author, assignees, isOpen, createAt } = issue;
  return (
    <li>
      {title} {labels.map((label, i) => label.title)} {preview}
      {id} opend{createAt} by {author} milestone{milestone}
    </li>
  )
}

export default IssueListItem;