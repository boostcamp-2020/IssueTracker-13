import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';

import IssueListPage from './pages/IssueListPage';
import NewIssuePage from './pages/NewIssuePage';

const App = () => {
  return (
    <div>
      <header>ISSUES</header>
      <Router>
        <Switch>
          <Route path='/new'>
            <NewIssuePage />
          </Route>
          <Route path='/'>
            <IssueListPage />
          </Route>
        </Switch>
      </Router>
    </div>
  )
}

export default App;