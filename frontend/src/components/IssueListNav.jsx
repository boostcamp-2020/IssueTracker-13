import React, { useState } from 'react';

import IssueListNavButton from './IssueListNavButton';
import IssueListCheckBox from './IssueListCheckBox';

const IssueListNav = () => {
  const [clickedProperty, setClickedProperty] = useState('null');

  const handleClick = (title) => {
    setClickedProperty(title);
  }

  return (
    <div>
      이슈리스트메뉴
      <IssueListCheckBox />
      {clickedProperty}
      <IssueListNavButton title={'Author'} handleClick={handleClick}/>
      <IssueListNavButton title={'Label'} handleClick={handleClick}/>
      <IssueListNavButton title={'Milestones'} handleClick={handleClick}/>
      <IssueListNavButton title={'Assignee'} handleClick={handleClick}/>
    </div>
  )
}

export default IssueListNav;