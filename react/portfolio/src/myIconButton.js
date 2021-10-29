import React from "react";
import IconButton from "@mui/material/IconButton";
import Tooltip, { tooltipClasses } from "@mui/material/Tooltip";
import { styled } from "@mui/material/styles";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Zoom from "@mui/material/Zoom";

const WhiteOnBlackToolTip = styled(({ className, ...props }) => (
  <Tooltip {...props} classes={{ popper: className }} />
))(({ theme }) => ({
  [`& .${tooltipClasses.tooltip}`]: {
    maxWidth: "none",
    backgroundColor: "#202020",
    color: "#e0e0e0",
    fontSize: 12,
  },
}));

const BlackOnWhiteTooltip = styled(({ className, ...props }) => (
  <Tooltip {...props} classes={{ popper: className }} />
))(({ theme }) => ({
  [`& .${tooltipClasses.tooltip}`]: {
    maxWidth: "none",
    backgroundColor: "#e0e0e0",
    color: "#202020",
    fontSize: 12,
  },
}));

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
      <WhiteOnBlackToolTip
        title={props.tooltip}
        TransitionComponent={Zoom}
        placement="bottom"
      >
        {iconButton}
      </WhiteOnBlackToolTip>
    );
  } else {
    return (
      <BlackOnWhiteTooltip
        title={props.tooltip}
        TransitionComponent={Zoom}
        placement="top"
      >
        {iconButton}
      </BlackOnWhiteTooltip>
    );
  }
}
