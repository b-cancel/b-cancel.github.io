//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class WebDevelopment extends StatelessWidget {
  const WebDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      initiallyOpened: true,
      label: "Web Development",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubSection(
            label: "Completed", 
            initiallyOpened: true,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Portfolio Website",
                  description: "Designed as an homage to the IDEs that have kept me company for many hours."
                  + " It was specifically designed to have an overview of all my work without being overwhelming."
                  + " It highlights the most recent projects and hides the rest but leaves them there so whoever wants to investigate further can."
                  + " It was created with Flutter Web which is currently in BETA and I was not able to make links work as expected, "
                  + "but in exchange I was able to highly customize the size in a very short period of time.",
                  github: "https://github.com/b-cancel/b-cancel.github.io",
                  livePage: "https://b-cancel.github.io/",
                  initiallyOpened: true,
                ),
                ProjectSection(
                  label: "Attend",
                  description: "A simple and secure way to take attendance."
                  + " It guarantees that students are present in the classroom and not loging in remotely by having a quick shuffling code"
                  + ", and it guarantees that students aren't logging in for their friends by identifying each individual device.",
                  github: "https://github.com/b-cancel/Attend_Public",
                  initiallyOpened: true,
                  imageUrls: [
                    "https://imgur.com/RC8XpUP.jpg",
                    "https://imgur.com/RYPOlzG.jpg",
                    "https://imgur.com/ptcQTII.jpg",
                    "https://imgur.com/0qlOAWd.jpg",
                    "https://imgur.com/bGpIQSd.jpg",
                    "https://imgur.com/P36SrPo.jpg",
                    "https://imgur.com/blI3yI0.jpg",
                    "https://imgur.com/eAP5w5P.jpg",
                    "https://imgur.com/vvpwpdx.jpg",
                    "https://imgur.com/3n0sXee.jpg",
                    "https://imgur.com/S05j9z2.jpg",
                    "https://imgur.com/IlBWrEr.jpg",
                    "https://imgur.com/JEHgH2R.jpg",
                  ],
                ),
                ProjectSection(
                  label: "Ambit Energy",
                  description: "A basic promotional website designed to help those not familiar with technology"
                  + " to be able to understand the advantages of being a client of Ambit Energy and a partner of Ambit Energy",
                  github: "https://github.com/b-cancel/Ambit_Energy_Consultant_Website",
                  livePage: "https://b-cancel.github.io/Ambit_Energy_Consultant_Website",
                  initiallyOpened: true,
                ),
              ],
            ),
          ),
          SubSection(
            label: "Assignments/Competitions",
            initiallyOpened: true,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Shazam Clone",
                  description: "Visualize the music,  identify it, locate it on youtube, display the lyrics, and then download it",
                  github: "https://github.com/b-cancel/Ruby_Shazam_Clone",
                  initiallyOpened: true,
                  imageUrls: [
                    "https://media.giphy.com/media/hWGMQxaRodKOHaU5u5/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Rental Property Searcher",
                  description: "Search for properties with all the filters you never knew you wanted",
                  github: "https://github.com/b-cancel/Rental_Property_Searcher",
                  initiallyOpened: true,
                  imageUrls: [
                    "https://imgur.com/s6r0lE5.jpg",
                    "https://imgur.com/lxIozzq.jpg",
                    "https://imgur.com/O3xUiho.jpg",
                    "https://imgur.com/RLhARvI.jpg",
                    "https://imgur.com/mtDvR8K.jpg",
                  ],
                ),
                ProjectSection(
                  label: "HS Technology Student Association Website",
                  description: "Website that placed 4th Nationally Designed to show off our highschool (BETA)"
                  + ", and teach students how to write their own Vanilla HTML and CSS websites.",
                  github: "https://github.com/b-cancel/Technology_Student_Association_Website",
                  livePage: "https://b-cancel.github.io/Technology_Student_Association_Website/index.html",
                  initiallyOpened: true,
                ),
                ProjectSection(
                  label: "HS Web Dev Final",
                  description: "Website Designed to show off Orlando and its Attractions as part of a Web Design Final",
                  github: "https://github.com/b-cancel/Web_Development_Final",
                  livePage: "https://b-cancel.github.io/Web_Development_Final",
                  initiallyOpened: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}