import * as React from 'react';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

export default function AllProjects() {
  const projects = [
    {
      name: "Get Swol App",
      description: "Swol helps you use One Rep Max Equations to reach your Weightlifting Goals Faster." +
      "Know exactly how much weight you should be lifting given your training type and your previous set," +
      "so that you are always pushing at your max but never beyond it to avoid injury and maximize results.",
      github: "https://github.com/b-cancel/swol",
      appstore: "https://apps.apple.com/us/app/get-swol-app/id1576936894",
      googleplay: "https://play.google.com/store/apps/details?id=get.swol.app",
      gallery: [
          "https://i.imgur.com/SLpWBkv",
          "https://i.imgur.com/nLhuzZR",
          "https://i.imgur.com/eiERhkP",
          "https://i.imgur.com/UgtbjK8",
          "https://i.imgur.com/cqPSXbg",
          "https://i.imgur.com/yne1JDc",
          "https://i.imgur.com/gkcEJHH",
      ],
    },
    {
      name: "Service Helper",
      description: "write a breif description of service helper",
      appstore: "https://testflight.apple.com/join/ZFowXCT4",
      gallery: [
        "https://i.imgur.com/tARG4m0",
        "https://i.imgur.com/ST8VhbZ",
        "https://i.imgur.com/mqQYv0v",
        "https://i.imgur.com/oPfmGVV",
        "https://i.imgur.com/tfAz8lp",
        "https://i.imgur.com/0IHtYld",
        "https://i.imgur.com/edfqUaa",
      ]
    },
  ];

  function ProjectCard({project}) {
    return (
      <Card sx={{ minWidth: 275 }}>
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

        

        <CardActions>
          <Button size="small">Learn More</Button>
        </CardActions>
      </Card>
    );
  }

  return (
      projects.map((project) => (
        <ProjectCard
          project={project}
        ></ProjectCard>
      ))
  );
}
