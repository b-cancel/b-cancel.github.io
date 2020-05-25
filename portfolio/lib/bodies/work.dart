import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';

class Work {
  final String title;
  final String company;
  final String location;
  final String description;
  final String startDate;
  final String endDate;
  final bool initallyOpened;

  Work(
      this.title, this.location, this.description, this.startDate, this.endDate,
      {this.company, this.initallyOpened: true});
}

//for alignment purposes
String longestMonth = "september";
List<Work> allTheWork = [
  Work(
    "Barista",
    "Pharr, TX",
    "High Speed and High Qualtiy coffee making and customer service",
    "October 2019",
    "Now",
    company: "Starbucks",
    initallyOpened: false,
  ),
  Work(
    "Disaster Releif (Volunteer)",
    "Mission, TX",
    "Drywall, Roofing, and other Miscellaneous assignments",
    "June 2019",
    "September 2019",
    initallyOpened: false,
  ),
  Work(
    "Freelance Web Developer",
    "Remote",
    "Upgraded the Job Request System." +
        " Every client now has a job request form that is specific to their needs." +
        " Both the Lebron Group and their clients receive confirmation emails when a form is filled out." +
        " Then the information from all the forms is digested and placed into a singular table," +
        " one that employees can access and update." +
        " As the employees work, clients can track the work in their own personal table.",
    "March 2020",
    "April 2020",
    company: "Lebron Group Land Surveying",
  ),
  Work(
    "App Developer (Intern)",
    "Edinburg, TX",
    "Created multiple widgets that would aid in the creation of a fitness app designed to help people" +
        " get the most of their workouts. Timer/Stopwatch | Feature Filled Text Forms | Material Sheets",
    "May 2018",
    "August 2018",
    company: "CleverSolve",
  ),
  Work(
    "Freelance Web Developer/Designer",
    "Edinburg, TX",
    "Created a basic promotional website that helped those not familiar with technology" +
        " to be able to understand the advantages of being a client of Ambit Energy and a partner of Ambit Energy.",
    "August 2017",
    "September 2017",
    company: "Ambit Energy Consultant",
  ),
  Work(
    "Freelance Web Developer/Designer",
    "Winter Park, FL",
    "Sped up Job Request Delivery Speed from ~45minutes to ~15seconds," +
        " and Re Designed and Developed their Website for mobile.",
    "July 2017",
    "October 2017",
    company: "Lebron Group Land Surveying",
  ),
  Work(
    "Graphic Designer and Marketing",
    "Edinburg, TX",
    "Created a small Educational Game to teach students (6th to 9th ) about the Railway System," +
        " along with a variety of promotional videos and posters about the program",
    "September 2014",
    "May 2015",
    company: "University Transportation Center for Railway Safety",
    initallyOpened: false,
  ),
  Work(
    "Video Editor and Graphic Designer (Intern)",
    "Edinburg, TX",
    "Created a variety of videos and posters to promote services being offered at the university",
    "September 2013",
    "May 2014",
    company: "IT Marketing Division of UTPA",
    initallyOpened: false,
  ),
  Work(
    "Robotics Coach (Volunteer)",
    "Edinburg, TX",
    "Taught 30+ highschool students how to build and program with VEX and LEGO Mindstorm Kits.",
    "May 2013",
    "May 2014",
    company: "Business Education Technology Academy",
    initallyOpened: false,
  ),
];

class WorkExperienceBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          allTheWork.length,
          (index) {
            Work thisWork = allTheWork[index];
            double width = MediaQuery.of(context).size.width;
            if (width >= 560) {
              return CollapsibleSection(
                label: thisWork.title,
                separator: "",
                labelColor: Colors.white,
                sectionType: SectionType.Parenthesis,
                initiallyOpened: thisWork.initallyOpened,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              visible: thisWork.company != null,
                              child: Wrap(
                                children: <Widget>[
                                  Text(
                                    "comp: ",
                                    style: TextStyle(
                                      color: MyApp.oldGrey,
                                    ),
                                  ),
                                  Text((thisWork.company ?? "") + ", "),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Text(thisWork.description + ", "),
                            ),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  "loc: ",
                                  style: TextStyle(
                                    color: MyApp.oldGrey,
                                  ),
                                ),
                                Text(thisWork.location + ", "),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 16,
                        ),
                        padding: EdgeInsets.only(
                          left: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: MyApp.oldGrey,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            ADate(
                              date: thisWork.endDate,
                            ),
                            ADate(
                              date: thisWork.startDate,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return CollapsibleSection(
                label: thisWork.title,
                separator: "",
                labelColor: Colors.white,
                sectionType: SectionType.Parenthesis,
                initiallyOpened: thisWork.initallyOpened,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Visibility(
                      visible: thisWork.company != null,
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            "comp: ",
                            style: TextStyle(
                              color: MyApp.oldGrey,
                            ),
                          ),
                          Text((thisWork.company ?? "") + ", "),
                        ],
                      ),
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          "start: ",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                        ),
                        Text(thisWork.startDate + ", "),
                        Text(
                          "end: ",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                        ),
                        Text(thisWork.endDate + ", "),
                      ],
                    ),
                    Text(
                      "description: ",
                      style: TextStyle(
                        color: MyApp.oldGrey,
                      ),
                    ),
                    Flexible(
                      child: Text(thisWork.description + ", "),
                    ),
                    Wrap(
                      children: <Widget>[
                        Text(
                          "loc: ",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                        ),
                        Text(thisWork.location + ", "),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ADate extends StatelessWidget {
  const ADate({
    Key key,
    @required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        opacity: 0,
        child: Text("September 2020,"),
      ),
      Positioned(
        right: 0,
        child: Text(date + ","),
      ),
    ]);
  }
}
