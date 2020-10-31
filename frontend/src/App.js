import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';

import IssueListPage from './pages/IssueListPage';
import MilestonesPage from './pages/MilestonesPage';
import NewIssuePage from './pages/NewIssuePage';
import LabelsPage from './pages/LabelsPage';

const App = () => {
  return (
    <div>
      <header>ISSUES</header>
      <Router>
        <Switch>
          <Route path='/new'>
            <NewIssuePage />
          </Route>
          <Route path='/milestones'>
            <MilestonesPage />
          </Route>
          <Route path='/labels'>
            <LabelsPage />
          </Route>
          <Route path='/'>
            <IssueListPage />
          </Route>
        </Switch>
      </Router>
    </div>
  );
};

export default App;
