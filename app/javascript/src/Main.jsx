import React from "react";
import {
  Navigate,
  Routes,
  Route,
} from "react-router-dom";

import { AUTH_ROUTES } from "routes";

const Main = () => {
  return (
    <Routes>
      {AUTH_ROUTES.map(route => (
        <Route
          element={<route.component />}
          key={route.path}
          path={route.path}
        />
      ))}
      <Route element={<Navigate to="/" />} path="*" />
    </Routes>
  );
};


export default Main;
