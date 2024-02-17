import React from "react";

import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Container from "@mui/material/Container";
import TextField from "@mui/material/TextField";

import invitationApi from "apis/invitation";

const Invite = () => {
  const handleSubmit = async event => {
    event.preventDefault();

    const form = event.currentTarget;
    const data = new FormData(form);

    const payload = {
      email: data.get("email"),
    };

    try {
      await invitationApi.create({ invitation: payload });
      form.reset();
    } catch (error) {
      logger.error(error);
    }
  };

  return (
    <Container component="main" maxWidth="xs">
      <Box noValidate component="form" sx={{ mt: 1 }} onSubmit={handleSubmit}>
        <TextField
          autoFocus
          fullWidth
          required
          autoComplete="email"
          id="email"
          label="Email Address"
          margin="normal"
          name="email"
        />
        <Button
          fullWidth
          sx={{ mt: 3, mb: 2 }}
          type="submit"
          variant="contained"
        >
          Send Invite
        </Button>
      </Box>
    </Container>
  );
};

export default Invite;
