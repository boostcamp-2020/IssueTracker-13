import React, { createContext, useContext, useState } from 'react';
import { BrowserRouter as Router, Switch, Route, Redirect } from 'react-router-dom';

import IssueListPage from './pages/IssueListPage';
import MilestonesPage from './pages/MilestonesPage';
import NewIssuePage from './pages/NewIssuePage';
import LabelsPage from './pages/LabelsPage';
import IssueDetailPage from './pages/IssueDetailPage';
import LoginPage from './pages/LoginPage';

import Header from './components/Header';
import { signInWithLocal, signUpWithLocal } from './apis/authAPI';

const authContext = createContext();

export const useAuth = () => {
  return useContext(authContext);
};

const jwtAuth = {
  isAuthenticated: false,
  async signIn(info, callback) {
    try {
      const user = await signInWithLocal(info);
      jwtAuth.isAuthenticated = true;
      callback(user);
    } catch (error) {
      alert(error);
      callback(null);
    }
  },
  async signUp(info, callback) {
    try {
      const user = await signUpWithLocal(info);
      jwtAuth.isAuthenticated = true;
      callback(user);
    } catch (error) {
      alert(error);
      callback(null);
    }
  },
  async signOut(callback) {
    jwtAuth.isAuthenticated = false;
    setTimeout(callback, 100);
  },
};

const useProvideAuth = () => {
  const [user, setUser] = useState(null);

  const signIn = (info, callback) => {
    return jwtAuth.signIn(info, (newUser) => {
      setUser(newUser);
      callback();
    });
  };

  const signUp = (info, callback) => {
    return jwtAuth.signUp(info, (newUser) => {
      setUser(newUser);
      callback();
    });
  };

  const signOut = (info, callback) => {
    return jwtAuth.signOut(info, () => {
      setUser(null);
      callback();
    });
  };

  return { user, signIn, signUp, signOut };
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
