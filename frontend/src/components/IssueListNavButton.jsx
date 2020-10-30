import React from 'react';

const IssueListNavButton = ({ title, handleClick }) => {
  return (
    <button onClick={() => handleClick(title)}>
      {title}
    </button>
  )
}

export default IssueListNavButton;