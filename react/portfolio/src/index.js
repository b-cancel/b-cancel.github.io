import React from "react";
import ReactDOM from "react-dom";
import SideBar from "./sidebar";
import Gallery from "./gallery.js";
import { SafeAreaProvider } from "react-native-safe-area-context";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";

class App extends React.Component {
  render() {
    const gallery = <Gallery />;
    return (
      <SafeAreaProvider>
        <Box
          id="topFixed"
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
                DEV, UX & UI by Me
              </Typography>
            </Stack>
          </Box>
        </Box>
        <ReloadingApp child={gallery} />;
      </SafeAreaProvider>
    );
  }
}

class ReloadingApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      menuOpen: false,
    };
  }

  // This keeps your state in sync with the opening/closing of the menu
  // via the default means, e.g. clicking the X, pressing the ESC key etc.
  handleStateChange(state) {
    console.log("STATE CHANGED TO: " + state.isOpen);
    this.setState({ menuOpen: state.isOpen });
    if (state.isOpen) {
      window.openTheMenu();
    } else {
      window.closeTheMenu();
    }

    //we keep track of wether or not the menu is initialized by inspecting this variable
    if (this.isInitialized !== true) {
      //when the menu is initialized... open it
      this.isInitialized = true;
      this.openMenu();
      console.log("AUTO OPENING MENU AFTER INITIALIZATION");
    }
  }

  // This can be used to close the menu, e.g. when a user clicks a menu item
  closeMenu() {
    console.log("TRYING TO CLOSE MENU");
    this.setState({ menuOpen: false });
  }

  openMenu() {
    console.log("TRYING TO OPEN MENU");
    this.setState({ menuOpen: true });
  }

  //<Menu isOpen={ true } />
  //<Menu  />
  //<Menu onClose={ handleOnClose } />
  //<Menu onOpen={ handleOnOpen } />

  // This can be used to toggle the menu, e.g. when using a custom icon
  // Tip: You probably want to hide either/both default icons if using a custom icon
  // See https://github.com/negomi/react-burger-menu#custom-icons
  toggleMenu() {
    this.setState((state) => ({ menuOpen: !state.menuOpen }));
  }

  render() {
    return (
      <div id="outer-container">
        <SideBar
          pageWrapId={"page-wrap"}
          isOpen={this.state.menuOpen}
          onStateChange={(state) => this.handleStateChange(state)}
        />
        <div id="page-wrap">{this.props.child}</div>
      </div>
    );
  }
}

const rootElement = document.getElementById("app");
ReactDOM.render(<App />, rootElement);
