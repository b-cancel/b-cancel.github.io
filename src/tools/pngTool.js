import React from "react";
import Box from "@mui/material/Box";
import { Image } from "react-native";
import MyToolTip from "../tooltips";

//TODO: show a png with a black tint at first...
//TODO: that black tint goes away on hover...
//TODO: it also and it displays title of what is being hovered over
//TODO: and it links to that tech stacks page with a link tag

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

    return (
      <a
        href={this.props.src}
        target="_blank"
        rel="noreferrer"
        className={theClassName}
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
        <Box
          onMouseEnter={() => this.setState({ isHovered: true })}
          onMouseLeave={() => this.setState({ isHovered: false })}
        >
          <MyToolTip
            title={this.props.tip}
            placement="top"
            child={tool}
            type="whiteOnBlack"
          />
        </Box>
      </a>
    );
  }
}
