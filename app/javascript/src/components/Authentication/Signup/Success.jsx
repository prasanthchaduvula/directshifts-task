import React from "react";  
import Avatar from '@mui/material/Avatar';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';

const SuccessfulSignup = () => {
  return (
    <Box
      sx={{
        marginTop: 8,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
      }}
    >
      <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
        <LockOutlinedIcon />
      </Avatar>
      <Box sx={{ mt: 3 }}>
        <Grid container justifyContent="flex-end">
          <Grid item>
            Successfully signed up.
          </Grid>
          <Grid item>
            <Link href="/signin" variant="body2">
              Sign in
            </Link>
          </Grid>
        </Grid>
      </Box>
    </Box>
  )
}

export default SuccessfulSignup