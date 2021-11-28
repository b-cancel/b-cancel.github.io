import React from "react";
import QuickLinks from "./contact.js";
import Section from "./section.js";
import ExperienceSwapItem from "./experienceSwapItem.js";
import EducationSwapItem from "./educationSwapItem.js";
import Tool from "./tools.js";

//burger menu
//push, pushRotate, elastic
import { push as Menu } from "react-burger-menu";

//material
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";
import Grid from "@mui/material/Grid";
import Box from "@mui/material/Box";

//window calculation
import useWindowDimensions from "./menuWindow.js";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import measurementToGoldenRatio from "./golden.js";

//icon
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faArrowAltCircleRight,
  /*for the menu stuff*/
  //faFileImport,
  //faFileAlt,
  //faFile,
  //faScroll,
  //faClipboardList,
  //faListAlt,
} from "@fortawesome/free-solid-svg-icons";

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
};

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
      <br />
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
      <br />
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
      <br />
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
      <br />
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
      <br />
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
      <br />
      Builders
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
      <br />
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
      <br />
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

const education = [
  {
    startOpen: false,
    title: "BS in Computer Science",
    institution: "University of Rio Grande Valley",
    graduation: "May 2019",
    gpaDetail: "Cum Laude",
    gpa: "3.6",
    coursework: [
      "Discrete Data Structures",
      "Algorithms & Data Structures",
      "Design and Analysis of Algorithms",
      "Automata, Formal Lang. & Computation",
      "Software Engineering 1 & 2",
      "Internet Programming",
      "Intro. to Game Development",
      "Database Design & Implementation",
      "Systems Programming",
      "Computer Architecture",
      "Object Oriented Prog. in C#",
      "Computer Org. and Assembly Lang.",
    ],
  },
  {
    startOpen: false,
    title: "HS Distinguished Diploma",
    institution: "Business Education Technology Academy",
    graduation: "May 2014",
    gpaDetail: "Magna Cum Laude",
    gpa: "3.9",
  },
];

const experience = [
  {
    startOpen: true,
    title: "Lead Software Engineer (Dev, UX, & UI)",
    company: "TierFour Solutions Contractor",
    companyLink: "https://www.linkedin.com/in/todd-fortier-9119b212/",
    location: "Remote",
    startMonth: 6,
    startYear: 2021,
  },
  {
    startOpen: true,
    title: "Software Support & Development Engineer",
    company: "L.O.F.T.",
    companyLink: "https://poweredbyloft.com/",
    location: "Remote",
    startMonth: 11,
    startYear: 2020,
    endMonth: 6,
    endYear: 2021,
  },
  {
    startOpen: true,
    title: "Mobile Application Developer, UX, & UI",
    company: "Lawn Buddy",
    companyLink: "https://www.lawnbuddy.com",
    location: "Remote",
    startMonth: 5,
    startYear: 2020,
    endMonth: 7,
    endYear: 2020,
  },
  {
    startOpen: true,
    title: "Internal Web Tools Developer",
    company: "Lebron Group Land Surveying",
    companyLink: "https://www.lebrongroup.com/",
    location: "Remote",
    startMonth: 3,
    startYear: 2020,
    endMonth: 6,
    endYear: 2020,
  },
  {
    startOpen: false,
    title: "Disaster Relief Volunteer / Barista",
    company: "Starbucks",
    companyLink: "https://www.starbucks.com/",
    location: "Mc-Allen, Texas",
    startMonth: 10,
    startYear: 2019,
    endMonth: 5,
    endYear: 2020,
  },
  {
    startOpen: false,
    title: "App Development Intern",
    company: "Cleversolve",
    companyLink: "https://www.linkedin.com/company/cleversolve-llc",
    location: "Edinburg, TX",
    startMonth: 5,
    startYear: 2018,
    endMonth: 8,
    endYear: 2018,
  },
  {
    startOpen: false,
    title: "Web Development and Design",
    company: "Lebron Group Land Surveying",
    companyLink: "https://www.lebrongroup.com/",
    location: "Winter Park, FL",
    startMonth: 7,
    startYear: 2017,
    endMonth: 9,
    endYear: 2017,
  },
  {
    startOpen: false,
    title: "Marketing and Graphic Design",
    company: "UT Center For Railway Safety",
    companyLink: "https://www.utrgv.edu/railwaysafety/",
    location: "Edinburg, TX",
    startMonth: 9,
    startYear: 2014,
    endMonth: 5,
    endYear: 2015,
  },
  {
    startOpen: false,
    title: "Graphic Design and Video Editing",
    company: "IT Marketing Division at UT",
    companyLink: "https://www.utrgv.edu/marketing/",
    location: "Edinburg, TX",
    startMonth: 9,
    startYear: 2013,
    endMonth: 5,
    endYear: 2014,
  },
  {
    startOpen: false,
    title: "Robotics Coach Volunteer",
    company: "Business Education Technology Academy",
    companyLink: "https://worldscholars.stisd.net/",
    location: "Edinburg, TX",
    startMonth: 5,
    startYear: 2013,
    endMonth: 5,
    endYear: 2014,
  },
];

