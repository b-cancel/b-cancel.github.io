import 'package:flutter/material.dart';

//handles 99% of cases
enum StdAspectRatio { Mobile, Monitor, Square }
Map<StdAspectRatio, double> stdAspectRatioToAspectRatio = {
  StdAspectRatio.Mobile: (9 / 16),
  StdAspectRatio.Monitor: (16 / 9),
  StdAspectRatio.Square: 1,
};

//classes used below
enum ProjectStatus {
  Released,
  Prototype,
  Toolkit,
  Assignment,
  Competition,
}

class Project {
  String name; //should also be usable as ID
  ProjectStatus status;
  String description;
  bool initiallyOpened;
  String github;
  String playStore;
  String appleStore;
  String web;
  List<Content> content = new List<Content>();

  Project({
    @required this.name,
    @required this.description,
    @required this.status,
    //I assume I want employeers to see my work
    //unless I don't
    this.initiallyOpened: true,
    this.github,
    this.playStore,
    this.appleStore,
    this.web,
    this.content,
  });
}

//TODO: make, .pngs, .jpgs, and .mp4s work
class Content {
  String url; //required
  double aspectRatioOverride; //can be null
  String description; //can be null

  Content(
    String url, {
    double aspectRatioOverride,
    StdAspectRatio stdAspectRatioOverride,
    String description,
  }) {
    this.url = url;
    this.aspectRatioOverride = aspectRatioOverride ??
        stdAspectRatioToAspectRatio[stdAspectRatioOverride];
    this.description = description;
  }
}

//we keep track of type to aspect ratio seperately since all of one type of project share the same aspect ratio
enum ProjectType { Apps, Games, Websites, Graphics }

//maps for easy access
Map<ProjectType, StdAspectRatio> projectTypeToDefaultAspectRatio = {
  ProjectType.Apps: StdAspectRatio.Mobile,
  ProjectType.Games: StdAspectRatio.Monitor,
  ProjectType.Websites: StdAspectRatio.Monitor,
  ProjectType.Graphics: StdAspectRatio.Square,
};

//could use function instead
Map<ProjectType, String> projectTypeToName = {
  ProjectType.Apps: "Apps",
  ProjectType.Games: "Games",
  ProjectType.Websites: "Websites",
  ProjectType.Graphics: "Graphics"
};

