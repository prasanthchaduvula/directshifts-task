import React from "react";

import Container from "@mui/material/Container";

import InvitationList from "./InvitationsList";
import Invite from "./Invite";

import NavBar from "../NavBar";

const Home = () => (
  <Container maxWidth={false} sx={{ margin: 0, padding: 0 }}>
    <NavBar />
    <Invite />
    <InvitationList />
  </Container>
);

export default Home;
