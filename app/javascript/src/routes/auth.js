import SignUp from "components/Authentication/Signup";
import SignIn from "components/Authentication/Signin";

export const AUTH_ROUTES = [
  {
    path: "/",
    component: SignIn,
  },
  {
    path: "/signup",
    component: SignUp,
  },
  {
    path: "/signin",
    component: SignIn,
  },
 
]