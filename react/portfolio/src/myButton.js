import React from "react";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import Tooltip, { tooltipClasses } from '@mui/material/Tooltip';
import { styled } from '@mui/material/styles';
import Zoom from '@mui/material/Zoom';

const WhiteOnBlackToolTip = styled(({ className, ...props }) => (
  <Tooltip {...props} classes={{ popper: className }} />
))(({ theme }) => ({
  [`& .${tooltipClasses.tooltip}`]: {
    maxWidth: 'none',
    backgroundColor: "white",
    color: 'black',
    fontSize: 12,
  },
}));

const ErrorToolTip = styled(({ className, ...props }) => (
  <Tooltip {...props} classes={{ popper: className }} />
))(({ theme }) => ({
  [`& .${tooltipClasses.tooltip}`]: {
    maxWidth: 'none',
    backgroundColor: "red",
    color: 'white',
    fontSize: 14,
  },
}));

/// variant, tooltip, color, onClick, suffixIcon, text, startIcon
export default function MyButton(props) {
  const child = props.child ? (
    props.child
  ) : (
    <Typography style={{ textTransform: "none" }} color={props.color}>
      {props.text}
    </Typography>
  );

  const computedStyle = props.variant === "contained" ? {
    backgroundColor: props.color,
  } : {
    borderColor: props.color,
  };

  const theButton = <Button
  variant={props.variant}
  onClick={props.onClick}
  startIcon={props.prefixIcon}
  endIcon={props.suffixIcon}
  style={computedStyle}
  sx={props.sx}
>
  {child}
</Button>;

  if(props.repoIsPrivate){
    return (
      <ErrorToolTip title="Private Repository" TransitionComponent={Zoom} placement="top">
        {theButton}
      </ErrorToolTip>
    );
  } else {
    return (
      <WhiteOnBlackToolTip title={props.tooltip} TransitionComponent={Zoom} placement="top">
        {theButton}
      </WhiteOnBlackToolTip>
    );
  }
}
