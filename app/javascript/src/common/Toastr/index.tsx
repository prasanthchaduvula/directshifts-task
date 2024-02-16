import React from "react";

import { toast } from "react-toastify";

import Toast from "./Toast";

const showSuccessToastr = message => {
  toast.success(<Toast message={message} />, {position: "bottom-center",});
};

const isError = e => e && e.stack && e.message;
const isString = e => typeof e === "string" || e instanceof String;
const isArray = e => Array.isArray(e);

const showErrorToastr = error => {
  let errorMessage;

  if (isError(error)) {
    errorMessage = error;
  } else if (isString(error)) {
    errorMessage = error;
  } else if (isArray(error)) {
    errorMessage = error[0];
  } else {
    errorMessage = Object.values(error)[0];
  }

  toast.error(<Toast message={errorMessage} />, {position: "bottom-center"});
};

export const Toastr = {
  success: showSuccessToastr,
  error: showErrorToastr,
};

export default Toastr;
