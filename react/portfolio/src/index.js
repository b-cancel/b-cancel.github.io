import React from "react";
import ReactDOM from "react-dom";
import AllProjects from "./project";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import { SafeAreaProvider } from "react-native-safe-area-context";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import QuickLinks from "./contact.js";

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
    },
  });

  return (
    <SafeAreaProvider>
      <ThemeProvider theme={darkTheme}>
        <Box sx={{ mt: "28px" }}>
          <Stack>
            <AllProjects />
            <QuickLinks />
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
              <Typography variant="subtitle2">
                DEV, UX & UI by Bryan Cancel
              </Typography>
            </Stack>
          </Box>
        </Box>
      </ThemeProvider>
    </SafeAreaProvider>
  );
}

ReactDOM.render(<App />, document.querySelector("#root"));