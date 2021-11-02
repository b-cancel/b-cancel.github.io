import React from "react";
import QuickLinks from "./contact.js";
import Section from "./section.js";
import Tool from "./tools.js";

//burger menu
//push, pushRotate, elastic
import { push as Menu } from "react-burger-menu";

//material
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import Grid from "@mui/material/Grid";
import Chip from '@mui/material/Chip';
import Box from "@mui/material/Box";

//window calculation
import useWindowDimensions from "./menuWindow.js";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import measurementToGoldenRatio from "./golden.js";

//icon
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faArrowAltCircleRight } from "@fortawesome/free-solid-svg-icons";
import {} from "@fortawesome/free-regular-svg-icons";
import {} from "@fortawesome/fontawesome-svg-core";

const iconSpacing = { mt: "4px", mr: "8px" };
const wideIconSpacing = { mt: "4px", mr: "24px" };
const sectionBox = {
  display: "inline-flex",
      flexDirection: "row",
      justifyContent: "flex-start",
      alignItems: "flex-start",
      flexWrap: "wrap",
border: "2px solid black",
borderRadius: "8px",
paddingLeft: "8px",
paddingBotom: "4px",
marginRight: "16px",
marginBottom: "8px",
minHeight: "64px",
}

const mobile = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Mobile
                <br/>
                Dev
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="dart" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="flutter" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="swift" />
    </Box>
  </Box>
);

const backend = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Backend
                <br/>
                Dev
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="firebase" />
    </Box>
    <Box sx={wideIconSpacing}>
      <Tool tool="aws" />
    </Box>
  </Box>
);

const web = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Web
                <br/>
                Dev
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="react" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="node" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="rails" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="dotNet" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="php" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="js" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="html" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="css" />
    </Box>
  </Box>
);

const game = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Game
                <br/>
                Dev
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="unity" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="cSharp" />
    </Box>
  </Box>
);

const ide = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                IDEs
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="vsCode" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="visualStudios" />
    </Box>
  </Box>
);

const versionControl = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Version
                <br/>
                Control
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="github" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="bitbucket" />
    </Box>
  </Box>
);

const builder = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Page
                <br/>
                Builder
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="webflow" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="wordpress" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="shopify" />
    </Box>
    <Box sx={wideIconSpacing}>
      <Tool tool="wix" />
    </Box>
  </Box>
);

const graphic = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Graphic
                <br/>
                Tools
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="photoshop" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="premiere" />
    </Box>
  </Box>
);

const other = (
  <Box sx={sectionBox}>
    <Typography
                variant="body2"
                fontWeight="bold"
                textAlign="center"
                color="#202020"
                sx={iconSpacing}
              >
                Other
                <br/>
                Langs
              </Typography>
    <Box sx={iconSpacing}>
      <Tool tool="java" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="python" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="cPlusPlus" />
    </Box>
    <Box sx={iconSpacing}>
      <Tool tool="c" />
    </Box>
  </Box>
);

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

        <Section
          title="/ About Me"
          isOpened={true}
          child={
            //creative and quick?
            <Box sx={{ mx: "16px", mb: "8px" }}>
              I love to learn!
              <br />
              <br />
              That love for learning and the experience gained from the
              opportunities it's created
              <br />
              allows me to tackle challenges from many angles, gives me a better
              understanding of the concerns of each team member, and enables me
              to find solutions to even the hardest problems
            </Box>
          }
        />

        <Section
          title="/ Experience"
          isOpened={true}
          child={<Box>passed this in a box</Box>}
        />

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

        <Section
          title="/ Tools"
          isOpened={true}
          child={
            <Box sx={{ml:"16px", mr:"8px"}}>
              {mobile}
              {backend}
              {web}
              {game}
              {ide}
              {versionControl}
              {graphic}
              {builder}
              {other}
            </Box>
          }
        />

        <Section
          title="/ Cerifications"
          isOpened={false}
          child={<Box>passed this in a box</Box>}
        />
        <Section
          title="/ Other"
          isOpened={false}
          child={<Box>passed this in a box</Box>}
        />

        <Typography
          variant="body2"
          color="#202020"
          sx={{ pb: "56px", mx: "16px" }}
        >
          English & Spanish (read, write, & speak)
          <Chip label="Chip Filled" />
<Chip label="Chip Outlined" variant="outlined" />
        </Typography>
      </Menu>
    </Stack>
  );
}
