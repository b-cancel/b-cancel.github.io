import React from "react";
import Tooltip from "@mui/material/Tooltip";
import Zoom from "@mui/material/Zoom";
import { withStyles } from "@material-ui/core/styles";

const WhiteOnBlack = withStyles({
  tooltip: {
    color: "#e0e0e0",
    backgroundColor: "#202020",
    fontSize: "12px",
    maxWidth: "none",
  },
})(Tooltip);

const BlackOnWhite = withStyles({
  tooltip: {
    color: "#202020",
    backgroundColor: "#e0e0e0",
    fontSize: "12px",
    maxWidth: "none",
  },
})(Tooltip);

const WhiteOnRed = withStyles({
  tooltip: {
    color: "#e0e0e0",
    backgroundColor: "red",
    fontSize: "12px",
    maxWidth: "none",
    fontWeight: "bold",
  },
})(Tooltip);

///child
export default function MyToolTip(props) {
  if (props.type === "whiteOnBlack") {
    return (
      <WhiteOnBlack
        title={props.title}
        TransitionComponent={Zoom}
        placement={props.placement}
      >
        {props.child}
      </WhiteOnBlack>
    );
  } else if (props.type === "blackOnWhite") {
    return (
      <BlackOnWhite
        title={props.title}
        TransitionComponent={Zoom}
        placement={props.placement}
      >
        {props.child}
      </BlackOnWhite>
    );
  } else {
    return (
      <WhiteOnRed
        title={props.title}
        TransitionComponent={Zoom}
        placement={props.placement}
      >
        {props.child}
      </WhiteOnRed>
    );
  }
}
