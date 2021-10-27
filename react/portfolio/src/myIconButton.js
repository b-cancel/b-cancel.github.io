import React from "react";
import IconButton from "@mui/material/IconButton";
import Tooltip, { tooltipClasses } from '@mui/material/Tooltip';
import { styled } from '@mui/material/styles';
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
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

/// tooltip, color, onClick, icon
export default function MyIconButton(props) {
  return (
    <WhiteOnBlackToolTip title={props.tooltip} TransitionComponent={Zoom} placement="top">
      <IconButton
        color={props.color}
        aria-label={props.tooltip}
        component="span"
        onClick={props.onClick}
        sx={props.sx}
      >
        <FontAwesomeIcon icon={props.icon} />
      </IconButton>
    </WhiteOnBlackToolTip>
  );
}
