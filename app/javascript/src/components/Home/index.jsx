import React, { useEffect, useState } from "react";

import Container from "@mui/material/Container";

import invitationApi from "apis/invitation";

import InvitationList from "./InvitationsList";
import Invite from "./Invite";

import NavBar from "../NavBar";

const Home = () => {
  const [invitations, setInvitations] = useState([]);

  useEffect(() => {
    fetchInvitations();
  }, []);

  const fetchInvitations = async () => {
    try {
      const res = await invitationApi.get();
      setInvitations(res.data.invitations);
    } catch (error) {
      logger.error(error);
    }
  };

  return (
    <Container maxWidth={false} sx={{ margin: 0, padding: 0 }}>
      <NavBar />
      <Invite fetchInvitations={fetchInvitations} />
      <InvitationList invitations={invitations} />
    </Container>
  );
};

export default Home;
