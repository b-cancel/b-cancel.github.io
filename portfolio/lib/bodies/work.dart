import 'package:flutter/material.dart';

class Work{
  final String title;
  final String company;
  final String location;
  final String description;
  final String startDate;
  final String endDate;
  final bool initallyOpened;

  Work(
    this.title,
    this.company,
    this.location,
    this.description,
    this.startDate,
    this.endDate,
    {this.initallyOpened: true}
  );
}

List<Work> allTheWork = [
  Work(
    "Barista",
    "Starbucks",
    "Pharr, TX",
    "High Speed and High Qualtiy coffee making and customer service",
    "October 2019",
    "Now",
    initallyOpened: false,
  ),
  Work(
    "Freelance Web Developer",
    "Lebron Group Land Surveying",
    "Remote",
    "-Upgraded Job Request System"
      + "Every client now has a job request form that is specific to their needs"
      + " both the client and their clients receive confirmation emails"
      + " then the information from all the forms is digested and place into a singular table,"
      + " one that employees can access and update"
      + " and as employees complete the request the client can view the progress in their own table",
    "March 2020",
    "April 2020",
  ),
  Work(
    "App Developer (Intern)",
    "CleverSolve",
    "Edinburg, TX",
    "Created multiple widgets that would aid in the creation of a fitness app designed to help people"
    + " get the most of their workouts. Timer/Stopwatch | Feature Filled Text Forms | Material Sheets",
    "May 2018",
    "August 2018",
  ),
  Work(
    "Freelance Web Developer/Designer",
    "Ambit Energy Consultant",
    "Edinburg, TX",
    "Created Basic site",
    "August 2017",
    "September 2017",
  ),
  Work(
    "Freelance Web Developer/Designer",
    "Lebron Group Land Surveying",
    "Winter Park, FL",
    "Sped up Job Request Delivery Speed from ~45minutes to ~15seconds,"
    + " and Re Designed and Developed their Website for mobile.",
    "July 2017",
    "October 2017",
  ),
  Work(
    "Graphic Designer and Marketing",
    "University Transportation Center for Railway Safety",
    "Edinburg, TX",
    "Created a small Educational Game to teach students (6 th -9 th ) about the Railway System," 
    + " along with a variety of promotional videos and posters for the program",
    "September 2014",
    "May 2015",
    initallyOpened: false,
  ),
  Work(
    "Video Editor and Graphic Designer (Intern)",
    "IT Marketing Division of UTPA",
    "Edinburg, TX",
    "Created a variety of videos and posters to promote services being offered at the university",
    "September 2013",
    "May 2014",
    initallyOpened: false,
  ),
  Work(
    "Robotics Coach (volunteer)",
    "Business Education Technology Academy",
    "Edinburg, TX",
    "Taught 30+ highschool students how to build and program with VEX and LEGO Mindstorm Kits.",
    "May 2013",
    "May 2014",
    initallyOpened: false,
  ),
];

class WorkExperienceBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Work Experience"),
    );
  }
}