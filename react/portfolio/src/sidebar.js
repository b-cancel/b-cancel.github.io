import React from "react";
import QuickLinks from "./contact.js";
import Section from "./section.js";
import Tool from "./tools.js";

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

const mobile = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="dart" />
        <Tool tool="flutter" />
        <Tool tool="swift" />
            </Box>;
        
        const backend = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
        <Tool tool="firebase" />
        <Tool tool="aws" />
        </Box>;

const web = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="react" />
            <Tool tool="node" />
            <Tool tool="rails" />
            <Tool tool="dotNet" />
            <Tool tool="php" />
            <Tool tool="js" />
            <Tool tool="html" />
            <Tool tool="css" />
            </Box>;

const game = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="unity" />
            <Tool tool="cSharp" />
            </Box>;

            const ide = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="vsCode" />
            <Tool tool="visualStudios" />
            </Box>;

const versionControl =  <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="github" />
        <Tool tool="bitbucket" />
        </Box>;

const builder = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
        <Tool tool="webflow" />
        <Tool tool="wordpress" />
        <Tool tool="shopify" />
        <Tool tool="wix" />
        </Box>;

const graphic = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
          <Tool tool="photoshop" />
          <Tool tool="premiere" />
          </Box>;

          const other = <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "center",
              flexWrap: "wrap",
            }}
          >
            <Tool tool="java" />
            <Tool tool="python" />
            <Tool tool="cPlusPlus" />
            <Tool tool="c" />
            </Box>;

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
                  src="./graphics/profile/whiteProfile.png"
                  alt="profile"
                  object-fit="contain"
                  heigth="100%"
                  width="100%"
                />
                <img
                  src="./graphics/loader/whiteLoader.gif"
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

        <Section title="/ About Me"  isOpened={true} child={
          //creative and quick?
          <Box sx={{mx:"16px", mb:"24px"}}>
            I love to learn!
            <br/>
            <br/>
            That love for learning and the experience gained from the opportunities it's created
            <br/>
            allows me to tackle challenges from many angles,
            gives me a better understanding of the concerns of each team member,
            and enables me to find solutions to even the hardest problems
          </Box>
        }/>

        <Section title="/ Experience"  isOpened={false} child={
          <Box>
            passed this in a box
            </Box>
        }/>

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

        <Section title="/ Tools"  isOpened={false} child={
          <Box>
        {mobile}
        {backend}
        {web}
        {game}
        {ide}
        {versionControl}
        {builder}
        {graphic}
        {other}
            </Box>
        }/>

        <Section title="/ Cerifications"  isOpened={false} child={
          <Box>
            passed this in a box
            </Box>
        }/>
        <Section title="/ Other" isOpened={false} child={
          <Box>
            passed this in a box
            </Box>
        }/>

        <Typography
                variant="body2"
                color="#202020"
                sx={{pb:"56px", mx: "16px"}}
              >
                English & Spanish (read, write, & speak)
              </Typography>
      </Menu>
    </Stack>
  );
}
