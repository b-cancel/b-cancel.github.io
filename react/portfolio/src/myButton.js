import React from "react";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import Tooltip, { tooltipClasses } from "@mui/material/Tooltip";
import { styled } from "@mui/material/styles";
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

const ErrorToolTip = styled(({ className, ...props }) => (
  <Tooltip {...props} classes={{ popper: className }} />
))(({ theme }) => ({
  [`& .${tooltipClasses.tooltip}`]: {
    maxWidth: "none",
    backgroundColor: "red",
    color: "white",
    fontSize: 14,
    fontWeight: "bold",
  },
}));

/// variant, tooltip, color, onClick, suffixIcon, text, startIcon
export default function MyButton(props) {
  var color = props.color;
  if(color === undefined){
    color = props.lightMode === undefined ? "inherit" : (props.lightMode ? "#202020" : "#e0e0e0");
  }

  const child = props.child ? (
    props.child
  ) : (
    <Typography style={{ textTransform: "none" }} color={color}>
      {props.text}
    </Typography>
  );

  const computedStyle =
    props.variant === "contained"
      ? {
          backgroundColor: color,
        }
      : {
          borderColor: color,
        };

  const theButton = (
    <Button
      variant={props.variant}
      onClick={props.onClick}
      startIcon={props.prefixIcon}
      endIcon={props.suffixIcon}
      style={computedStyle}
      sx={props.sx}
    >
      {child}
    </Button>
  );

  var buttonWithToolTip = theButton;
  const stringLength = props.tooltip ? props.tooltip.length : 0;
  const hasTooltip = stringLength !== 0;
  const toolTipPosition = props.lightMode ? "bottom" : "top";
  if (hasTooltip || props.repoIsPrivate) {
    buttonWithToolTip = props.repoIsPrivate ? (
      <ErrorToolTip
        title="Private Repository"
        TransitionComponent={Zoom}
        placement={toolTipPosition}
      >
        {theButton}
      </ErrorToolTip>
    ) : props.lightMode ? (
      <WhiteOnBlackToolTip
        title={props.tooltip}
        TransitionComponent={Zoom}
        placement={toolTipPosition}
      >
        {theButton}
      </WhiteOnBlackToolTip>
    ) : (
      <BlackOnWhiteTooltip
        title={props.tooltip}
        TransitionComponent={Zoom}
        placement={toolTipPosition}
      >
        {theButton}
      </BlackOnWhiteTooltip>
    );
  }

  if (props.src) {
    return (
      <a href={props.src} target="_blank" rel="noreferrer">
        {buttonWithToolTip}
      </a>
    );
  } else {
    return buttonWithToolTip;
  }
}
