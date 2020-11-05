import React from 'react';
import { Link } from 'react-router-dom';

export default function NewIssueButton() {
  return (
    <Link to='/new'>
      New issue
    </Link>
  );
}
