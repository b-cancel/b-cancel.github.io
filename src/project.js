import React from "react";

//material
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";

//window calculation
import measurementToGoldenRatio from "./golden.js";
import useModifiedWindowDimensions from "./window.js";
import { useSafeAreaInsets } from "react-native-safe-area-context";

//other
import ProgressiveImage from "react-progressive-graceful-image";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

import { renderMarkup } from "react-render-markup";

import PlayGifWhenVisible from "./visible.js";

import {
  faGithub,
  faAppStore,
  faGooglePlay,
} from "@fortawesome/free-brands-svg-icons";
import MyButton from "./myButton";

// Import Swiper React components
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/swiper-bundle.min.css";
import "swiper/swiper.min.css";

// Import Swiper styles
import "./styles.css";

// import Swiper core and required modules
import SwiperCore, {
  Mousewheel,
  Keyboard,
  Lazy,
  Pagination,
  Navigation,
} from "swiper";

// install Swiper modules
SwiperCore.use([Mousewheel, Keyboard, Lazy, Pagination, Navigation]);

export default function AllProjects() {
  //TODO: add gif description to show below when non full screen & above when full screen
  //TODO: add playback speed param as well
  //TODO: identify gifs when we have them and use the play back speed and appropriate gif player
  //TODO: when GIF in non full screen gallery auto play immediately at passed playback speed
  //TODO: when tapped... full screen comes up... but GIF restarts...
  //TODO: in full screen mode.... show play button... start over button if stopped and not at begining
  //TODO: if playing... tapping again will pause

  //TODO: add [*] Lawn Buddy(revamped customer details, job details, shape calcualtor)

  /*
  client: "JWs",
  clientLink: "https://jw.org",
  */
  const projects = [
    {
      name: "Service Helper",
      description: `A Digital Version of the "House To House Record" & "Follow Up" Form,
      created to solve all the problems that arise when using pen and paper`,
      repoIsPrivate: true,
      github: "https://github.com/b-cancel",
      appstore: "https://testflight.apple.com/join/ZFowXCT4",
      gallery: [
        { src: "https://i.imgur.com/tARG4m0.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/ST8VhbZ.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/mqQYv0v.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/oPfmGVV.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/tfAz8lp.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/0IHtYld.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/edfqUaa.jpg", height: 790, width: 365 },
      ],
    },
    {
      name: "Boat Management and Security App",
      description: `
      [1] boats will auto shut off if anyone falls off
      [2] control boats from your phone and watch, and let others do the same
      [3] track everyones safety metrics
      [4] make sure your boat is in good shape
      [*] and more`,
      client: "TierFour Solutions",
      clientLink: "https://www.linkedin.com/in/todd-fortier-9119b212/",
      repoIsPrivate: true,
      //https://github.com/Modern-Marine/app
      github: "https://github.com/b-cancel",
      //222 x 480
      //444 x 480
      gallery: [
        {
          src: "https://i.giphy.com/media/RmLQgWKnw5OyjeSx1l/giphy.gif",
          title: "menu and boat slider",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/WEbYyjyoaoUzalOmoj/giphy.gif",
          title: "ignition control from apple watch",
          width: 480,
          height: 444,
        },
        {
          src: "https://i.giphy.com/media/vaZJ79nsP5GtoniMPV/giphy.gif",
          title: "boat specific events, insights, and users",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/LRSLbXdXRL773wBIbT/giphy.gif",
          title: "devices connected to boat for security",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/27T2QWRW3XXczaAmXB/giphy.gif",
          title: "auto shut off triggered due to lost connection",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/PXdk48pcOyhTnRIOqr/giphy.gif",
          title: "control access for multiple boats at once",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/P8oMpUFyshskFSeUxr/giphy.gif",
          title:
            "safety insights, the events that led to them, and potential actions",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/S57CJcaW4HlUJkxrff/giphy.gif",
          title: "add, edit, and view insurance documents",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/yj5pQZiuq6wJEuDm22/giphy.gif",
          title: "fleet events and insights",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/FYklChLcuCCZ5XjkF3/giphy.gif",
          title: "user access management to specific boat",
          height: 480,
          width: 222,
        },
        {
          src: "https://i.giphy.com/media/gi52QHgXUFSvFDtfbC/giphy.gif",
          title: "Help Center Mock Up",
          height: 480,
          width: 222,
        },
      ],
    },
    {
      name: "Get Swol App",
      description: `Created to help users gain muscle faster by exploiting progressive overload;
      8 one rep max equations have been re-purposed to calculate the max ammount of weight
      that one should be able to lift given a desired rep target.`,
      github: "https://github.com/b-cancel/swol",
      appstore: "https://apps.apple.com/us/app/get-swol-app/id1576936894",
      googleplay: "https://play.google.com/store/apps/details?id=get.swol.app",
      gallery: [
        { src: "https://i.imgur.com/SLpWBkv.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/nLhuzZR.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/eiERhkP.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/UgtbjK8.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/cqPSXbg.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/yne1JDc.jpg", height: 790, width: 365 },
        { src: "https://i.imgur.com/gkcEJHH.jpg", height: 790, width: 365 },
      ],
    },
    {
      name: "Lawn Buddy Work",
      description: `Some of the work I did while at Lawn Buddy`,
      repoIsPrivate: true,
      github: "https://github.com/b-cancel",
      client: "Lawn Buddy",
      clientLink: "https://www.lawnbuddy.com/",
      gallery: [
        { title: "Jobs Map/List View", src: "https://i.imgur.com/cx7v5Dl.jpg", height: 762, width: 360 },
        { title: "Job Details Page", src: "https://i.imgur.com/uZTExkD.jpg", height: 762, width: 360 },
        { title: "Onboarding Pop Up", src: "https://i.imgur.com/8Vqvx57.jpg", height: 762, width: 360 },
        { title: "Volume/Area Calculator", src: "https://i.imgur.com/Cz4GnCn.jpg", height: 762, width: 360 },
        { title: "Customer Details V1", src: "https://i.imgur.com/XThQbFs.jpg", height: 762, width: 360 },
        { title: "Customer Details V2", src: "https://i.imgur.com/lkPRuBl.jpg", height: 762, width: 360 },
        { title: "Customer Specific Jobs", src: "https://i.imgur.com/cX1ZDFq.jpg", height: 762, width: 360 },
        { title: "Instant Pricing V1", src: "https://i.imgur.com/1vTsqt4.jpg", height: 762, width: 360 },
        { title: "Instant Pricing V2", src: "https://i.imgur.com/6UhJ8zt.jpg", height: 762, width: 360 },
      ],
    },
    {
      name: "Job Proposal (Case Study Interview)",
      description: `Allow clients to create job proposals for their clients, 
      convert them immediately into job requests, or send them as quotes.`,
      client: "Lawn Buddy",
      clientLink: "https://www.lawnbuddy.com/",
      github: "https://github.com/b-cancel/JobProposalPrototype",
      gallery: [
        {
          src: "https://i.giphy.com/media/dyvj1gBn4HYBfVDrpr/giphy.gif",
          title: "Select from clients' addresses",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/VJYrbNGSMxUZ38RuU9/giphy.gif",
          title: "Select a Due Date",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/UvK4kZ48BSmlVhiFQp/giphy.gif",
          title: "Manipulate line items",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/fsaqYZsD0P0x600rE1/giphy.gif",
          title: "Manipulate images within items",
          height: 480,
          width: 227,
        },
      ],
    },
    {
      name: "Half Life",
      description: `Avoid the negative side effects of medication by changing your dosage or frequency on the fly, 
      by taking into consideration how you feel given the ammount of active ingredient currently in your system,
      calculated with that medication's half-life.`,
      github: "https://github.com/b-cancel/halfLife",
      gallery: [
        {
          src: "https://i.giphy.com/media/PiQF5YD82meF4uitmz/giphy.gif",
          title: "Scrub through the dose timeline",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/Rk2zzd9k9l6MBBLTBY/giphy.gif",
          title: "Add a dose to the timeline",
          height: 480,
          width: 227,
        },
      ],
    },
    {
      name: "Leashed",
      description: `Senior Project: Wirelessly leash any bluetooth device to your phone to avoid losing anything ever again.
      AirTag sepration alerts before airtags existed.`,
      github: "https://github.com/b-cancel/Leashed",
      gallery: [
        {
          src: "https://i.giphy.com/media/S8lbi2cusC5gVC0xOS/giphy.gif",
          title: "Identify device through signal analysis",
          height: 264,
          width: 480,
          landscape: true,
        },
        {
          src: "https://i.giphy.com/media/RKMMj20eRHONfImd0L/giphy.gif",
          title: "Device list",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/S6Zdj4EiS99DlVZuDS/giphy.gif",
          title: "SOS mode and test",
          height: 480,
          width: 227,
        },
        {
          src: "https://i.giphy.com/media/d5qOvltp866jRzktDZ/giphy.gif",
          title: "Add New Device",
          height: 480,
          width: 227,
        },
      ],
    },
    {
      name: "Flutter Contact Picker",
      client: "Flutter Community",
      clientLink: "https://flutter.dev/",
      description: `Custom platform contact picker for flutter projects`,
      github: "https://github.com/b-cancel/Flutter_ContactPicker",
      gallery: [
        {
          src: "https://i.giphy.com/media/Uqk7fPBnsNydSn2GZW/giphy.gif",
          title: "Smooth contracting quick access slider",
          height: 480,
          width: 235,
        },
        {
          src: "https://i.giphy.com/media/LM9EpmeAiYlIpSAcgH/giphy.gif",
          title: "Add a contact",
          height: 480,
          width: 235,
        },
        {
          src: "https://i.giphy.com/media/W0QwfdozN3AFnw1sWn/giphy.gif",
          title: "Light Mode",
          height: 480,
          width: 235,
        },
        {
          src: "https://i.giphy.com/media/Xbh1CLWME0plFA8g2G/giphy.gif",
          title: "Gallery or Picture",
          height: 480,
          width: 235,
        },
        {
          src: "https://i.giphy.com/media/UT4byKMOmrYWk8dTmb/giphy.gif",
          title: "Landscape Mode",
          height: 480,
          width: 235,
          landscape: true,
        },
      ],
    },
    {
      name: "Flutter Material Sheets",
      client: "Flutter Community",
      clientLink: "https://flutter.dev/",
      description: `Custom Material Sheets`,
      github:
        "https://github.com/b-cancel/Flutter_MaterialSheetAndNavigationDrawer",
      gallery: [
        {
          src: "https://i.giphy.com/media/dkXLQACALhF6puhk3I/giphy.gif",
          title: "Smooth gesture controlled sheet",
          height: 790,
          width: 444,
        },
        {
          src: "https://i.giphy.com/media/35KhYdJ9CQAN6hzYbQ/giphy.gif",
          title: "Interactive bottom sheet",
          height: 790,
          width: 444,
        },
        {
          src: "https://i.giphy.com/media/dYng1K8blxvnsLhP81/giphy.gif",
          title: "Persistent bottom sheet",
          height: 790,
          width: 444,
        },
        {
          src: "https://i.giphy.com/media/9rsWxrJaYOhCQbRDXD/giphy.gif",
          title: "Sheets everywhere",
          height: 790,
          width: 444,
        },
      ],
    },
  ];

  function ProjectCard({ project }) {
    const clientButtonText = `Made for ${project.client}`;
    const clientButton = project.clientLink ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="outlined"
        color="#e0e0e0"
        text={clientButtonText}
        src={project.clientLink}
      />
    ) : null;
    const appStoreButton = project.appstore ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faAppStore} color="primary" />}
        text="iOS"
        src={project.appstore}
      />
    ) : null;
    const googlePlayButton = project.googleplay ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faGooglePlay} color="primary" />}
        text="Android"
        src={project.googleplay}
      />
    ) : null;

    const repositioryButton = project.github ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="contained"
        prefixIcon={<FontAwesomeIcon icon={faGithub} color="primary" />}
        color="#e0e0e0"
        src={project.github}
        repoIsPrivate={project.repoIsPrivate}
        child={
          <Typography
            style={{ textTransform: "none" }}
            variant="body1"
            sx={{ fontWeight: "bold" }}
          >
            / {project.name}
          </Typography>
        }
      />
    ) : null;

    //everything slide related below
    const { height, width } = useModifiedWindowDimensions();

    //remove insets
    const insets = useSafeAreaInsets();
    const actualHeight = height - insets.top - insets.bottom;
    const actualWidth = width - insets.left - insets.right;

    //do the math
    const golden = measurementToGoldenRatio({ value: actualHeight });
    const sharedImageHeight = golden.big;
    //calculate porportional border radius
    const sharedBorderRadius = sharedImageHeight / 24 + "px";

    //limits for portrait mode images
    const goldenWidth = measurementToGoldenRatio({ value: actualWidth });
    const largestImageWidth = goldenWidth.big;

    //NOTE: we want our images to be at most... imageWidth by imageHeight...
    //but we also want spacing betweenthose images...
    //so we can't just do the slidesPerView math with that value

    //arrow variables will impact the desired spacing
    const arrowMarginFromBorder = 16;
    const arrowButtonBorder = 2;
    const arrowButtonInnerSize = 32;
    const arrowButtonSize = arrowButtonInnerSize + arrowButtonBorder * 2;

    //enough padding so half the button is over an image on the left
    const horizontalPadding = arrowMarginFromBorder + arrowButtonSize / 2;
    const horizontalPaddingPx = `${horizontalPadding}px`;

    //identifies our swiper
    var projectID = project.name;
    projectID = projectID.replaceAll(" ", "");

    //no two swiper will have the same GIF
    const swiperName = "swiperFor" + projectID;
    const lastSrc = project.gallery[project.gallery.length - 1].src;

    //return the swiper
    return (
      <Stack sx={{ mb: "76px" }}>
        <Stack sx={{ mx: horizontalPaddingPx, my: "8px" }}>
          <Box
            sx={{
              display: "flex",
              flexDirection: "row",
              justifyContent: "flex-start",
              alignItems: "flex-start",
              flexWrap: "wrap",
            }}
          >
            {repositioryButton}
            {clientButton}
            {appStoreButton}
            {googlePlayButton}
          </Box>
          <Typography
            variant="body2"
            color="#e0e0e0"
            sx={{ py: "16px", textAlign: "left" }}
          >
            {renderMarkup(project.description)}
          </Typography>
        </Stack>

        <Box>
          <style
            dangerouslySetInnerHTML={{
              __html: `
                .swiper-slide {
                  width: auto !important;
                }

                .swiper-button-prev {
                  left: ${arrowMarginFromBorder}px;
                }

                .swiper-button-next {
                  right: ${arrowMarginFromBorder}px;
                }

                .swiper-button-prev, .swiper-button-next{
                  border: ${arrowButtonBorder}px solid #202020;
                  background-color: #e0e0e0;
                  border-radius: 8px;
                  height: ${arrowButtonInnerSize}px;
                  width: ${arrowButtonInnerSize}px;
                }
                .swiper-button-prev:after, .swiper-button-next:after{
                  color: #202020;
                  font-size: 24px;
                }
                .swiper-button-next:after {
                  margin-left: 4px;
                }
                .swiper-button-prev:after {
                  margin-right: 4px;
                }

                .swiper-button-next.swiper-button-disabled, .swiper-button-prev.swiper-button-disabled {
                  opacity: 0;
                }
                `,
            }}
          />
          <Swiper
            navigation={true}
            slidesPerView={"auto"}
            centeredSlides={false}
            style={{
              "--swiper-navigation-color": "#e0e0e0",
              "--swiper-pagination-color": "#e0e0e0",
            }}
            className={swiperName}
          >
            {project.gallery &&
              project.gallery.map((media) => (
                <SwiperSlide key={media.src}>
                  <ProgressiveImage src={media.src} placeholder="">
                    {(src, loading) => {
                      //here we calculate the width given the calculated image height
                      //HOWEVER... just like with the height...
                      //the width must at most be...
                      //the largest part of the golden ratio of the width
                      const imageWidth =
                        (media.width / media.height) * sharedImageHeight;

                      //start the value off
                      var thisImageHeight = sharedImageHeight;
                      var thisImageWidth = imageWidth;

                      //adjust if needed
                      if (thisImageWidth > largestImageWidth) {
                        //imageHeightForLargestImageWidth / largestImageWidth = thisImageHeight / thisImageWidth
                        const newImageHeight =
                          (thisImageHeight / thisImageWidth) *
                          largestImageWidth;

                        //apply new values
                        thisImageWidth = largestImageWidth;
                        thisImageHeight = newImageHeight;
                      }

                      //IF our image Width is above that then we must make the appropriate adjustments
                      //scale down the width to it's max... then change the height to match...
                      //ELSE we simply keep out values and use them

                      //all the media is given a height and width
                      //GIF ---or--- IMAGE
                      var mediaComponent;
                      if (src.includes(".gif")) {
                        var identifier = media.src;
                        identifier = identifier.replace(
                          `https://i.giphy.com/media/`,
                          ""
                        );
                        identifier = identifier.replace(`/giphy.gif`, "");

                        //after creating a identifier we move forward
                        mediaComponent = (
                            <PlayGifWhenVisible
                              identifier={identifier}
                              src={media.src}
                              threshold={0.75}
                              height={thisImageHeight}
                              width={thisImageWidth}
                            />
                        );
                      } else {
                        //TODO: change the .src to retreive the right size photo instead of the full sized photo
                        // t = Small Thumbnail (160×160)
                        // m = Medium Thumbnail (320×320)
                        // l = Large Thumbnail (640×640) as seen in the example above
                        // h = Huge Thumbnail (1024×1024)
                        var largestDimension =
                          thisImageHeight > thisImageWidth
                            ? thisImageHeight
                            : thisImageWidth;

                        //make it look a little nicer than 1 pixel per web unit
                        console.log("ratio: " + window.devicePixelRatio);
                        largestDimension =
                          largestDimension * window.devicePixelRatio;

                        var modifiedSrc = src;
                        //if it's larger then we simply show the original image
                        if (largestDimension >= 1024) {
                          //add h
                          modifiedSrc = src.replace(".jpg", "h.jpg");
                        } else {
                          if (largestDimension >= 640) {
                            //add l
                            modifiedSrc = src.replace(".jpg", "l.jpg");
                          } else {
                            if (largestDimension >= 320) {
                              //add m
                              modifiedSrc = src.replace(".jpg", "m.jpg");
                            } else {
                              //add t
                              modifiedSrc = src.replace(".jpg", "t.jpg");
                            }
                          }
                        }

                        //show the image
                        mediaComponent = (
                          <a href={media.src} target="_blank" rel="noreferrer">
                            <img
                              src={modifiedSrc}
                              alt={modifiedSrc}
                              height={thisImageHeight}
                              width={thisImageWidth}
                            />
                          </a>
                        );
                      }

                      //LOADING ---or--- MEDIA
                      const display = loading ? (
                        <Box
                          sx={{
                            textAlign: "center",
                            margin: "auto",
                            height: 56,
                            width: 56,
                            pt: "50%",
                          }}
                        >
                          <img
                            src="./graphics/loader/miniLoaderOffWhite.gif"
                            alt="load"
                            height="56px"
                            width="56px"
                          />
                        </Box>
                      ) : (
                        mediaComponent
                      );

                      //only add right padding to the last item
                      const isLastImage = media.src === lastSrc;
                      const paddingRight = isLastImage ? horizontalPadding : 0;
                      const paddingRightPx = `${paddingRight}px`;

                      //add margins as desired AND add descriptions if they exist
                      const descriptions = media.title ? (
                        <Typography
                          variant="body2"
                          style={{ color: "#e0e0e0" }}
                          sx={{ mt: "16px", textAlign: "center" }}
                        >
                          {media.title}
                        </Typography>
                      ) : (
                        <Box />
                      );

                      //put it all together
                      return (
                        <Box
                          width={thisImageWidth}
                          sx={{ pl: horizontalPaddingPx, pr: paddingRightPx }}
                        >
                          <Box
                            sx={{
                              bgcolor: "#404040",
                              height: thisImageHeight,
                              width: thisImageWidth,
                              borderRadius: sharedBorderRadius,
                              overflow: "hidden",
                            }}
                          >
                            {display}
                          </Box>
                          {descriptions}
                        </Box>
                      );
                    }}
                  </ProgressiveImage>
                </SwiperSlide>
              ))}
          </Swiper>
        </Box>
      </Stack>
    );
  }

  return projects.map((project) => (
    <ProjectCard key={project.name} project={project}></ProjectCard>
  ));
}
