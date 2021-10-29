import React from "react";
import QuickLinks from "./contact.js";
import Section from "./section.js";

//burger menu
//push, pushRotate, elastic
import { push as Menu } from "react-burger-menu";

//material
import Grid from "@mui/material/Grid";
import Stack from "@mui/material/Stack";
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";

//window calculation
import useWindowDimensions from "./menuWindow.js";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import measurementToGoldenRatio from "./golden.js";

//icon
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faArrowAltCircleRight } from "@fortawesome/free-solid-svg-icons";
import {} from "@fortawesome/free-regular-svg-icons";
import {} from "@fortawesome/fontawesome-svg-core";

//widget
export default function SideBar(props) {
  //everything slide related below
  const screenSize = useWindowDimensions();
  const screenWidth = screenSize.width;
  const screenHeight = screenSize.height;

  //remove insets
  const insets = useSafeAreaInsets();
  const actualWidth = screenWidth - insets.left - insets.right;
  const actualHeight = screenHeight - insets.top - insets.bottom;

  //calculate header height
  var headerHeight = measurementToGoldenRatio({ value: actualHeight }).small;

  //ideally we want to be visually pleasing
  var largestMenuWidth = measurementToGoldenRatio({ value: actualWidth }).small;

  const smallestDesiredMenuWidth = 260;
  //if our visually pleasing menu size is too small...
  //it must atleast be as large as the smallestDesiredMenuWidth
  if (largestMenuWidth < smallestDesiredMenuWidth) {
    largestMenuWidth = smallestDesiredMenuWidth;
  }

  //our smallestDesiredMenuWidth might be too large
  //to include space for the smallestDesiredTapable Area
  //which is more important because users have to be able to close the menu
  const smallestDesiredTapableWidth = 56 + 24;
  const largestPossibleMenuSize = actualWidth - smallestDesiredTapableWidth;
  if (largestMenuWidth > largestPossibleMenuSize) {
    largestMenuWidth = largestPossibleMenuSize;
  }

  //math to string for use
  const sideBarWidth = `${largestMenuWidth}px`;
  const headerHeightPx = `${headerHeight}px`;

  return (
    <Stack>
      <style
        dangerouslySetInnerHTML={{
          __html: `
              .page-wrap-opened, .bm-burger-button-menu-opened {
                transform: translate3d(${sideBarWidth}, 0px, 0px) !important;
              }
                `,
        }}
      />
      <Menu {...props} width={sideBarWidth}>
        <Box width={sideBarWidth} height={headerHeightPx}>
          <Grid
            container
            spacing={0}
            direction="column"
            justifyContent="center"
            alignItems="center"
            style={{ height: headerHeightPx }}
          >
            <Grid item>
              <Box
                height="96px"
                width="96px"
                backgroundColor="#202020"
                borderRadius="128px"
                padding="16px"
                position="relative"
                sx={{ mb: "8px" }}
              >
                <img
                  src="./graphics/whiteProfile.png"
                  alt="profile"
                  object-fit="contain"
                  heigth="100%"
                  width="100%"
                />
                <img
                  src="./graphics/whiteLoader.gif"
                  alt="profile"
                  className="heart"
                />
              </Box>
            </Grid>
            <Grid item>
              <Typography
                variant="h6"
                color="#202020"
                sx={{ textAlign: "center", mb: "4px" }}
              >
                Hi! I'm Bryan Cancel
              </Typography>
            </Grid>
            <Grid item>
              <QuickLinks lightMode={true} />
            </Grid>
          </Grid>
        </Box>

        <Section title="/ About Me" />

        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <Section title="/ Experience" />

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <a className="menu-item" href="/burgers">
          Burgers
        </a>
        <Section title="/ Education" />

        <a className="menu-item" href="/pizzas">
          Pizzas
        </a>

        <Box
          onClick={() => {
            console.log("clicked");
            props.menuCloser();
          }}
          sx={{
            backgroundColor: "#101010",
            color: "#e0e0e0",
            px: "16px",
            py: "8px",
          }}
        >
          <Stack
            direction="row"
            justifyContent="flex-start"
            alignItems="center"
            spacing="12px"
            className="clickable spreadOnHover"
          >
            <Typography variant="body1" fontWeight="bold">
              / My Work
            </Typography>
            <FontAwesomeIcon icon={faArrowAltCircleRight} />
          </Stack>
        </Box>

        <Section title="/ Tools" />

        <a className="menu-item" href="/desserts">
          Desserts
        </a>
        <a className="menu-item" href="/">
          Home
        </a>

        <Section title="/ Cerifications" />

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

        <Section title="/ Other" />

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
          LAST LAST LAST
        </a>
      </Menu>
    </Stack>
  );
}
