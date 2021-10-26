import React from "react";
import ReactDOM from "react-dom";
import Button from "@mui/material/Button";
import AllProjects from "./project";
import useMediaQuery from "@mui/material/useMediaQuery";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";
import Box from "@mui/material/Box";

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
    },
  });

  return (
    <ThemeProvider theme={darkTheme} >
      <Box sx={{mt: 7}}>
        <AllProjects/>
      </Box>
    </ThemeProvider>
  );
}

ReactDOM.render(<App />, document.querySelector("#root"));