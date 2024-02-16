import axios from "axios";

const signin = payload => axios.post("/users/login", { user: payload });

const signup = payload => axios.post("/users/sign_up", { user: payload });


const authenticationApi = {
  signin,
  signup,
};

export default authenticationApi;
