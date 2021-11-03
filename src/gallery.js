import React from "react";
import AllProjects from "./project";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import QuickLinks from "./contact.js";

export default class Gallery extends React.Component {
  render() {
    const darkTheme = createTheme({
      typography: {
        fontFamily: "Courier New, monospace",
      },
      palette: {
        mode: "dark",
      },
    });

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
                color="#e0e0e0"
                sx={{ textAlign: "center" }}
              >
                All Right Reserved
              </Typography>
              <Typography
                variant="subtitle2"
                color="#e0e0e0"
                sx={{ textAlign: "center" }}
              >
                @ 2021 Bryan Cancel
              </Typography>
              <Box className="pageViews" sx={{mt:"0px", textAlign:"center"}}>
                <a href="https://www.hitwebcounter.com" target="_blank">
                  <img
                    src="https://hitwebcounter.com/counter/counter.php?page=7891501&style=0007&nbdigits=5&type=page&initCount=0"
                    title="Free Counter"
                    alt="web counter"
                    border="0"
                  />
                </a>
              </Box>
              <Box className="uniqueVisitors" sx={{mt:"0px", textAlign:"center"}}>
                <a href="https://www.hitwebcounter.com" target="_blank">
                  <img
                    src="https://hitwebcounter.com/counter/counter.php?page=7891500&style=0007&nbdigits=5&type=ip&initCount=0"
                    title="Free Counter"
                    alt="web counter"
                    border="0"
                  />
                </a>
              </Box>
            </Stack>
          </Stack>
        </Box>
      </ThemeProvider>
    );
  }
}
