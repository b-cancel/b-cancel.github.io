import React from "react";
import { isMobile } from "react-device-detect";
import Box from "@mui/material/Box";
import { Image } from "react-native";
import MyToolTip from "../tooltips";

export default class PngTool extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isHovered: false,
    };
  }

  render() {
    var theClassName = this.props.tip;
    theClassName = theClassName.replaceAll(" ", "");
    theClassName = theClassName.replaceAll(",", "");
    theClassName = theClassName.replaceAll(".", "");
    const tool = this.state.isHovered ? (
      <Image
        style={{
          tintColor: "black",
          height: `${this.props.size}px`,
          width: `${this.props.size}px`,
        }}
        source={this.props.png}
      />
    ) : (
      <Image
        style={{
          height: `${this.props.size}px`,
          width: `${this.props.size}px`,
        }}
        source={this.props.png}
      />
    );

    //wrap the hovered on non hovered image
    const wrappedTool = (
      <Box
        onMouseEnter={() => this.setState({ isHovered: true })}
        onMouseLeave={() => this.setState({ isHovered: false })}
      >
        <style
          dangerouslySetInnerHTML={{
            __html: `
        .${theClassName} {
            display:inline-block;
        }
          `,
          }}
        />
        <MyToolTip
          title={this.props.tip}
          placement="top"
          child={tool}
          type="whiteOnBlack"
        />
      </Box>
    );

    //less function on mobile
    if (isMobile) {
      return (<Box>{ wrappedTool }</Box>);
    } else {
      return (
        <a
          href={this.props.src}
          target="_blank"
          rel="noreferrer"
          className={theClassName}
        >
          {wrappedTool}
        </a>
      );
    }
  }
}
