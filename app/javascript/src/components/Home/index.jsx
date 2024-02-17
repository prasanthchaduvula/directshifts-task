import React from "react";

import Container from "@mui/material/Container";

import Invite from "./Invite";

import NavBar from "../NavBar";

const Home = () => (
  <Container maxWidth={false} sx={{ margin: 0, padding: 0 }}>
    <NavBar />
    <Invite />
  </Container>
);

export default Home;
