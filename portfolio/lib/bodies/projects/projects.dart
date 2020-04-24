//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/section/section.dart';

//internal: subsection
import 'package:portfolio/bodies/projects/appDev.dart';
import 'package:portfolio/bodies/projects/gameDev.dart';
import 'package:portfolio/bodies/projects/webDev.dart';

//Image.network("https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
//https://source.unsplash.com/random/NUMBER
/*
class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Center(
        child: SizedBox(
          height: 500,
          width: 250,
          child: Container(
            color: Colors.red,
            height: 500,
            width: 250,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        right: 24,
      ),
      height: 320,
      color: Colors.yellow,
      child: Column(
        children: <Widget>[
          /*
          ListView.separated(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: false,
            padding: EdgeInsets.all(0),
            itemCount: items.length,
            itemBuilder: (context, index){
              return items[index];
            },
            separatorBuilder: (context, int){
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                height: 320,
                width: 2,
                color: MyApp.oldGrey,
              );
            }
          ),
          */
          //buttons that let you pick the picture directly
          /*
          Container(
            height: 48,
            child: Row(
              children: <Widget>[

              ],
            ),
          ),
          */
        ],
      ),
    );
  }
}
*/

class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDevelopment(),
        GameDevelopment(),
        WebDevelopment(),
      ],
    );
  }
}

class DevelopmentSection extends StatelessWidget {
  DevelopmentSection({
    @required this.label,
    @required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      separator: "",
      sectionType: SectionType.Parenthesis,
      child: child,
    );
  }
}

class SubSection extends StatelessWidget {
  SubSection({
    @required this.label,
    @required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      sectionType: SectionType.Brackets,
      child: child,
    );
  }
}

class ProjectSection extends StatelessWidget {
  ProjectSection({
    @required this.label,
    @required this.description,
    @required this.github,
    this.livePage,
    this.googlePlayLink,
    this.appStoreLink,
    this.imageUrls,
  });

  final String label;
  final String description;
  final String github;
  final String livePage;
  final String googlePlayLink;
  final String appStoreLink;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      sectionType: SectionType.Parenthesis,
      child: Text("Fill Me"),
    );
  }
}
