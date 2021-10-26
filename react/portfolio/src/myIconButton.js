import React from "react";
import IconButton from "@mui/material/IconButton";
import Tooltip from "@mui/material/Tooltip";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

/// tooltip, color, onClick, icon
export default function MyIconButton(props) {
  return (
    <Tooltip title={props.tooltip}>
      <IconButton
        color={props.color}
        aria-label={props.tooltip}
        component="span"
        onClick={props.onClick}
        sx={props.sx}
      >
        <FontAwesomeIcon icon={props.icon} />
      </IconButton>
    </Tooltip>
  );
}
