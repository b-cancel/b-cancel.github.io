import { useState, useEffect } from 'react';
import {isMobile} from 'react-device-detect';

var oldWindowDimensions;

function getWindowDimensions() {
  const { innerWidth: width, innerHeight: height } = window;
  oldWindowDimensions = {
    width,
    height
  };
  return oldWindowDimensions;
}

export default function useWindowDimensions() {
  const [windowDimensions, setWindowDimensions] = useState(getWindowDimensions());

  useEffect(() => {
    function handleResize() {
      const oldWindowSize = oldWindowDimensions;
      const oldPortrait = oldWindowSize.height > oldWindowSize.width;
      const currWindowSize = getWindowDimensions();
      const currPortait = currWindowSize.height > currWindowSize.width;
      const orientationChange = oldPortrait !== currPortait;

      //when we are on mobile... 
      //its possible some features are appearing and disapearing dynamically...
      //but we don't want those to change the size of the elements that rely on height and width...
      //so we simply keep our dimmensions on mobile UNLESS an orientation change occurs
      if (isMobile === false) {
        setWindowDimensions(currWindowSize);
      } else {
        if(orientationChange){
          setWindowDimensions(currWindowSize);
        }
      }
    }

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  return windowDimensions;
}