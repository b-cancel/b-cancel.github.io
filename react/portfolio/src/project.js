import React from "react";
import { Text } from "react-native";

import Box from "@mui/material/Box";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Typography from "@mui/material/Typography";
import useWindowDimensions from "./window.js";
import measurementToGoldenRatio from "./golden.js";

import { useSafeAreaInsets } from "react-native-safe-area-context";

import ProgressiveImage from "react-progressive-graceful-image";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Stack from "@mui/material/Stack";

import { Markup } from 'react-render-markup';
import { renderMarkup } from 'react-render-markup';


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
  const projects = [
    {
      name: "Service Helper",
      description: 
      `A Digital Version of the "House To House Record" created to solve all the problems that arise when using pen and paper like<br>
      [1] Forgetting a pen and/or paper<br>
      [2] Forgetting "Who's In Charge" of the territory and not knowing who to send the record to<br>
      [3] Forgetting to write down the "Territory Number" and not knowing what territory the records belong to<br>
      [4] Not being able to locate the address of a revisit because your wrote "St" instead of "Ct"<br>
      [5] Finding someone that is interested but speaks another language but not having a "Follow Up" Form<br>
      [7] Forgetting to write down the address of the previous house and having to walk back to get it
      [6] and more!<br>
      `,
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
      `One Rep Max equations can estimate your one rep max given any other set.<br>
      The "Get Swol App" re-purposes these equations, and uses an average of the 7 equations out there to<br>
      "calculate the max ammount of weight you sould be able to lift given your desired rep target"<br>
      <br>
      By knowing your upper limit you will be able to<br>
      [a] plan your workout even better [b] reach your weight lifting goals faster [c] and avoid injury<br>
      <br>
      Additionally, it will help you<br>
      [1] do the right amount of reps [2] take appropriate break between your sets [3] and do the right amount of sets<br>
      for your selected training style<br>
      `,
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
    const horizontalPadding = 0;
    const imageWidthWithHorizontalPadding = imageWidth + horizontalPadding * 2;

    //width = ()
    const slidesPerView = actualWidth / imageWidthWithHorizontalPadding;
    const appStoreButton = project.appstore ? (
      <MyButton
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faAppStore} color="primary" />}
        tooltip={project.appstore}
        text="App Store"
        sx={{ mr: "8px", my: "4px" }}
        onClick={() => window.open(project.appstore)}
      />
    ) : null;
    const googlePlayButton = project.googleplay ? (
      <MyButton
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faGooglePlay} color="primary" />}
        tooltip={project.googleplay}
        text="Google Play"
        sx={{ mr: "8px", my: "4px" }}
        onClick={() => window.open(project.googleplay)}
      />
    ) : null;

    const repositioryButton = project.github ? (
      <MyButton
        variant="outlined"
        prefixIcon={<FontAwesomeIcon icon={faGithub} color="primary" />}
        tooltip={project.github}
        text="Repository"
        color="primary"
        sx={{ my: "4px" }}
        onClick={() => window.open(project.github)}
      />
    ) : null;

    function NewlineText(props) {
      const text = props.text;
      const newText = text.split('\n').map(str => {return (<span>{str}</span>)});
      return (<Stack>{newText}</Stack>);
    }
    /*
    <style
              dangerouslySetInnerHTML={{
                __html: `
                .swiper {
                  height: ${imageHeight}px;
                }
                
                .swiper-slide {
                  height: ${imageHeight}px;
                }
              `,
              }}
            />
    */
    
    return (
      <Card sx={{ margin: "16px", mb: "36px" }}>
        <CardContent>
          <Typography
            variant="h5"
            component="span"
            sx={{
              verticalAlign: "middle",
              pr: "8px",
            }}
          >
            / {project.name}
          </Typography>

          {appStoreButton}
          {googlePlayButton}
          {repositioryButton}
        </CardContent>
        <Box sx={{ backgroundColor: "#1e1e1e" }}>
          <Box>
            
            <Swiper
              navigation={true}
              slidesPerView={slidesPerView}
              grabCursor={true}
              loop={true}
              centeredSlides={false}
              keyboard={{
                enabled: true,
              }}
              pagination={{
                type: "progressbar",
              }}
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
                              height:imageHeight,
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
                          <img src={src} alt={src} height={imageHeight}/>
                        );
                      }}
                    </ProgressiveImage>
                  </SwiperSlide>
                ))}
            </Swiper>
          </Box>
        </Box>
        <CardContent>
          
          <Typography variant="body2">
          {renderMarkup(project.description)}
          </Typography>
        </CardContent>
      </Card>
    );
  }

  return projects.map((project) => (
    <ProjectCard key={project.name} project={project}></ProjectCard>
  ));
}
