import React, { useEffect, useState } from "react";

import PropTypes from "prop-types";
import { Route, Switch, BrowserRouter } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import { isPresent } from "utils";
import { setAuthHeaders, registerIntercepts } from "apis/axios";
import { initializeLogger } from "common/logger";
import { AUTH_ROUTES, DASHBOARD_ROUTES } from "../routes";
import { useAuthState, useAuthDispatch } from "contexts/auth";
import { useUserDispatch, useUserState } from "contexts/user";
import {
  clearLocalStorageCredentials,
  getFromLocalStorage,
} from "utils/storage";

const Main = props => {
  const [loading, setLoading] = useState(true);

  const { authToken } = useAuthState();
  const { user: userContextState } = useUserState();
  const userDispatch = useUserDispatch();
  const authDispatch = useAuthDispatch();

  const currentUser = userContextState || props?.user;
  const isLoggedIn = isPresent(authToken) && isPresent(currentUser);

  useEffect(() => {
    userDispatch({ type: "SET_USER", payload: { user: props?.user } });
    initializeLogger();
    registerIntercepts(authDispatch);
    setAuthHeaders(setLoading);
  }, [authDispatch, props?.user, userDispatch]);

  useEffect(() => {
    const previousLoginAuthEmail = getFromLocalStorage("authEmail");
    const hasDeviseUserSessionExpired = !props?.user;
    const sessionExpiredButLocalStorageCredsExist =
      hasDeviseUserSessionExpired && previousLoginAuthEmail;

    if (sessionExpiredButLocalStorageCredsExist) clearLocalStorageCredentials();
  }, [props?.user?.email]);

  const RoutesToRender = () => {
    if(isLoggedIn){
      return DASHBOARD_ROUTES.map(route => (
        <Route
          exact
          component={route.component}
          key={route.path}
          path={route.path}
        />
      ))
    } else {
      return AUTH_ROUTES.map(route => (
        <Route
          exact
          component={route.component}
          key={route.path}
          path={route.path}
        />
      ))
    }
  }

  return (
    <BrowserRouter>
      <ToastContainer />
      <Switch>
        {RoutesToRender()}
      </Switch>
    </BrowserRouter>
  );
};

Main.propTypes = {
  user: PropTypes.object,
};

export default Main;
