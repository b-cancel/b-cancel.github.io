import React from "react";
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";

export default function Section(props) {
  //normal "title"
  //hover and closed "% cd title"
  //hover and opened "title % cd.."
  return (
    <Box
      sx={{
        color: "#101010",
        backgroundColor: "#e0e0e0",
        px: "16px",
        py: "8px",
      }}
    >
      <Typography variant="body1" fontWeight="bold">
        {props.title}
      </Typography>
    </Box>
  );
}
