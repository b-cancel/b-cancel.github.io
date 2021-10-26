import React from "react";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import Tooltip from "@mui/material/Tooltip";

/// variant, tooltip, color, onClick, suffixIcon, text, startIcon
export default function MyButton(props) {
  return (
    <Tooltip title={props.tooltip}>
      <Button
        variant={props.variant}
        onClick={props.onClick}
        startIcon={props.prefixIcon}
        endIcon={props.suffixIcon}
        style={{
          borderColor: props.color,
        }}
        sx={props.sx}
      >
        <Typography style={{ textTransform: "none" }} color={props.color}>
          {props.text}
        </Typography>
      </Button>
    </Tooltip>
  );
}
