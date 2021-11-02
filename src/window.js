import { useState, useEffect } from "react";
import { isMobile } from "react-device-detect";

var oldWindowDimensions;

function getWindowDimensions() {
  const { innerWidth: width, innerHeight: height } = window;
  oldWindowDimensions = {
    width,
    height,
  };
  return oldWindowDimensions;
}

export default function useModifiedWindowDimensions() {
  const [windowDimensions, setWindowDimensions] = useState(
    getWindowDimensions()
  );

  useEffect(() => {
    function handleResize() {
      const oldWindowSize = oldWindowDimensions;
      const currWindowSize = getWindowDimensions();

      //it seems like this should allways be TRUE
      //but it isn't
      //and not checking this first affects performance
      //and the behavior on mobile explained below
      const sameDimensions =
        oldWindowSize.height === currWindowSize.height &&
        oldWindowSize.width === currWindowSize.width;

      //APARENTLY we don't need to pass set our dimensions 
      //if they haven't change on DESKTOP
      //but I'm playing it safe and still setting them since not doing so has no significant difference
      //but the opposite has a higher chance of breaking things
      if (isMobile === false) {
        setWindowDimensions(currWindowSize);
      } else {
        //when we are on mobile...
        //its possible some features are appearing and disapearing dynamically...
        //but we don't want those to change the size of the elements that rely on height and width...
        //so we simply keep our dimmensions on mobile UNLESS an orientation change occurs
        const oldPortrait = oldWindowSize.height > oldWindowSize.width;
        const currPortait = currWindowSize.height > currWindowSize.width;
        const orientationChange = oldPortrait !== currPortait;

        //TODO: I suspect that regardless of whether or not the orientation changes...
        //we can set window dimensions by simply copying our last height into our currWindowSize
        //but I'm unsure so I'll hold off

        //I have no idea why I need to pass the same dimmensions multiple times
        //but If I don't then things won't work properly
        if (orientationChange && sameDimensions === false) {
          //alert("setting dims on mobile " + orientationChange + " || " + sameDimensions);
          setWindowDimensions(currWindowSize);
        }
      }
    }

    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return windowDimensions;
}
