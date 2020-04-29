//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class GameDevelopment extends StatelessWidget {
  const GameDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      initiallyOpened: false,
      label: "Game Development",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubSection(
            label: "Prototypes",
            initiallyOpened: true,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Squishables",
                  description: "Innovative Physics Based Cooperative 2D platformer where you control your character’s"
                  + " velocity, acceleration, and impulse/jerk vector to keep you and your friends alive",
                  github: "https://github.com/b-cancel/Squishables_Public",
                  initiallyOpened: true,
                  videoUrls: [
                    "https://drive.google.com/open?id=14L2p0aEoZXu6D6cgJic6okR7UKYMq-GV",
                    "https://drive.google.com/open?id=1nuBLRlomhLP8-J8zDp2tBDWbLVA6XTNO",
                    //feature demonstration
                    "https://drive.google.com/open?id=122daJ87Oiq5QSQomuUQiHK27wYGqPPhb",
                    "https://drive.google.com/open?id=1Yi4nZxZyUNieWoPUwPXL6RkmWPJmOBUd",
                    "https://drive.google.com/open?id=15aA1vnc8OgIRAt_8WsQKU9clUQU2O3i3",
                    "https://drive.google.com/open?id=11a7MEm2PmURs_FFAFDyFQdkb1VH2WWDJ",
                    "https://drive.google.com/open?id=12N-icSKZJjdlLsNuFNcqQwH6KqB2Ibv6",
                  ],
                  videoLabels: [
                    "ready screen",
                    "level select",
                    //features
                    "density",
                    "surface switches",
                    "force vector",
                    "health",
                    "size switch",
                  ],
                  imageUrls: [
                    //cover photo
                    "https://i.imgur.com/xLWgktz.png",
                    //gifs
                  ],
                ),
                ProjectSection(
                  label: "Itzo",
                  description: "Designed to have incredibly immersive UI using primarily sound",
                  livePage: "https://b-cancel.github.io/Itzo_Prototype",
                  github: "https://github.com/b-cancel/Itzo_Prototype",
                  initiallyOpened: true,
                  videoUrls: [
                    "https://drive.google.com/open?id=1XOxjQ7VPIhJ2Ofg3Vhkz_G_MtLAhRTjv",
                  ],
                  videoLabels: [
                    "demo"
                  ],
                  imageUrls: [
                    "https://imgur.com/TTk5zcH.jpg",
                    //"https://imgur.com/NCIp2z1.jpg",
                    //"https://imgur.com/Xus8ekS.jpg",
                  ],
                ),
                ProjectSection(
                  label: "Super Retriever",
                  description: "A game designed to give a tug of war effect between both players",
                  livePage: "https://b-cancel.github.io/Super_Retriever_Prototype/",
                  github: "https://github.com/b-cancel/Super_Retriever_Prototype",
                  initiallyOpened: true,
                  imageUrls: [
                    "https://imgur.com/LERHKNn.jpg",
                    //"https://imgur.com/NJTHUYZ.jpg",
                    //"https://imgur.com/VqnUNif.jpg",
                    //"https://imgur.com/7lZaFI8.jpg",
                  ],
                ),
              ],
            ),
          ),
          SubSection(
            label: "Toolkits",
            initiallyOpened: false,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Color Mixing",
                  description: "Experiment with different color mixing and color linear interpolation algorithms.\n"
                  + "Created because color mixing is subjective and no tool existed that allowed you to experiment with"
                  + " current open source solutions. The library also allows you to easily test out your own mixing algorithms.",
                  github: "https://github.com/b-cancel/Unity3D_ColorKit_Demo",
                  initiallyOpened: true,
                ),
                ProjectSection(
                  label: "2D Outlines",
                  description: "Create outlines around 2D Sprites.\n"
                  + "Created because current open source solutions where to slow, looked gimmicky, and lacked features",
                  github: "https://github.com/b-cancel/Unity3D_2DOutlineKit",
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