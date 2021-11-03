import React from "react";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import AnimateHeight from "react-animate-height";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faMinusSquare, faPlusSquare } from "@fortawesome/free-solid-svg-icons";

///36px was a well selected left the first time
export default class ExperienceSwapItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isOpened: this.props.isOpened,
      isHovered: false,
    };
  }

  render() {
    function padLeadingZeros(num, size) {
      var s = num + "";
      while (s.length < size) s = "0" + s;
      return s;
    }

    //height attribute that depends on opened var
    const height = this.state.isOpened ? "auto" : 0;
    const iconColor = this.state.isHovered ? "#202020" : "transparent";
    const numberWeight = this.state.isOpened ? "bold" : "normal";

    //date related
    const number = padLeadingZeros(this.props.number, 2);
    const start = `${this.props.startMonth}_${this.props.startYear}`;
    const end = this.props.endMonth
      ? `${this.props.endMonth}_${this.props.endYear}`
      : "";
    const duration = `${start} > ${end}`;

    //normal "title"
    //hover and closed "D title"
    //hover and opened "U title"
    const toggleState = () => this.setState({ isOpened: !this.state.isOpened });
    const hoverStart = () => this.setState({ isHovered: true });
    const hoverEnd = () => this.setState({ isHovered: true });

    console.log(this.props.companyLink + " is the link");

    //build
    return (
        <Box
          sx={{
            color: "#202020",
            backgroundColor: "#e0e0e0",
            pl: `${this.props.left}px`,
            pr: "16px",
            py: "8px",
          }}
          onMouseEnter={this.state.isOpened ? null : hoverStart}
          onMouseLeave={this.state.isOpened ? null : hoverEnd}
          onClick={this.state.isOpened ? null : toggleState}
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
            <Box
              sx={{ width: "18px" }}
              onMouseEnter={this.state.isOpened ? hoverStart : null}
              onMouseLeave={this.state.isOpened ? hoverEnd : null}
              onClick={this.state.isOpened ? toggleState : null}
            >
              {this.state.isHovered ? (
                this.state.isOpened ? (
                  <FontAwesomeIcon icon={faMinusSquare} color={iconColor} />
                ) : (
                  <FontAwesomeIcon icon={faPlusSquare} color={iconColor} />
                )
              ) : (
                <Typography variant="body2" fontWeight={numberWeight}>
                  {number}
                </Typography>
              )}
            </Box>
            <Stack sx={{ ml: "8px" }}>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                <Typography variant="body2">{duration}</Typography>
              </AnimateHeight>
              <Typography variant="body2" fontWeight="bold">
                {this.props.title}
              </Typography>
              <a href={this.props.companyLink} target="_blank" rel="noreferrer">
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                
                  <Typography variant="body2" className="underlineLinks">{this.props.company}</Typography>
                
              </AnimateHeight>
              </a>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                <Typography variant="body2">{this.props.location}</Typography>
              </AnimateHeight>
            </Stack>
          </Box>
        </Box>
    );
  }
}
