import React from "react";
import AllProjects from "./project";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import { SafeAreaProvider } from "react-native-safe-area-context";
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
    
    <SafeAreaProvider>
      <ThemeProvider theme={darkTheme}>
        <Box sx={{ mt: "56px" }}>
          <Stack>
            <AllProjects />
            <Stack sx={{ mb: "56px" }}>
              <QuickLinks />
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
        <Box
          sx={{
            position: "fixed",
            zIndex: 99,
            width: "100%",
            textAlign: "center",
          }}
        >
          <Box
            sx={{
              display: "inline-block",
              backgroundColor: "#fff",
              borderRadius: "8px",
              px: "8px",
              py: "4px",
              my: "8px",
            }}
          >
            <Stack>
              <Typography variant="subtitle2" sx={{ fontWeight: "bold" }}>
                DEV, UX & UI by Bryan Cancel
              </Typography>
            </Stack>
          </Box>
        </Box>
      </ThemeProvider>
    </SafeAreaProvider>
  )};
}