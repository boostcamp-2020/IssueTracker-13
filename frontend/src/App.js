import React, { createContext, useContext, useState } from 'react';
import { BrowserRouter as Router, Switch, Route, useHistory, Redirect } from 'react-router-dom';

import IssueListPage from './pages/IssueListPage';
import MilestonesPage from './pages/MilestonesPage';
import NewIssuePage from './pages/NewIssuePage';
import LabelsPage from './pages/LabelsPage';
import IssueDetailPage from './pages/IssueDetailPage';
import LoginPage from './pages/LoginPage';

import Header from './components/Header';

const authContext = createContext();

export const useAuth = () => {
  return useContext(authContext);
};

const jwtAuth = {
  isAuthenticated: false,
  signIn(callback) {
    jwtAuth.isAuthenticated = true;
    setTimeout(callback, 100);
  },
  signOut(callback) {
    jwtAuth.isAuthenticated = false;
    setTimeout(callback, 100);
  },
};

const useProvideAuth = () => {
  const [user, setUser] = useState(null);

  const signIn = (callback) => {
    return jwtAuth.signIn(() => {
      setUser('user');
      callback();
    });
  };

  const signOut = (callback) => {
    return jwtAuth.signOut(() => {
      setUser(null);
      callback();
    });
  };

  return { user, signIn, signOut };
};

function ProvideAuth({ children }) {
  const auth = useProvideAuth();
  return (
    <authContext.Provider value={auth}>
      {children}
    </authContext.Provider>
  );
}

function PrivateRoute({ children, ...rest }) {
  let auth = useAuth();
  return (
    <Route {...rest} render={({ location }) =>
      auth.user ? (
        children
      ) : (
        <Redirect
          to={{
            pathname: '/login',
            state: { from: location },
          }}/>
      )}/>
  );
}

const App = () => {
  return (
    <ProvideAuth>
      <Router>
        <Header />
        <Switch>
          <Route path='/login'>
            <LoginPage />
          </Route>
          <PrivateRoute path='/new'>
            <NewIssuePage />
          </PrivateRoute>
          <PrivateRoute path='/milestones'>
            <MilestonesPage />
          </PrivateRoute>
          <PrivateRoute path='/labels'>
            <LabelsPage />
          </PrivateRoute>
          <PrivateRoute path='/issues/:id'>
            <IssueDetailPage />
          </PrivateRoute>
          <PrivateRoute path='/'>
            <IssueListPage />
          </PrivateRoute>
        </Switch>
      </Router>
    </ProvideAuth>
  );
};

export default App;
