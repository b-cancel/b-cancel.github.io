import React from "react";
import ReactDOM from "react-dom";
import AllProjects from "./project";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import { SafeAreaProvider } from 'react-native-safe-area-context';

function App() {
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
    },
  });

  return (
    <SafeAreaProvider>
    <ThemeProvider theme={darkTheme} >
      <Box sx={{mt:  "56px"}}>
        <AllProjects/>
      </Box>
    </ThemeProvider>
    </SafeAreaProvider>
  );
}

ReactDOM.render(<App />, document.querySelector("#root"));