import React from "react";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import MyToolTip from "./tooltips";

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
      <MyToolTip
        title="Private Repository"
        placement={toolTipPosition} 
        type="whiteOnRed"
        child={theButton} />
    ) : props.lightMode ? (
      <MyToolTip
        title={props.tooltip}
        placement={toolTipPosition}
        type="whiteOnBlack"
        child={theButton} />
    ) : (
      <MyToolTip
        title={props.tooltip}
        placement={toolTipPosition}
        type="blackOnWhite"
        child={theButton} />
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
