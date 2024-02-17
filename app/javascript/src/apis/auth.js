import axios from "./api";

const signin = payload => axios.post("/api/v1/login", payload);

const signup = payload => axios.post("/users/", payload);

const logout = () => axios.delete("/api/v1/logout");

const authenticationApi = {
  signin,
  signup,
  logout,
};

export default authenticationApi;
