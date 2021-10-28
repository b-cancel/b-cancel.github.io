import React from "react";
//push, pushRotate, elastic
import { push as Menu } from "react-burger-menu";
import Stack from "@mui/material/Stack";

//window calculation
import useWindowDimensions from "./window.js";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import measurementToGoldenRatio from "./golden.js";

export default function SideBar(props) {
  //everything slide related below
  const { height, width } = useWindowDimensions();

  //remove insets
  const insets = useSafeAreaInsets();
  const actualHeight = height - insets.top - insets.bottom;
  const actualWidth = width - insets.left - insets.right;

  //ideally we want to be visually pleasing
  var largestMenuWidth;
  const golden = measurementToGoldenRatio({ value: actualWidth });
  largestMenuWidth = golden.small;

  const smallestDesiredMenuWidth = 360;
  //if our visually pleasing menu size is too small...
  //it must atleast be as large as the smallestDesiredMenuWidth
  if (largestMenuWidth < smallestDesiredMenuWidth) {
    largestMenuWidth = smallestDesiredMenuWidth;
  }

  //our smallestDesiredMenuWidth might be too large
  //to include space for the smallestDesiredTapable Area
  //which is more important because users have to be able to close the menu
  const smallestDesiredTapableWidth = 56;
  const largestPossibleMenuSize = actualWidth - smallestDesiredTapableWidth;
  if (largestMenuWidth > largestPossibleMenuSize) {
    largestMenuWidth = largestPossibleMenuSize;
  }

  //math to string for use
  const sideBarWidth = `${largestMenuWidth}px`;

  return (
    <Stack>
      <style
        dangerouslySetInnerHTML={{
          __html: `
              .page-wrap-opened {
                transform: translate3d(${sideBarWidth}, 0px, 0px) !important;
              }
                `,
        }}
      />
      <Menu {...props} width={sideBarWidth}>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
      </Menu>
    </Stack>
  );
}
