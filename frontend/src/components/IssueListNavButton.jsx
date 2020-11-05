import React from 'react';

export default function IssueListNavButton({ title, handleClick }) {
  return (
    <button onClick={() => handleClick(title)}>
      {title}
    </button>
  );
}
