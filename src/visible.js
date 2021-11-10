import React, { Component, createRef } from "react";
import Observer from "@researchgate/react-intersection-observer";
import ReactFreezeframe from "react-freezeframe";
import Stack from "@mui/material/Stack";
//import Box from "@mui/material/Box";

//TODO: I should fix this so the GIFs also autoplay when they show while initially showing page
export default class PlayGifWhenVisible extends Component {
  state = {
    visibility: null,
    threshold: 0.01,
  };

  constructor(props) {
    super(props);
    this.freeze = createRef();
  }

  render() {
    var identifier = this.props.identifier;
    const desiredThreshold = this.props.threshold;
    const stylingString = `
      #${identifier} img, #${identifier} canvas {
        height: ${this.props.height}px;
        width: ${this.props.width}px;
        border-radius: ${this.props.borderRadius}px;
      }
    `;

    return (
        <Observer
        onChange={({ isIntersecting, intersectionRatio }) => {
          if (isIntersecting) {
            this.start();
          } else {
            this.stop();
          }
        }}
        threshold={[desiredThreshold]}
      >
        <Stack id={identifier}>
          <style
            dangerouslySetInnerHTML={{
              __html: stylingString,
            }}
          />
          <ReactFreezeframe
            key={this.props.src}
            src={this.props.src}
            ref={this.freeze}
            options={{
              trigger: 'click',
              overlay: true,
            }}
            onToggle={(items, isPlaying) =>
              this.logEvent("toggle", items, isPlaying)
            }
            onStart={(items) => this.logEvent("start", items)}
            onStop={(items) => this.logEvent("stop", items)}
          />
        </Stack>
      </Observer>
    );
  }

  start() {
    this.freeze.current.start();
  }
  stop() {
    this.freeze.current.stop();
  }
  toggle() {
    this.freeze.current.toggle();
  }
  logEvent(event, items, isPlaying) {
    //console.log(event, items, isPlaying);
  }
}
