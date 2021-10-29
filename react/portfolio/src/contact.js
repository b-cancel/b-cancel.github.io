import React from "react";
import Typography from "@mui/material/Typography";
import { createTheme, ThemeProvider } from "@mui/material/styles";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faHand,
  faAddressCard,
  faCommentDots,
  faPhone,
  faEnvelope,
} from "@fortawesome/free-solid-svg-icons";
import {} from "@fortawesome/free-regular-svg-icons";
import {} from "@fortawesome/fontawesome-svg-core";
import { faLinkedin, faGithub } from "@fortawesome/free-brands-svg-icons";

import MenuItem from "@mui/material/MenuItem";
import Menu from "@mui/material/Menu";
import Box from "@mui/material/Box";

import MyIconButton from "./myIconButton";
import MyButton from "./myButton";

export default function QuickLinks(props) {
  const [anchorEl, setAnchorEl] = React.useState(null);
  const isMenuOpen = Boolean(anchorEl);
  const handleProfileMenuOpen = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleMenuClose = () => {
    setAnchorEl(null);
  };
  const menuId = "primary-search-account-menu";
  const lightTheme = createTheme({
    palette: {
      mode: "light",
    },
  });
  const darkTheme = createTheme({
    palette: {
      mode: "dark",
    },
  });
  const theme = props.lightMode ? darkTheme : lightTheme;
  const renderMenu = (
    <ThemeProvider theme={theme}>
      <Menu
        anchorEl={anchorEl}
        anchorOrigin={{
          vertical: "top",
          horizontal: "right",
        }}
        id={menuId}
        keepMounted
        transformOrigin={{
          vertical: "top",
          horizontal: "right",
        }}
        open={isMenuOpen}
        onClose={handleMenuClose}
      >
        <MenuItem
          onClick={() => {
            handleMenuClose();
            window.open("https://vcard.link/card/DZIy");
          }}
        >
          <FontAwesomeIcon icon={faAddressCard} />
          <Typography variant="subtitle2" sx={{ pl: "8px" }}>
            Contact Card
          </Typography>
        </MenuItem>
        <MenuItem
          onClick={() => {
            handleMenuClose();
            window.open("sms:(956) 777 2692");
          }}
        >
          <FontAwesomeIcon icon={faCommentDots} />
          <Typography variant="subtitle2" sx={{ pl: "8px" }}>
            Message Me
          </Typography>
        </MenuItem>
        <MenuItem
          onClick={() => {
            handleMenuClose();
            window.open("mailto:bryan.o.cancel@gmail.com");
          }}
        >
          <FontAwesomeIcon icon={faEnvelope} />
          <Typography variant="subtitle2" sx={{ pl: "8px" }}>
            Email Me
          </Typography>
        </MenuItem>
        <MenuItem
          onClick={() => {
            handleMenuClose();
            window.open("tel:(956) 777-2692");
          }}
        >
          <FontAwesomeIcon icon={faPhone} />
          <Typography variant="subtitle2" sx={{ pl: "8px" }}>
            Call Me
          </Typography>
        </MenuItem>
      </Menu>
    </ThemeProvider>
  );

  const itemSpacing = "8px";
  const github = <MyIconButton
  tooltip="Github"
  src="https://github.com/b-cancel"
  icon={faGithub}
  lightMode={props.lightMode}
  sx={{marginRight:itemSpacing}}
/>;
/*
const left = props.lightMode ? <Box/> : github;
const right = props.lightMode ? github : <Box/>;
*/
const left = github;
const right = <Box/>;
  return (
      <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: props.center ? "center" : "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
      {left}
      <MyButton
        variant="outlined"
        tooltip="Contact Me"
        onClick={handleProfileMenuOpen}
        text="Say Hello!"
        color={props.lightMode ? "black" : "white"}
        lightMode={props.lightMode}
        sx={{marginRight:itemSpacing}}
        suffixIcon={
          <FontAwesomeIcon
            icon={faHand}
            transform={{ rotate: -22.5 }}
            color={props.lightMode ? "black" : "white"}
          />
        }
      />
      {right}
      {renderMenu}
      <MyIconButton
        tooltip="Linked-In"
        src="https://www.linkedin.com/in/bryan-cancel-069a197a"
        icon={faLinkedin}
        lightMode={props.lightMode}
      />
    </Box>
  );
}
