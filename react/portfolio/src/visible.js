import React, { Component, createRef } from 'react';
import Observer from '@researchgate/react-intersection-observer';
import ReactFreezeframe from 'react-freezeframe';

const getPrintableThreshold = (ratio, range) =>
  range.reduce((prev, curr) =>
    Math.abs(curr - ratio) < Math.abs(prev - ratio) ? curr : prev);

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
    const desiredThreshold = this.props.threshold;
    return (
        <Observer
        onChange={({ isIntersecting, intersectionRatio }) => {
          if(isIntersecting){
            console.log("VISIBLE");
            this.start();
          } else {
            console.log("HIDDEN");
            this.stop();
          }

          //unsure if this is required
          /*
          this.setState({
            visibility: isIntersecting ? true : false,
            threshold: getPrintableThreshold(
              intersectionRatio.toFixed(2),
              [desiredThreshold],
            ),
          });
          */
        }}
        threshold={[desiredThreshold]}
      >
        <ReactFreezeframe
          src={this.props.src}
          ref={this.freeze}
          options={{
            trigger: false,
            overlay: false,
          }}
          onToggle={(items, isPlaying) => this.logEvent('toggle', items, isPlaying)}
          onStart={(items) => this.logEvent('start', items)}
          onStop={(items) => this.logEvent('stop', items)}
        />
      </Observer>
    );
  }

  start() {
    console.log("START");
    this.freeze.current.start();
  }
  stop() {
    console.log("STOP");
    this.freeze.current.stop();
  }
  toggle() {
    this.freeze.current.toggle();
  }
  logEvent(event, items, isPlaying) {
    console.log(event, items, isPlaying);
  }
}