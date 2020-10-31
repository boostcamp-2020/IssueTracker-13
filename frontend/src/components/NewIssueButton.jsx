import React from 'react';
import { Link } from 'react-router-dom';

const NewIssueButton = () => {
  return (
    <Link to='/new'>
      New issue
    </Link>
  );
};

export default NewIssueButton;
