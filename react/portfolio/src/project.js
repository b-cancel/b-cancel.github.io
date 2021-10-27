import React from "react";

import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import useWindowDimensions from "./window.js";
import measurementToGoldenRatio from "./golden.js";

import { useSafeAreaInsets } from "react-native-safe-area-context";

import ProgressiveImage from "react-progressive-graceful-image";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Stack from "@mui/material/Stack";

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
      github: "https://github.com/b-cancel/house_to_house",
      appstore: "https://testflight.apple.com/join/ZFowXCT4",
      gallery: [
        { src: "https://i.imgur.com/tARG4m0.jpg" },
        { src: "https://i.imgur.com/ST8VhbZ.jpg" },
        { src: "https://i.imgur.com/mqQYv0v.jpg" },
        { src: "https://i.imgur.com/oPfmGVV.jpg" },
        { src: "https://i.imgur.com/tfAz8lp.jpg" },
        { src: "https://i.imgur.com/0IHtYld.jpg" },
        { src: "https://i.imgur.com/edfqUaa.jpg" },
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
        { src: "https://i.imgur.com/SLpWBkv.jpg" },
        { src: "https://i.imgur.com/nLhuzZR.jpg" },
        { src: "https://i.imgur.com/eiERhkP.jpg" },
        { src: "https://i.imgur.com/UgtbjK8.jpg" },
        { src: "https://i.imgur.com/cqPSXbg.jpg" },
        { src: "https://i.imgur.com/yne1JDc.jpg" },
        { src: "https://i.imgur.com/gkcEJHH.jpg" },
      ],
    },
    {
      name: "Job Proposal",
      description: `Allow clients to create job proposals for their clients, 
      convert them immediately into job requests, or send them as quotes.`,
      client: "Lawn Buddy",
      clientLink: "https://www.lawnbuddy.com/",
      github: "https://github.com/b-cancel/JobProposalPrototype",
      gallery: [
        {
          src: "https://i.giphy.com/media/dyvj1gBn4HYBfVDrpr/giphy.gif",
          title: "Select from clients' addresses",
        },
        {
          src: "https://i.giphy.com/media/VJYrbNGSMxUZ38RuU9/giphy.gif",
          title: "Select a Due Date",
        },
        {
          src: "https://i.giphy.com/media/UvK4kZ48BSmlVhiFQp/giphy.gif",
          title: "Manipulate line items",
        },
        {
          src: "https://i.giphy.com/media/fsaqYZsD0P0x600rE1/giphy.gif",
          title: "Manipulate images within items",
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
        },
        {
          src: "https://i.giphy.com/media/Rk2zzd9k9l6MBBLTBY/giphy.gif",
          title: "Add a dose to the timeline",
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
          landscape: true,
          title: "Identify device throught signal analysis",
        },
        {
          src: "https://i.giphy.com/media/RKMMj20eRHONfImd0L/giphy.gif",
          title: "Device list",
        },
        {
          src: "https://i.giphy.com/media/S6Zdj4EiS99DlVZuDS/giphy.gif",
          title: "SOS mode and test",
        },
        {
          src: "https://i.giphy.com/media/d5qOvltp866jRzktDZ/giphy.gif",
          title: "Add New Device",
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
        },
        {
          src: "https://i.giphy.com/media/LM9EpmeAiYlIpSAcgH/giphy.gif",
          title: "Add a contact",
        },
        {
          src: "https://i.giphy.com/media/W0QwfdozN3AFnw1sWn/giphy.gif",
          title: "Light Mode",
        },
        {
          src: "https://i.giphy.com/media/Xbh1CLWME0plFA8g2G/giphy.gif",
          title: "Gallery or Picture",
        },
        {
          src: "https://i.giphy.com/media/UT4byKMOmrYWk8dTmb/giphy.gif",
          landscape: true,
          title: "Landscape Mode",
        },
      ],
    },
    {
      name: "Flutter Material Sheets",
      client: "Flutter Community",
      clientLink: "https://flutter.dev/",
      description: `Custom Material Shets`,
      github:
        "https://github.com/b-cancel/Flutter_MaterialSheetAndNavigationDrawer",
      gallery: [
        {
          src: "https://i.giphy.com/media/dkXLQACALhF6puhk3I/giphy.gif",
          title: "Smooth gesture controlled sheet",
        },
        {
          src: "https://i.giphy.com/media/35KhYdJ9CQAN6hzYbQ/giphy.gif",
          title: "Interactive bottom sheet",
        },
        {
          src: "https://i.giphy.com/media/dYng1K8blxvnsLhP81/giphy.gif",
          title: "Persistent bottom sheet",
        },
        {
          src: "https://i.giphy.com/media/9rsWxrJaYOhCQbRDXD/giphy.gif",
          title: "Sheets everywhere",
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
        color="white"
        tooltip={project.clientLink}
        text={clientButtonText}
        onClick={() => window.open(project.clientLink)}
      />
    ) : null;
    const appStoreButton = project.appstore ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faAppStore} color="primary" />}
        tooltip={project.appstore}
        text="iOS"
        onClick={() => window.open(project.appstore)}
      />
    ) : null;
    const googlePlayButton = project.googleplay ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faGooglePlay} color="primary" />}
        tooltip={project.googleplay}
        text="Android"
        onClick={() => window.open(project.googleplay)}
      />
    ) : null;

    const repositioryButton = project.github ? (
      <MyButton
        sx={{ mr: "12px", mt: "8px" }}
        variant="contained"
        prefixIcon={<FontAwesomeIcon icon={faGithub} color="primary" />}
        tooltip={project.github}
        color="white"
        onClick={() => window.open(project.github)}
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
    const { height, width } = useWindowDimensions();

    //remove insets
    const insets = useSafeAreaInsets();
    const actualHeight = height - insets.top - insets.bottom;
    const actualWidth = width - insets.left - insets.right;

    //do the math
    const golden = measurementToGoldenRatio({ value: actualHeight });
    const imageHeight = golden.big;
    //imageHeight/imageWidth = 16/9
    //imageHeight = (16/9) * imageWidth
    //imageHeight / (16/9) = imageWidth
    const imageWidth = imageHeight / (16 / 9);

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

    //[space + image width] * slidesPerView = full width
    const imageWidthWithHorizontalPadding = imageWidth + horizontalPadding;
    const slidesPerView = actualWidth / imageWidthWithHorizontalPadding;

    const horizontalPaddingPx = `${horizontalPadding}px`;

    const lastSrc = project.gallery[project.gallery.length - 1].src;
    console.log(lastSrc);

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
          <Typography variant="body2" color="white" sx={{ py: "16px" }}>
            {renderMarkup(project.description)}
          </Typography>
        </Stack>

        <Box>
          <style
            dangerouslySetInnerHTML={{
              __html: `
                .swiper-button-prev {
                  left: ${arrowMarginFromBorder}px;
                }

                .swiper-button-next {
                  right: ${arrowMarginFromBorder}px;
                }

                .swiper-button-prev, .swiper-button-next{
                  border: ${arrowButtonBorder}px solid black;
                  background-color: white;
                  border-radius: 8px;
                  height: ${arrowButtonInnerSize}px;
                  width: ${arrowButtonInnerSize}px;
                }
                .swiper-button-prev:after, .swiper-button-next:after{
                  color: black;
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
            slidesPerView={slidesPerView}
            centeredSlides={false}
            style={{
              "--swiper-navigation-color": "#fff",
              "--swiper-pagination-color": "#fff",
            }}
            className="mySwiper"
          >
            {project.gallery &&
              project.gallery.map((media) => (
                <SwiperSlide key={media.src}>
                  <ProgressiveImage src={media.src} placeholder="">
                    {(src, loading) => {
                      //landscape images fill the width
                      //portrait image fill the height
                      var image;
                      if (src.includes(".gif")) {
                        var identifier = media.src;
                        identifier = identifier.replace(`https://i.giphy.com/media/`, '');
                        identifier = identifier.replace(`/giphy.gif`,'');

                        //we created ID for custom GIF styling
                        image = (
                          <PlayGifWhenVisible
                            identifier={identifier}
                            src={media.src}
                            threshold={0.75}
                            landscape={media.landscape}
                          />
                        );
                      } else {
                        image = media.landscape ? (
                          <img
                            src={src}
                            alt={src}
                            width="100%"
                            object-fit="contain"
                            className="_8pxborder"
                          />
                        ) : (
                          <img
                            src={src}
                            alt={src}
                            height="100%"
                            object-fit="contain"
                            className="_8pxborder"
                          />
                        );
                      }

                      const isLastImage = lastSrc === src;
                      if (isLastImage) {
                        console.log(`${src} is last image? ${isLastImage}`);
                      }

                      return loading ? (
                        <Box
                          sx={{
                            ml: horizontalPaddingPx,
                            height: imageHeight,
                            width: imageWidth,
                            bgcolor: "#fff",
                            borderRadius: "8px",
                          }}
                        >
                          <Box
                            sx={{
                              height: 56,
                              width: 56,
                              margin: "auto",
                              pt: "50%",
                            }}
                          >
                            <img src="./miniLoaderBlack.gif" alt="loading" />
                          </Box>
                        </Box>
                      ) : (
                        <Box
                          sx={{
                            ml: horizontalPaddingPx,
                            mr: isLastImage ? horizontalPaddingPx : "0px",
                            height: imageHeight,
                            width: imageWidth,
                            display: "inline-block",
                          }}
                        >
                          {image}
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
