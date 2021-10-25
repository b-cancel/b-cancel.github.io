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
      name: "SWOL",
      description: "write a breif descriptoisn",
      github: "sdlkfjsdlkf",
      appstore: "apstoring linko",
      googleplay: "oogly play",
      gallery: [
          "https://media.giphy.com/media/VJYrbNGSMxUZ38RuU9/giphy.gif",
          "https://media.giphy.com/media/VJYrbNGSMxUZ38RuU9/giphy.gif",
      ],
    },
    {
      name: "not swol",
      description: "write a breif descriptoisn",
      github: "sdlkfjsdlkf",
      appstore: "only app store linsdfsdfsdfsdfdsfsdfdsfko",
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
