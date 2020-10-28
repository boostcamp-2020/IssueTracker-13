import React from 'react';


const IssueListNav = () => {
  return (
    <div>
      이슈리스트메뉴
    </div>
  )
}

const SearchInput = () => {
  return (
    <div>
      searchInput
    </div>
  )
}

const PropertyButton = () => {
  return (
    <div>
      propertybutton
    </div>
  )
}

const NewIssueButton = () => {
  return (
    <div>
      newIssueButton
    </div>
  )
}

const SearchBar = () => {
  return (
    <div>
      <SearchInput/>
      <PropertyButton/>
      <NewIssueButton/>
    </div>
  )
}

const IssueListItem = () => {
  return (
    <div>
      Issue1
    </div>
  )
}

const IssueList = () => {
  return (
    <div>
      <IssueListItem />
    </div>
  )
}

const IssueListPage = () => {
  return (
    <div>
      <SearchBar />
      <IssueListNav />
      <IssueList />
    </div>
  );
}


const App = () => {
  return (
    <div>
      <header>ISSUES</header>
      <IssueListPage/>
    </div>
  )
}

export default App;