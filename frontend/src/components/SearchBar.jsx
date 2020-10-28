import React from 'react';

import SearchInput from './SearchInput';
import PropertyButton from './PropertyButton';
import NewIssueButton from './NewIssueButton';

const SearchBar = () => {
  return (
    <div>
      <SearchInput/>
      <PropertyButton/>
      <NewIssueButton/>
    </div>
  )
}

export default SearchBar;