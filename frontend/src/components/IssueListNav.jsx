import React from 'react';

import IssueListNavButton from './IssueListNavButton';
import IssueListCheckBox from './IssueListCheckBox';

const IssueListNav = () => {
  return (
    <div>
      이슈리스트메뉴
      <IssueListCheckBox />
      <IssueListNavButton title={'Author'}/>
      <IssueListNavButton title={'Label'}/>
      <IssueListNavButton title={'Projects'}/>
      <IssueListNavButton title={'Milestones'}/>
      <IssueListNavButton title={'Assignee'}/>
      <IssueListNavButton title={'Sort'}/>
    </div>
  )
}

export default IssueListNav;