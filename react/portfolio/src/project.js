import React from "react";

import Box from "@mui/material/Box";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Typography from "@mui/material/Typography";
import useWindowDimensions from "./window.js";
import measurementToGoldenRatio from "./golden.js";

import { useSafeAreaInsets } from "react-native-safe-area-context";

import ProgressiveImage from "react-progressive-graceful-image";

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
      name: "Get Swol App",
      description:
        "Swol helps you use One Rep Max Equations to reach your Weightlifting Goals Faster." +
        "Know exactly how much weight you should be lifting given your training type and your previous set," +
        "so that you are always pushing at your max but never beyond it to avoid injury and maximize results.",
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
    {
      name: "Service Helper",
      description: "write a breif description of service helper",
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

    return (
      <Card sx={{ margin: "16px", mb: "36px" }}>
        <CardContent>
          <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
            {project.name}
          </Typography>
          <Typography variant="h5" component="div">
            aaa
          </Typography>
          <Typography sx={{ mb: 1.5 }} color="text.secondary">
            ddd
          </Typography>
          <Typography variant="body2">
            well meaning and kindly.
            <br />
            {'"a benevolent smile"'}
          </Typography>
        </CardContent>
        <Box sx={{ backgroundColor: "#1e1e1e", pb: "24px" }}>
          <Box>
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
                  <SwiperSlide key={media} height={imageHeight}>
                    <ProgressiveImage src={media} placeholder="">
                      {(src, loading) => {
                        return loading ? (
                          <Box
                            sx={{
                              height: "100%",
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
                          <img src={src} alt={src} />
                        );
                      }}
                    </ProgressiveImage>
                  </SwiperSlide>
                ))}
            </Swiper>
          </Box>
        </Box>
      </Card>
    );
  }

  return projects.map((project) => (
    <ProjectCard key={project.name} project={project}></ProjectCard>
  ));
}
