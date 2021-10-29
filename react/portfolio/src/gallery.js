import React from "react";
import AllProjects from "./project";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import QuickLinks from "./contact.js";

export default class Gallery extends React.Component {
  componentDidMount() {
    console.log("Gallery mounted");
  }

  render() {
    const darkTheme = createTheme({
      palette: {
        mode: "dark",
      },
    });

    console.log("rendering gallery");

    return (
      <ThemeProvider theme={darkTheme}>
        <Box sx={{ mt: "56px" }}>
          <Stack>
            <AllProjects />
            <Stack sx={{ mb: "56px" }}>
              <Box sx={{ py: "16px" }}>
                <QuickLinks center={true} />
              </Box>
              <Typography
                variant="subtitle2"
                color="white"
                sx={{ textAlign: "center" }}
              >
                All Right Reserved
              </Typography>
              <Typography
                variant="subtitle2"
                color="white"
                sx={{ textAlign: "center" }}
              >
                @ 2021 Bryan Cancel
              </Typography>
            </Stack>
          </Stack>
        </Box>
      </ThemeProvider>
    );
  }
}