//project data
Map<ProjectType, List<Project>> projectTypeToProjects = {
  ProjectType.Apps: [
    Project(
      name: "Swol",
      status: ProjectStatus.Released,
      description:
          "Swol helps you use One Rep Max Equations to reach your Weightlifting Goals Faster." +
              "Know exactly how much weight you should be lifting given your training type and your previous set," +
              "so that you are always pushing at your max but never beyond it to avoid injury and maximize results.",
      github: "swol",
      playStore: "the.swol.app",
      content: [
        //basic cycle
        Content(
          "kyoxrhAK1FqJbWe2UK",
          description:
              "1. Set Rep Goal\n2. Grab Proper Weight\n3. Record Results\n4. Take Set Break",
        ),
        //add exercise
        Content(
          "QZ7sMYoyS9dtsjaYAn",
          description: "Add An Exercise",
        ),
        //onboarding
        Content(
          "j1gKlO4uAZM10dYXya",
          description: "Onboarding",
        ),
        //search
        Content(
          "kfjRaDaE7xzVNJdGfr",
          description: "Search Exercises",
        ),

        //-----

        //calibration
        Content(
          "dC4FWH4NDOq76CUz68",
          description: "Exercise Calibration",
        ),
        //error checking
        Content(
          "YSqWsc9dSjkLTLUCWU",
          description: "Checking For Mistakes",
        ),
        //notes
        Content(
          "Rgz7qmqwOImQxM8ygX",
          description: "Add Exercise Notes",
        ),
        //learn section
        Content(
          "RLOvYGkKt6jvsIyovu",
          description: "Learn The Science",
        ),
      ],
    ),
    Project(
      name: "Half Life",
      status: ProjectStatus.Prototype,
      description: "Keep track of the active dosage of medications" +
          " (given their half life), so you can adjust your dosage" +
          " until the side effects are worth the desired effects.",
      github: "halfLife",
      content: [
        //change name scrub
        Content(
          "PiQF5YD82meF4uitmz",
          description: "Scrub Through Active Dosage Timeline",
        ),
        //add dose
        Content(
          "Rk2zzd9k9l6MBBLTBY",
          description: "Add A Dose To The Timeline",
        ),
      ],
    ),
    Project(
      name: "Job Order / Proposal UI",
      status: ProjectStatus.Prototype,
      description:
          "Allow to Lawn Care Companies to create a Job Order or Proposal to send to their client." +
              "\nClient Name is on Top and tha map lets you pick between all of their addresses.",
      github: "JobProposalPrototype",
      content: [
        //Address Picker
        Content(
          "dyvj1gBn4HYBfVDrpr",
          description: "Select An Address",
        ),
        //Due Date Picker
        Content(
          "VJYrbNGSMxUZ38RuU9",
          description: "Select A Due Date",
        ),
        //Line Item Manipulation
        Content(
          "UvK4kZ48BSmlVhiFQp",
          description: "Manipulate Line Items",
        ),
        //Image Manipulation
        Content(
          "fsaqYZsD0P0x600rE1",
          description: "Manipulate Images Within Items",
        ),
      ],
    ),
    Project(
      name: "Leashed",
      status: ProjectStatus.Prototype,
      description:
          "Create a digital Leash between your Bluetooth Devices and your phone to avoid loss. Prevention > Recovery.",
      github: "Leashed_Public",
      content: [
        //find ble
        Content("S8lbi2cusC5gVC0xOS",
            description: "Idenify Bluetooth Devices Through Signal Analysis",
            stdAspectRatioOverride: StdAspectRatio.Monitor),
        //main list
        Content(
          "RKMMj20eRHONfImd0L",
          description: "Device List",
        ),
        //---
        //sos settings
        Content(
          "S6Zdj4EiS99DlVZuDS",
          description: "SOS Settings and Test",
        ),
        //add new
        Content(
          "d5qOvltp866jRzktDZ",
          description: "Add New Device",
        ),
      ],
    ),

    //Add image descriptions to the pictures below

    Project(
      name: "Contact Picker",
      status: ProjectStatus.Toolkit,
      description: "Select, Create, and Delete Contacts." +
          " Handles permission requests for contacts, camera, and photo gallery."
              " And allows you to quickly jump to a section of contacts with an adaptive scroll bar.",
      github: "Flutter_ContactPicker",
      content: [
        //videos
        Content("Uqk7fPBnsNydSn2GZW"),
        Content("LM9EpmeAiYlIpSAcgH"),
        //-----
        Content("W0QwfdozN3AFnw1sWn"),
        Content("Xbh1CLWME0plFA8g2G"),
        Content("UT4byKMOmrYWk8dTmb"),
        //jpgs
        /*
        "https://imgur.com/YWYmyOt.jpg",
        "https://imgur.com/9XWVhy3.jpg",
        "https://imgur.com/jdxaWT0.jpg",
        "https://imgur.com/yASI0vn.jpg",
        "https://imgur.com/TDzYvgI.jpg",
        */
      ],
    ),
    Project(
      name: "Timer & Stopwatch",
      status: ProjectStatus.Toolkit,
      description:
          "A re-usable timer and stopwatch with all the functionality you would expect.",
      github: "Flutter_Timer_And_Stopwatch",
      content: [
        Content("DQdmcrEwAFqneM6tiL"),
        Content("5qFCRiENukaLzB7Yoy"),
      ],
    ),
    Project(
      name: "Material Sheets",
      status: ProjectStatus.Toolkit,
      description: "Material sheets that can come in from every direction," +
          " with the full control, gestures, handles and more.",
      github: "Flutter_MaterialSheetAndNavigationDrawer",
      content: [
        Content("35KhYdJ9CQAN6hzYbQ"),
        Content("dkXLQACALhF6puhk3I"),
        Content("dYng1K8blxvnsLhP81"),
        Content("9rsWxrJaYOhCQbRDXD"),
      ],
    ),
    Project(
      name: "Instagram Clone",
      status: ProjectStatus.Assignment,
      description: "A clone of instagram with flutter",
      github: "Flutter_Instagram",
      content: [
        Content("UsT0dPQlVrVrJ4BC1z"),
        Content("KezTdVWA3JIOS3fwX5"),
        Content("S8BPNPf8i1CCYgv3LQ"),
        Content("LSc6Y83JW98nX47nYe"),
        Content("jUKJlmNzhbLRhetFtW"),
      ],
    ),
    Project(
      name: "Tip Calculator",
      status: ProjectStatus.Assignment,
      description: "A Tip Calculator with a very detailed text input formatter",
      github: "Flutter_CurrencyTextInputFormatter",
      content: [
        Content("kBNoowA21gf9gsg69j"),
      ],
    ),
    Project(
      name: "Score Keeper",
      status: ProjectStatus.Assignment,
      description: "Keep track of the time and points during a Jiu Jitsu match",
      github: "Flutter_Cute_Score_Keeper",
      content: [
        Content("j6prIja63xwUJmMLM5"),
      ],
    ),
    Project(
      name: "Aero Press Timer Clone",
      status: ProjectStatus.Assignment,
      description: "Make the perfect coffee every time",
      github: "Flutter_AeroPress_Timer_Partial_Clone",
      content: [
        Content("H1RmERiJD4D3pL8wKG"),
      ],
    ),
  ],
  /*
  ProjectType.Games: [
    Project(
      name: "Squishables",
      status: ProjectStatus.Prototype,
      description:
          "Innovative Physics Based Cooperative 2D platformer where you control your character’s" +
              " velocity, acceleration, and impulse/jerk vector to keep you and your friends alive",
      github: "https://github.com/b-cancel/Squishables_Public",
      initiallyOpened: true,
      /*
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
                  */
      content: [
        //cover photo
        "https://i.imgur.com/xLWgktz.png",
        //gifs
      ],
    ),
    Project(
      name: "Itzo",
      status: ProjectStatus.Prototype,
      description:
          "Designed to have incredibly immersive UI using primarily sound",
      web: "https://b-cancel.github.io/Itzo_Prototype",
      github: "https://github.com/b-cancel/Itzo_Prototype",
      initiallyOpened: true,
      /*
                  videoUrls: [
                    "https://drive.google.com/open?id=1XOxjQ7VPIhJ2Ofg3Vhkz_G_MtLAhRTjv",
                  ],
                  videoLabels: [
                    "demo"
                  ],
                  */
      content: [
        "https://imgur.com/TTk5zcH.jpg",
        //"https://imgur.com/NCIp2z1.jpg",
        //"https://imgur.com/Xus8ekS.jpg",
      ],
    ),
    Project(
      name: "Super Retriever",
      status: ProjectStatus.Prototype,
      description:
          "A game designed to give a tug of war effect between both players",
      web: "https://b-cancel.github.io/Super_Retriever_Prototype/",
      github: "https://github.com/b-cancel/Super_Retriever_Prototype",
      content: [
        "https://imgur.com/LERHKNn.jpg",
        //"https://imgur.com/NJTHUYZ.jpg",
        //"https://imgur.com/VqnUNif.jpg",
        //"https://imgur.com/7lZaFI8.jpg",
      ],
    ),
    Project(
      name: "Color Mixing",
      status: ProjectStatus.Toolkit,
      description:
          "Experiment with different color mixing and color linear interpolation algorithms.\n" +
              "Created because color mixing is subjective and no tool existed that allowed you to experiment with" +
              " current open source solutions. The library also allows you to easily test out your own mixing algorithms.",
      github: "https://github.com/b-cancel/Unity3D_ColorKit_Demo",
    ),
    Project(
      name: "2D Outlines",
      status: ProjectStatus.Toolkit,
      description: "Create outlines around 2D Sprites.\n" +
          "Created because current open source solutions where to slow, looked gimmicky, and lacked features",
      github: "https://github.com/b-cancel/Unity3D_2DOutlineKit",
    ),
  ],
  ProjectType.Websites: [
    Project(
      name: "Portfolio Website",
      status: ProjectStatus.Released,
      description: "Designed as an homage to the IDEs that have kept me company for many hours." +
          " It was specifically designed to have an overview of all my work without being overwhelming." +
          " It highlights the most recent projects and hides the rest but leaves them there so whoever wants to investigate further can." +
          " It was created with Flutter Web which is currently in BETA and I was not able to make links work as expected, " +
          "but in exchange I was able to highly customize the size in a very short period of time.",
      github: "https://github.com/b-cancel/b-cancel.github.io",
      web: "https://b-cancel.github.io/",
      initiallyOpened: true,
    ),
    Project(
      name: "Attend",
      status: ProjectStatus.Released,
      description: "A simple and secure way to take attendance." +
          " It guarantees that students are present in the classroom and not logging in remotely by having a quick shuffling code" +
          ", and it guarantees that students aren't logging in for their friends by identifying each individual device.",
      github: "https://github.com/b-cancel/Attend_Public",
      initiallyOpened: true,
      content: [
        /*
                    "https://imgur.com/RC8XpUP.jpg",
                    "https://imgur.com/RYPOlzG.jpg",
                    */
        //"https://imgur.com/ptcQTII.jpg",
        /*
                    "https://imgur.com/0qlOAWd.jpg",
                    "https://imgur.com/bGpIQSd.jpg",
                    "https://imgur.com/P36SrPo.jpg",
                    */
        //"https://imgur.com/blI3yI0.jpg",
        //"https://imgur.com/eAP5w5P.jpg",
        /*
                    "https://imgur.com/vvpwpdx.jpg",
                    "https://imgur.com/3n0sXee.jpg",
                    "https://imgur.com/S05j9z2.jpg",
                    "https://imgur.com/IlBWrEr.jpg",
                    "https://imgur.com/JEHgH2R.jpg",
                    */
      ],
    ),
    Project(
      name: "Ambit Energy",
      status: ProjectStatus.Released,
      description:
          "A basic promotional website designed to help those not familiar with technology" +
              " to be able to understand the advantages of being a client of Ambit Energy and a partner of Ambit Energy",
      github: "https://github.com/b-cancel/Ambit_Energy_Consultant_Website",
      web: "https://b-cancel.github.io/Ambit_Energy_Consultant_Website",
      initiallyOpened: true,
    ),
    Project(
      name: "Shazam Clone",
      status: ProjectStatus.Assignment,
      description:
          "Visualize the music,  identify it, locate it on youtube, display the lyrics, and then download it",
      github: "https://github.com/b-cancel/Ruby_Shazam_Clone",
      initiallyOpened: true,
      content: [
        "hWGMQxaRodKOHaU5u5",
      ],
    ),
    Project(
      name: "Rental Property Searcher",
      status: ProjectStatus.Assignment,
      description:
          "Search for properties with all the filters you never knew you wanted",
      github: "https://github.com/b-cancel/Rental_Property_Searcher",
      initiallyOpened: true,
      content: [
        "https://imgur.com/s6r0lE5.jpg",
        /*
                    "https://imgur.com/lxIozzq.jpg",
                    "https://imgur.com/O3xUiho.jpg",
                    */
        "https://imgur.com/RLhARvI.jpg",
        //"https://imgur.com/mtDvR8K.jpg",
      ],
    ),
    Project(
      name: "HS Technology Student Association Website",
      status: ProjectStatus.Competition,
      description:
          "Website that placed 4th Nationally Designed to show off our highschool (BETA)" +
              ", and teach students how to write their own Vanilla HTML and CSS websites.",
      github:
          "https://github.com/b-cancel/Technology_Student_Association_Website",
      web:
          "https://b-cancel.github.io/Technology_Student_Association_Website/index.html",
      initiallyOpened: true,
    ),
    Project(
      name: "HS Web Dev Final",
      status: ProjectStatus.Competition,
      description:
          "Website Designed to show off Orlando and its Attractions as part of a Web Design Final",
      github: "https://github.com/b-cancel/Web_Development_Final",
      web: "https://b-cancel.github.io/Web_Development_Final",
      initiallyOpened: true,
    ),
  ],
  ProjectType.Graphics: [
    Project(
      name: "University Transportation Center for Railway Safety",
      status: ProjectStatus.Released,
      description: "Some of the work I designed during my time at the UTCRS." +
          "\nThe Top Link will take you to the interactive module I made for the summer camp using Articulate software.",
      web:
          "https://b-cancel.github.io/Online_Learning_Module_for_UTCRS/story_html5.html",
      initiallyOpened: true,
      content: [
        //poster
        "https://imgur.com/wsBPkTC.jpg",
        "https://imgur.com/MeUNQI0.jpg",
        //holidays
        "https://imgur.com/CPN3e7n.jpg",
        //module layouts,
        "https://imgur.com/UQ9PRdp.jpg",
        "https://imgur.com/Y6jmoM2.jpg",
        //ppt formats
        "https://imgur.com/kHoyAhQ.jpg",
        "https://imgur.com/Xe1KyU9.jpg",
      ],
    ),
    Project(
      name: "Miscellaneous Projects",
      status: ProjectStatus.Assignment,
      description: "Miscellanous work from college projects, " +
          "high school projects, " +
          "and some work I did for fun!",
      initiallyOpened: true,
      content: [
        "https://imgur.com/q8NMp8w.jpg", //tech com brochure
        "https://imgur.com/HdkrlxN.jpg", //desperate times
        "https://imgur.com/iIkfZWa.jpg", //abby
        "https://imgur.com/yWOItgG.jpg", //B
        "https://imgur.com/PstIwbm.jpg", //tech com poster
        "https://imgur.com/zyEPrxO.jpg", //business card
        "https://imgur.com/6htRkMl.jpg", //tech half day program
        "https://imgur.com/j1QR36t.jpg", //tech com logo
        "https://imgur.com/zYcdAoN.jpg", //buiness card BETA
        "https://imgur.com/rfzfxWd.jpg", //monster v aliens
        "https://imgur.com/bd46XuW.jpg", //delta pong
        "https://imgur.com/iUsVQSS.jpg", //naruto
      ],
    ),
  ],*/
};
