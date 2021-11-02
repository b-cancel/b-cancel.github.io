import React from "react";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";
import AnimateHeight from "react-animate-height";

export default class Section extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isOpened: this.props.isOpened,
      isHovered: false,
    };
  }

  render() {
    var heightID = this.props.title;
    heightID = heightID.replaceAll(" ", "");
    //height attribute that depends on opened var
    const height = this.state.isOpened ? "auto" : 0;

    //normal "title"
    //hover and closed "% cd title"
    //hover and opened "title % cd.."
    return (
      <Stack>
        <Box
          sx={{
            color: "#101010",
            backgroundColor: "#e0e0e0",
            px: "16px",
            py: "8px",
          }}
          onMouseEnter={() => this.setState({ isHovered: true })}
          onMouseLeave={() => this.setState({ isHovered: false })}
          onClick={() => this.setState({ isOpened: !this.state.isOpened })}
          className="aSection"
        >
          <Stack direction="row">
            {this.state.isOpened === false && this.state.isHovered ? (
              <Typography variant="body1" sx={{ pr: "8px" }}>
                % cd
              </Typography>
            ) : (
              <Box />
            )}
            <Typography variant="body1" fontWeight="bold">
              {this.props.title}
            </Typography>
            {this.state.isOpened && this.state.isHovered ? (
              <Typography variant="body1" sx={{ pl: "8px" }}>
                % cd..
              </Typography>
            ) : (
              <Box />
            )}
          </Stack>
        </Box>
        <AnimateHeight
          id={heightID}
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
