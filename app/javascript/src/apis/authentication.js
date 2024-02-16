import axios from "axios";

const signin = payload => axios.post("/users/sign_in", payload);

const signup = payload => axios.post("/users/", payload);

const authenticationApi = {
  signin,
  signup,
};

export default authenticationApi;
