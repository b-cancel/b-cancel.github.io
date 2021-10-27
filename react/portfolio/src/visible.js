import React, { Component } from 'react';
import Observer from '@researchgate/react-intersection-observer';

const getPrintableThreshold = (ratio, range) =>
  range.reduce((prev, curr) =>
    Math.abs(curr - ratio) < Math.abs(prev - ratio) ? curr : prev);

export default class PlayGifWhenVisible extends Component {
  state = {
    visibility: null,
    threshold: 0,
  };

  render() {
    const desiredThreshold = this.props.threshold;
    return (
        <Observer
        onChange={({ isIntersecting, intersectionRatio }) => {
          this.setState({
            visibility: isIntersecting ? true : false,
            threshold: getPrintableThreshold(
              intersectionRatio.toFixed(2),
              [desiredThreshold],
            ),
          });
        }}
        threshold={[desiredThreshold]}
      >
        <div className={`box ${this.state.visibility}`} />
      </Observer>
    );
  }
}