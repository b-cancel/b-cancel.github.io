import React from "react";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";

import Button from "@mui/material/Button";
import IconButton from "@mui/material/IconButton";
import Tooltip from "@mui/material/Tooltip";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faHand } from "@fortawesome/free-solid-svg-icons";
import {} from "@fortawesome/free-regular-svg-icons";
import {} from "@fortawesome/fontawesome-svg-core";
import { faLinkedin, faGithub } from "@fortawesome/free-brands-svg-icons";

import MenuItem from "@mui/material/MenuItem";
import Menu from "@mui/material/Menu";

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
  const renderMenu = (
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
      <MenuItem onClick={handleMenuClose}>Virtual Contact Card</MenuItem>
      <MenuItem onClick={handleMenuClose}>Text Me</MenuItem>
      <MenuItem onClick={handleMenuClose}>Email Me</MenuItem>
      <MenuItem onClick={handleMenuClose}>Call Me</MenuItem>
    </Menu>
  );
  return (
    <Stack direction="row" spacing="16px" sx={{ py: "16px", margin: "auto" }}>
      <Button
        variant="outlined"
        onClick={handleProfileMenuOpen}
        endIcon={
          <FontAwesomeIcon icon={faHand} transform={{ rotate: -22.5 }} />
        }
      >
        <Typography style={{ textTransform: "none" }}>Say Hello!</Typography>
      </Button>
      {renderMenu}
      <Tooltip title="GitHub">
        <IconButton
          color="primary"
          aria-label="linked in"
          component="span"
          onClick={() => window.open("https://github.com/b-cancel")}
        >
          <FontAwesomeIcon icon={faGithub} />
        </IconButton>
      </Tooltip>
      <Tooltip title="Linked-In">
        <IconButton
          color="primary"
          aria-label="linked in"
          component="span"
          onClick={() =>
            window.open("https://www.linkedin.com/in/bryan-cancel-069a197a")
          }
        >
          <FontAwesomeIcon icon={faLinkedin} />
        </IconButton>
      </Tooltip>
    </Stack>
  );
}
