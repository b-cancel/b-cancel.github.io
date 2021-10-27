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
  const projects = [
    {
      name: "Service Helper",
      description: 
      `A Digital Version of the "House To House Record" & "Follow Up" Form,
      created to solve all the problems that arise when using pen and paper`,
      repoIsPrivate: true,
      github: "https://github.com/b-cancel/house_to_house",
      appstore: "https://testflight.apple.com/join/ZFowXCT4",
      gallery: [
        "https://i.imgur.com/tARG4m0.jpg",
        "https://i.imgur.com/ST8VhbZ.jpg",
        "https://i.imgur.com/mqQYv0v.jpg",
        "https://i.imgur.com/oPfmGVV.jpg",
        "https://i.imgur.com/tfAz8lp.jpg",
        "https://i.imgur.com/0IHtYld.jpg",
        "https://i.imgur.com/edfqUaa.jpg",
      ],
    },
    {
      name: "Get Swol App",
      description: 
      `Created to help users gain muscle faster by exploiting progressive overload;
      8 one rep max equations have been re-purposed to calculate the max ammount of weight
      that one should be able to lift given a desired rep target.`,
      github: "https://github.com/b-cancel/swol",
      appstore: "https://apps.apple.com/us/app/get-swol-app/id1576936894",
      googleplay: "https://play.google.com/store/apps/details?id=get.swol.app",
      gallery: [
        "https://i.imgur.com/SLpWBkv.jpg",
        "https://i.imgur.com/nLhuzZR.jpg",
        "https://i.imgur.com/eiERhkP.jpg",
        "https://i.imgur.com/UgtbjK8.jpg",
        "https://i.imgur.com/cqPSXbg.jpg",
        "https://i.imgur.com/yne1JDc.jpg",
        "https://i.imgur.com/gkcEJHH.jpg",
      ],
    },
  ];

  function ProjectCard({ project }) {
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
    const horizontalPadding = 16 + (36/2);
    const imageWidthWithHorizontalPadding = imageWidth + horizontalPadding;

    //width = ()
    const slidesPerView = actualWidth / imageWidthWithHorizontalPadding;
    console.log(slidesPerView);


    const appStoreButton = project.appstore ? (
      <MyButton
      sx={{mr:"12px", mt:"8px"}}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faAppStore} color="primary" />}
        tooltip={project.appstore}
        text="iOS"
        onClick={() => window.open(project.appstore)}
      />
    ) : null;
    const googlePlayButton = project.googleplay ? (
      <MyButton
      sx={{mr:"12px", mt:"8px"}}
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faGooglePlay} color="primary" />}
        tooltip={project.googleplay}
        text="Android"
        onClick={() => window.open(project.googleplay)}
      />
    ) : null;

    const repositioryButton = project.github ? (
      <MyButton
      sx={{mr:"12px", mt:"8px"}}
        variant="contained"
        prefixIcon={<FontAwesomeIcon icon={faGithub} color="primary" />}
        tooltip={project.github}
        color="white"
        onClick={() => window.open(project.github)}
        repoIsPrivate={project.repoIsPrivate}
        child={<Typography
          style={{ textTransform: "none" }}
          variant="body1"
          sx={{ fontWeight: 'bold'}}
        >
          / {project.name}
        </Typography>}
      />
    ) : null;

    const horizontalPaddingPx = `${horizontalPadding}px`

    return (
      <Stack sx={{mb:"76px"}}>
        <Stack sx={{mx:horizontalPaddingPx, my:"8px",}}>
        <Box
        sx={{
          display: 'flex',
          flexDirection: 'row',
          justifyContent: 'flex-start',
          alignItems: 'flex-start',
          flexWrap: 'wrap',
        }}
          >
          {repositioryButton}
          {appStoreButton}
          {googlePlayButton}
          </Box>
          <Typography variant="body2" color="white" sx={{py:"16px"}}>
            {renderMarkup(project.description)}
          </Typography>
        </Stack>
          
          <Box>
          <style
              dangerouslySetInnerHTML={{
                __html: `
                .swiper-button-prev {
                  left: 16px;
                }

                .swiper-button-next {
                  right: 16px;
                }

                .swiper-button-prev, .swiper-button-next{
                  border: 2px solid black;
                  background-color: white;
                  border-radius: 8px;
                  height: 32px;
                  width: 32px;
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
              grabCursor={true}
              centeredSlides={false}
              style={{
                "--swiper-navigation-color": "#fff",
                "--swiper-pagination-color": "#fff",
              }}
              className="mySwiper"
            >
              {project.gallery &&
                project.gallery.map((media) => (
                  <SwiperSlide key={media}>
                    <ProgressiveImage src={media} placeholder="">
                      {(src, loading) => {
                        return loading ? (
                          <Box
                            sx={{
                              ml:horizontalPaddingPx,
                              height: imageHeight,
                              width: "90%",
                              bgcolor: "#000",
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
                              <img src="./miniLoader.gif" alt="loading" />
                            </Box>
                          </Box>
                        ) : (
                          <Box sx={{ml:horizontalPaddingPx, display:"inline-block", height:imageHeight, borderRadius:"8px", overflow:"hidden"}}>
                          <img src={src} alt={src} height="100%"/>
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
