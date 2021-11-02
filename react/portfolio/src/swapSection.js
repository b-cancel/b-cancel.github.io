import React from "react";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import AnimateHeight from "react-animate-height";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faMinusSquare, faPlusSquare } from "@fortawesome/free-solid-svg-icons";

///36px was a well selected left the first time
export default class SwapSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isOpened: this.props.isOpened,
      isHovered: false,
    };
  }

  render() {
    //height attribute that depends on opened var
    const height = this.state.isOpened ? "auto" : 0;
    const iconColor = this.state.isHovered ? "#202020" : "transparent";

    //normal "title"
    //hover and closed "D title"
    //hover and opened "U title"
    return (
      <Stack>
        <Box
          sx={{
            color: "#101010",
            backgroundColor: "#e0e0e0",
            pl: `${this.props.left}px`,
            pr: "16px",
            py: "8px",
          }}
          onMouseEnter={() => this.setState({ isHovered: true })}
          onMouseLeave={() => this.setState({ isHovered: false })}
          onClick={() => this.setState({ isOpened: !this.state.isOpened })}
          className="aSection"
        >
          <Stack direction="row">
            {this.state.isOpened ? 
                <FontAwesomeIcon icon={faMinusSquare} color={iconColor}/> : <FontAwesomeIcon icon={faPlusSquare} color={iconColor}/>}
            <Typography variant="body2" fontWeight="bold" sx={{ml:"8px"}}>
              {this.props.title}
            </Typography>
          </Stack>
        </Box>
        <AnimateHeight
          duration={250}
          height={height}
          style={{ flexShrink: 0 }}
        >
          {this.props.child}
        </AnimateHeight>
      </Stack>
    );
  }
}
