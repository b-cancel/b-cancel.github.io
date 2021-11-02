import React from "react";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import AnimateHeight from "react-animate-height";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faChevronDown, faChevronRight } from "@fortawesome/free-solid-svg-icons";

///36px was a well selected left the first time
export default class EducationSwapItem extends React.Component {
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
    const extraTitle = this.state.isOpened ? "" : `,${this.props.gpa}`;
    const gpaLine = this.props.gpa + " | " + this.props.gpaDetail;

    //normal "title"
    //hover and closed "D title"
    //hover and opened "U title"
    return (
      <Stack>
        <Box
          sx={{
            color: "#202020",
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
          <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "flex-start",
            }}
          >
            <Box sx={{ width: "18px" }}>
              {this.state.isOpened ? (
                <FontAwesomeIcon icon={faChevronDown} color={iconColor} />
              ) : (
                <FontAwesomeIcon icon={faChevronRight} color={iconColor} />
              )}
            </Box>
            <Stack sx={{ ml: "8px" }}>
              <Typography variant="body2" fontWeight="bold">
                {this.props.title}
                {extraTitle}
              </Typography>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                <Typography variant="body2">
                  {this.props.institution}
                </Typography>
              </AnimateHeight>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                <Typography variant="body2">{gpaLine}</Typography>
              </AnimateHeight>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                <Typography variant="body2">{this.props.graduation}</Typography>
              </AnimateHeight>
            </Stack>
          </Box>
        </Box>
      </Stack>
    );
  }
}
//coursework={anEducation.coursework}
