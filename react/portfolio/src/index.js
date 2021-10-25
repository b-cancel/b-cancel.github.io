import React from "react";
import ReactDOM from "react-dom";
import Button from "@mui/material/Button";
import AllProjects from "./projects/project";
import useMediaQuery from "@mui/material/useMediaQuery";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import CssBaseline from "@mui/material/CssBaseline";

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
    },
  });

  return (
    <ThemeProvider theme={darkTheme}>
      <AllProjects/>
    </ThemeProvider>
  );
}

ReactDOM.render(<App />, document.querySelector("#root"));