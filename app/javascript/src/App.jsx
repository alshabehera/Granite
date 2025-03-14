import React from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import { ToastContainer } from "react-toastify";

import Dashboard from "components/Dashboard";
import { CreateTask, ShowTask, EditTask } from "components/Tasks";

import Signup from "./components/Authentication/Signup";

const App = () => (
  <Router>
    <ToastContainer />
    <Switch>
      <Route exact component={EditTask} path="/tasks/:slug/edit" />
      <Route exact component={ShowTask} path="/tasks/:slug/show" />
      <Route exact component={CreateTask} path="/dashboard/create" />
      <Route exact component={Dashboard} path="/dashboard" />
      <Route exact component={Signup} path="/signup" />
    </Switch>
  </Router>
);

export default App;
