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
    function padLeadingZeros(num, size) {
        var s = num+"";
        while (s.length < size) s = "0" + s;
        return s;
    }

    //height attribute that depends on opened var
    const height = this.state.isOpened ? "auto" : 0;
    const iconColor = this.state.isHovered ? "#202020" : "transparent";
    const titleWeight = this.state.isOpened ? "normal" : "bold";

    //date related
    const number = padLeadingZeros(this.props.number,2);
    const start = `${this.props.startMonth}_${this.props.startYear}`;
    const end = this.props.endMonth ? `${this.props.endMonth}_${this.props.endYear}` : "";
    const duration = `${start} > ${end}`;

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
              alignItems: "center",
            }}
          >
            {this.state.isHovered ? (this.state.isOpened ? (
              <FontAwesomeIcon icon={faMinusSquare} color={iconColor} />
            ) : (
              <FontAwesomeIcon icon={faPlusSquare} color={iconColor} />
            )) : (
                <Typography variant="body1">
                  {number}
                  </Typography>
            )}
            <Stack sx={{ ml: "8px" }}>
            <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                  <Typography variant="body2" fontWeight="bold">
                  {duration}
                  </Typography>
              </AnimateHeight>
              <Typography variant="body1" fontWeight={titleWeight}>
                {this.props.title}
              </Typography>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                  <Typography variant="body2">
                {this.props.company}
                </Typography>
              </AnimateHeight>
              <AnimateHeight
                duration={250}
                height={height}
                style={{ flexShrink: 0 }}
              >
                  <Typography variant="body2">
                {this.props.location}
                </Typography>
              </AnimateHeight>
            </Stack>
          </Box>
        </Box>
      </Stack>
    );
  }
}