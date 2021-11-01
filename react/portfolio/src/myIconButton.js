import React from "react";
import IconButton from "@mui/material/IconButton";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import MyToolTip from "./tooltips";

/// tooltip, color, onClick, icon
export default function MyIconButton(props) {
  const color = props.lightMode ? "#202020" : "#e0e0e0";
  const iconButton = (
    <a href={props.src} target="_blank" rel="noreferrer">
      <IconButton
        aria-label={props.tooltip}
        component="span"
        onClick={props.onClick}
        sx={props.sx}
      >
        <FontAwesomeIcon icon={props.icon} color={color}/>
      </IconButton>
    </a>
  );

  if (props.lightMode) {
    return (
      <MyToolTip
        title={props.tooltip}
        placement="bottom"
        type="whiteOnBlack"
        child={iconButton}
         />
    );
  } else {
    return (
      <MyToolTip
        title={props.tooltip}
        placement="top"
        type="blackOnWhite"
        child={iconButton} />
    );
  }
}
