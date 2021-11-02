import React from "react";
import Box from "@mui/material/Box";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";

export default class Section extends React.Component {
  //TODO: eventually pass is opened in props
  constructor(props) {
    super(props);
    this.state = {
      isOpened: false,
      isHovered: false,
    };
  }

  //normal "title"
  //hover and closed "% cd title"
  //hover and opened "title % cd.."
  render() {
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
          onClick={() => this.setState({ isOpened: !this.state.isOpened})}
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
        {this.state.isOpened ? (
          <Typography variant="body1">OPENED</Typography>
        ) : (
          <Box />
        )}
      </Stack>
    );
  }
}
