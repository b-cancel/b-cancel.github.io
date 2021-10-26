import React from "react";
import Stack from "@mui/material/Stack";
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

import MyIconButton from "./myIconButton";
import MyButton from "./myButton";

export default function QuickLinks() {
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
  const renderMenu = (
    <ThemeProvider theme={lightTheme}>
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
  return (
    <Stack direction="row" spacing="16px" sx={{ py: "16px", margin: "auto" }}>
      <MyIconButton
        tooltip="Github"
        color="default"
        onClick={() => window.open("https://github.com/b-cancel")}
        icon={faGithub}
      />
      <MyButton
        variant="outlined"
        tooltip="Contact Me"
        onClick={handleProfileMenuOpen}
        color="white"
        text="Say Hello!"
        suffixIcon={
          <FontAwesomeIcon
            icon={faHand}
            transform={{ rotate: -22.5 }}
            color="white"
          />
        }
      />
      {renderMenu}
      <MyIconButton
        tooltip="Linked-In"
        color="default"
        onClick={() =>
          window.open("https://www.linkedin.com/in/bryan-cancel-069a197a")
        }
        icon={faLinkedin}
      />
    </Stack>
  );
}