const extras = [
  {
    title: "Leadership",
    list: [
      {
        time: "2013 > 2014",
        things: ["Treasurer for the Technology Student Association"],
      },
      {
        time: "2012 > 2014",
        things: ["Robotics Curriculum Precusor at BETA"],
      },
    ],
  },
  {
    title: "Awards",
    list: [
      {
        time: "2013 > 2014",
        things: [
          "TSA Vex Robotics @Regionals 1st @State 7th",
          "TSA Web Design @State 3rd @Nationals 4th ",
        ],
      },
      {
        time: "2012 > 2013",
        things: [
          "TSA Member Of The Year",
          "Technology Problem Solving @Regionals 2nd",
        ],
      },
    ],
  },
];

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

  //show the tools as nicely as possible
  const smallestDesiredMenuWidth = 375;
  //if our visually pleasing menu size is too small...
  //it must atleast be as large as the smallestDesiredMenuWidth
  if (largestMenuWidth < smallestDesiredMenuWidth) {
    largestMenuWidth = smallestDesiredMenuWidth;
  }

  //our smallestDesiredMenuWidth might be too large
  //to include space for the smallestDesiredTapable Area
  //which is more important because users have to be able to close the menu
  const smallestDesiredTapableWidth = 48 + (2*2) + (16*2);
  const largestPossibleMenuSize = actualWidth - smallestDesiredTapableWidth;
  if (largestMenuWidth > largestPossibleMenuSize) {
    largestMenuWidth = largestPossibleMenuSize;
  }

  //math to string for use
  const sideBarWidth = `${largestMenuWidth}px`;
  const headerHeightPx = `${headerHeight}px`;

  //decorative listing
  var xpCount = 0;
  var educationCount = 0;

  /*
      customBurgerIcon={
          <Box sx={{fontSize:"28px", textAlign:"center", mt:"8px"}}>
            <FontAwesomeIcon
              icon={faFileImport}
              color="black"
            />
          </Box>
        }
      */

  //build
  return (
    <Stack key={"the side bar"}>
      <style
        dangerouslySetInnerHTML={{
          __html: `
              .page-wrap-opened, .shiftRight {
                transform: translate3d(${sideBarWidth}, 0px, 0px) !important;
              }

              .bm-burger-button-menu-opened {
                z-index: 1111 !important;
              }
                `,
        }}
      />
      <Menu {...props} width={sideBarWidth} customBurgerIcon={
        props.customIcon
      }>
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
                height="64px"
                width="64px"
                backgroundColor="#202020"
                borderRadius="16px"
                padding="8px"
                position="relative"
                sx={{ mb: "8px" }}
              >
                <img
                  src="./graphics/profile/whiteProfile.png"
                  alt="profile"
                  heigth="64px"
                  width="64px"
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
              That love allows me to tackle challenges from many angles, gives
              me a better understanding of the concerns of each team member, and
              enables me to find solutions to even the hardest problems
            </Box>
          }
        />

        <Box
          onClick={() => {
            props.menuCloser();
          }}
          sx={{
            backgroundColor: "#101010",
            color: "#e0e0e0",
            px: "16px",
            py: "16px",
          }}
        >
          <Stack
            direction="row"
            justifyContent="flex-start"
            alignItems="center"
            spacing="12px"
            className="clickable spreadOnHover"
          >
            <Typography variant="body1">{"/ "}</Typography>
            <Typography variant="h6">My Work</Typography>
            <FontAwesomeIcon icon={faArrowAltCircleRight} />
          </Stack>
        </Box>

        <Section
          title="/ Education"
          isOpened={true}
          child={education.map((anEducation) => {
            //for key
            educationCount = educationCount + 1;
            const educationKey =
              education.length - educationCount + "education";

            //pass all params over
            return (
              <EducationSwapItem
                left={9}
                key={educationKey}
                //params
                title={anEducation.title}
                institution={anEducation.institution}
                graduation={anEducation.graduation}
                gpaDetail={anEducation.gpaDetail}
                gpa={anEducation.gpa}
                coursework={anEducation.coursework}
                //other stuff
                isOpened={anEducation.startOpen}
              />
            );
          })}
        />

        <Section
          title="/ Experience"
          isOpened={true}
          child={experience.map((anExperience) => {
            //for decoration
            xpCount = xpCount + 1;
            const theNumber = experience.length - xpCount;
            const xpKey = "xpkey" + theNumber;
            //pass all params over
            return (
              <ExperienceSwapItem
                left={9}
                key={xpKey}
                number={theNumber}
                title={anExperience.title}
                company={anExperience.company}
                companyLink={anExperience.companyLink}
                location={anExperience.location}
                startMonth={anExperience.startMonth}
                startYear={anExperience.startYear}
                endMonth={anExperience.endMonth}
                endYear={anExperience.endYear}
                //other stuff
                isOpened={anExperience.startOpen}
              />
            );
          })}
        />

        <Section
          title="/ Tools"
          isOpened={true}
          child={
            <Box sx={{ ml: "16px", mr: "8px" }}>
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
          title="/ Other"
          isOpened={false}
          child={extras.map((anOther) => {
            const title = anOther.title;
            const list = anOther.list;
            const extraKey = "extra" + title;
            return (
              <Stack sx={{ ml: "34px", mr: "16px" }} key={extraKey}>
                <Typography variant="body2" color="#202020" fontWeight="bold">
                  {title}
                </Typography>
                <Box sx={{ ml: "16px" }}>
                  {list.map((aListItem) => {
                    const time = aListItem.time;
                    const things = aListItem.things;
                    const timeKey = "time" + time;
                    return (
                      <Stack key={timeKey}>
                        <Typography
                          variant="body2"
                          color="#202020"
                          fontWeight="bold"
                        >
                          {time}
                        </Typography>
                        {things.map((thing) => {
                          return (
                            <Typography
                              key={thing}
                              variant="body2"
                              color="#202020"
                            >
                              - {thing}
                            </Typography>
                          );
                        })}
                      </Stack>
                    );
                  })}
                </Box>
              </Stack>
            );
          })}
        />

        <Typography
          variant="body2"
          color="#202020"
          fontWeight="bold"
          sx={{ pb: "56px", mx: "16px" }}
        >
          English & Spanish (read, write, & speak)
        </Typography>
      </Menu>
    </Stack>
  );
}
