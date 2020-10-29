import React from 'react';

import SearchInput from './SearchInput';
import PropertyButton from './PropertyButton';
import NewIssueButton from './NewIssueButton';


const SearchBar = ({ labelCount, milestoneCount }) => {
  return (
    <div>
      <SearchInput />
      <PropertyButton route='/labels' text='Labels' count={labelCount} />
      <PropertyButton route='/milestones' text='Milestones' count={milestoneCount} />
      <NewIssueButton />
    </div>
  )
}

export default SearchBar;