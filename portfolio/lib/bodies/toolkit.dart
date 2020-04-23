import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/wrappedText.dart';

class Tool{
  String language;
  String usedFor;
  String imageUrl;
  List<Tool> usedWith;

  Tool(
    this.language,
    {
      this.usedFor,
      this.imageUrl,
      this.usedWith,
    }
  );
}

/*
Awards
- Vex Robotics (1 st Regionals, 7 th State) 
- Web Design (3 rd State, 4 th Nationals) August 2013 – June 2014
● Member of the Year | Technology Problem Solving (2 nd Regionals) August 2012 – June 2013
*/

Map<String, List<Tool>> experienceToTools = {
  "a lot" : [
    Tool(
      "Dart",
      usedFor: "App and Web Development/Design",
      imageUrl: "https://avatars1.githubusercontent.com/u/1609975?s=200&v=4",
      usedWith: [
        Tool(
          "Flutter",
          imageUrl: "https://i1.wp.com/agostini.tech/wp-content/uploads/2019/04/flutter.png?fit=400%2C400&ssl=1",
        ),
      ],
    ),
    Tool(
      "C#",
      usedFor: "Game Development/Design",
      imageUrl: "https://i7.pngguru.com/preview/328/221/130/c-programming-language-logo-microsoft-visual-studio-net-framework-javascript-icon.jpg",
      usedWith: [
        Tool(
          "Unity 3D",
          imageUrl: "https://icons.iconarchive.com/icons/papirus-team/papirus-apps/512/unity-editor-icon-icon.png",
        )
      ],
    ),
    Tool(
      "Javascript",
      usedFor: "Web Development/Design and Google App Scripts",
      imageUrl: "https://f1.pngfuel.com/png/951/574/485/react-logo-javascript-redux-vuejs-angular-angularjs-expressjs-front-and-back-ends-png-clip-art-thumbnail.png",
      usedWith: [
        Tool(
          "HTML",
          imageUrl: "https://d2eip9sf3oo6c2.cloudfront.net/tags/images/000/000/184/full/html5.png",
        ),
        Tool(
          "CSS",
          imageUrl: "https://cdn1.iconfinder.com/data/icons/logotypes/32/badge-css-3-512.png",
        ),
      ],
    ),
    Tool(
      "Java",
      usedFor: "Competitive Programming and Dificult Coursework",
      imageUrl: "https://icons.iconarchive.com/icons/icons8/ios7/512/Logos-Java-Coffee-Cup-Logo-Copyrighted-icon.png"
    ),
  ],
  "competent" : [
    Tool(
      "Ruby",
      usedFor: "Full Stack Development",
      imageUrl: "https://images.vexels.com/media/users/3/166485/isolated/preview/d4061b653e6ba02ad0afdc79e0315a25-ruby-programming-language-icon-by-vexels.png",
      usedWith: [
        Tool(
          "Ruby on Rails",
          imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands-vol-2/512/ruby-on-rails-512.png",
        ),
      ]
    ),
    Tool(
      "Version Control",
      usedWith: [
        Tool(
          "Github",
          imageUrl: "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/github-512.png",
        ),
        Tool(
          "Bitbucket",
          imageUrl: "https://cdn.iconscout.com/icon/free/png-512/bitbucket-226075.png",
        ),
      ],
    ),
  ],
  "a little" : [
    Tool(
      "Python",
      imageUrl: "https://camo.githubusercontent.com/bb5d3406f92cffc8a57c363da9c13ccaae2fe854/687474703a2f2f75706c6f61642e77696b696d656469612e6f72672f77696b6970656469612f636f6d6d6f6e732f7468756d622f632f63332f507974686f6e2d6c6f676f2d6e6f746578742e7376672f3230303070782d507974686f6e2d6c6f676f2d6e6f746578742e7376672e706e67",
    ),
    Tool(
      "C++",
      imageUrl: "https://user-images.githubusercontent.com/42747200/46140125-da084900-c26d-11e8-8ea7-c45ae6306309.png",
    ),
    Tool(
      "C",
      imageUrl: "https://f0.pngfuel.com/png/465/779/blue-and-white-c-logo-png-clip-art.png",
    ),
  ],
};

class ToolKitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: MyApp.oldGrey,
        fontSize: MyApp.h4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 48.0,
            ),
            child: WrappedText(
              "last Updated: " + DateTime.now().toString() + ", ",
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "education",
            sectionType: SectionType.Brackets,
            child: EducationSection(),
          ),
          Container(height: 4),
          Padding(
            padding: EdgeInsets.only(
              right: 48,
            ),
            child: Text(
              "//experience comes from coursework, projects, and work",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "experience To Tools",
            separator: "",
            sectionType: SectionType.Parenthesis,
            child: Container(
              margin: EdgeInsets.only(
                right: 48,
              ),
              height: 100,
              color: Colors.blue,
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "suite To Certifications",
            separator: "",
            sectionType: SectionType.Parenthesis,
            child: Container(
              margin: EdgeInsets.only(
                right: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CollapsibleSection(
                    label: "\"Adobe CS6 Suite\"",
                    fontSize: MyApp.h5,
                    labelColor: Colors.white,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
                    child: Chips(
                      chips: [
                        "Photoshop",
                        "Premiere Pro",
                        "Dreamweaver",
                        "Illustrator",
                        "InDesign",
                        "Flash",
                      ],
                    ),
                  ),
                  CollapsibleSection(
                    label: "\"CIW Web Foundation Associate\"",
                    labelColor: Colors.white,
                    fontSize: MyApp.h5,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
                    child: Chips(
                      chips: [
                        "Network Technology Associate",
                        "Site Development",
                        "Internet Business",
                      ],
                    ),
                  ),
                  CollapsibleSection(
                    label: "\"IC​3​ GS4 Series\"",
                    labelColor: Colors.white,
                    fontSize: MyApp.h5,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
                    child: Chips(
                      chips: [
                        "Living Online",
                        "Key Applications",
                        "Computing Fundamentals",
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "//fluent (Speak, Read, and Write)",
            style: TextStyle(
              color: Colors.green,
              fontSize: MyApp.h4,
            ),
          ),
          CollapsibleSection(
            label: "non Programming Languages",
            sectionType: SectionType.Brackets,
            child: Padding(
              padding: EdgeInsets.only(
                right: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: MyApp.h5,
                    ),
                    child: Wrap(
                      children: <Widget>[
                        Text("English, "),
                        Text("Spanish,"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  const EducationSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget items = Wrap(
      children: <Widget>[
        University(),
        HighSchool(),
      ],
    );

    //build
    return Stack(
      children: <Widget>[
        items,
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(
              right: 24.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: MyApp.bodyColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class University extends StatelessWidget {
  const University({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24,
      ),
      margin: EdgeInsets.only(
        right: 24,
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: CollapsibleSection(
        label: "University",
        separator: "",
        sectionType: SectionType.Parenthesis,
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: MyApp.h5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: <Widget>[
                      Text(
                        "The University of Texas at Rio Grande Valley, ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Edinburg TX,"),
                    ],
                  ),
                  Text(
                    "Bachelor of Science in Computer Science,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      Text("Graduated May 2019, "),
                      Text("with a 3.6 GPA,")
                    ],
                  ),
                ],
              ),
              CoursesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class HighSchool extends StatelessWidget {
  const HighSchool({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24,
      ),
      margin: EdgeInsets.only(
        right: 24,
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: CollapsibleSection(
        label: "High School",
        separator: "",
        initiallyOpened: false,
        sectionType: SectionType.Parenthesis,
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: MyApp.h5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: <Widget>[
                  Text(
                    "Business Education Technology Academy (BETA), ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Edinburg, TX,"),
                ],
              ),
              Text(
                "High School Diploma,",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                children: <Widget>[
                  Text("Graduated May 2014, "),
                  Text("with a 3.9 GPA,")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> courseWork = [
      "Discrete Data Structures",
      "Algorithms & Data Structures",
      "Design & Analysis of Algorithms",
      "Automata, Formal Languages & Computation",
      "Software Engineering 1 & 2",
      "Internet Programming",
      "Introduction to Game Development",
      "Database Design & Implementation",
      "Systems Programming",
      "Computer Architecture",
      "Object Oriented Programing in C#",
      "Computer Organization & Assembly Languages",
    ];

    //build
    return CollapsibleSection(
      sectionType: SectionType.Brackets,
      label: "Coursework",
      labelColor: Colors.white,
      fontSize: MyApp.h5,
      separator: ":",
      initiallyOpened: false,
      child: Chips(
        chips: courseWork,
      ),
    );
  }
}

class Chips extends StatelessWidget {
  Chips({
    @required this.chips,
  });

  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        chips.length,
        (index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            child: Card(
              margin: EdgeInsets.only(
                right: 8,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Text(
                  chips[index],
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
