import axios from "axios";

import { Toastr } from "common/Toastr";
import {
  clearLocalStorageCredentials,
  getFromLocalStorage,
} from "utils/storage";

class ApiHandler {
  constructor() {
    this.axios = axios.create({
      baseURL: "/",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-TOKEN": document
          .querySelector('[name="csrf-token"]')
          .getAttribute("content"),
      },
    });

    this.axios.interceptors.response.use(
      response => {
        if (response) {
          const { data, status } = response;
          response.success = status === 200;
          const { reset_session, notice } = data;
          if (data && !reset_session && notice) {
            Toastr.success(notice);
          }
        }

        return response;
      },
      error => {
        if (error.response?.status === 401) {
          clearLocalStorageCredentials();
          Toastr.error(error.response?.data?.error);
          setTimeout(() => (window.location.href = "/"), 500);
        }

        Toastr.error(
          error.response?.data?.errors ||
            error.response?.data?.error ||
            error.response?.data?.notice ||
            error.message ||
            error.notice ||
            "Something went wrong!"
        );
        if (error.response?.status === 423) {
          setTimeout(() => (window.location.href = "/"), 500);
        }

        return Promise.reject(error);
      }
    );

    this.axios.interceptors.request.use(
      async config => {
        const token = getFromLocalStorage("authToken");
        const email = getFromLocalStorage("authEmail");
        const headers = {
          "X-Auth-Email": email,
          "X-Auth-Token": token,
        };

        const newConfig = {
          ...config,
          headers: {
            ...config.headers,
            ...headers,
          },
        };

        return newConfig;
      },
      error => Promise.reject(error)
    );
  }
}

const Api = new ApiHandler();

export default Api.axios;
