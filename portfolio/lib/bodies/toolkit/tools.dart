import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/conditional.dart';

class Tool {
  String language;
  String usedFor;
  String imageUrl;
  List<Tool> usedWith;

  Tool(
    this.language, {
    this.usedFor,
    this.imageUrl,
    this.usedWith,
  });
}

Map<String, List<Tool>> experienceToTools = {
  "a lot": [
    Tool(
      "Dart",
      usedFor: "App and Web Development/Design",
      imageUrl:
          "https://user-images.githubusercontent.com/26507463/53453892-49908900-3a04-11e9-9dce-77ed3d694326.png",
      usedWith: [
        Tool(
          "Flutter",
          imageUrl:
              "https://i1.wp.com/agostini.tech/wp-content/uploads/2019/04/flutter.png?fit=400%2C400&ssl=1",
        ),
      ],
    ),
    Tool(
      "C#",
      usedFor: "Game Development/Design",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/C_Sharp_logo.svg/150px-C_Sharp_logo.svg.png",
      usedWith: [
        Tool(
          "Unity 3D",
          imageUrl:
              "https://icons.iconarchive.com/icons/papirus-team/papirus-apps/512/unity-editor-icon-icon.png",
        )
      ],
    ),
    Tool(
      "Javascript",
      usedFor: "Web Development/Design and Google App Scripts",
      imageUrl: "assets/javascript.png",
      usedWith: [
        Tool(
          "HTML",
          imageUrl:
              "https://d2eip9sf3oo6c2.cloudfront.net/tags/images/000/000/184/full/html5.png",
        ),
        Tool(
          "CSS",
          imageUrl:
              "https://cdn1.iconfinder.com/data/icons/logotypes/32/badge-css-3-512.png",
        ),
      ],
    ),
    Tool(
      "Java",
      usedFor: "Competitive Programming and Dificult Coursework",
      imageUrl:
          "https://cdn.iconscout.com/icon/free/png-512/java-43-569305.png",
    ),
  ],
  "competent": [
    Tool(
      "Ruby",
      usedFor: "Full Stack Development",
      imageUrl:
          "https://images.vexels.com/media/users/3/166485/isolated/preview/d4061b653e6ba02ad0afdc79e0315a25-ruby-programming-language-icon-by-vexels.png",
      usedWith: [
        Tool(
          "Ruby on Rails",
          imageUrl:
              "https://cdn3.iconfinder.com/data/icons/popular-services-brands-vol-2/512/ruby-on-rails-512.png",
        ),
      ],
    ),
    Tool(
      "Github",
      imageUrl:
          "https://cdn3.iconfinder.com/data/icons/popular-services-brands/512/github-512.png",
    ),
    Tool(
      "VS Code",
      imageUrl:
          "https://chaosboltwow.co/wp-content/uploads/2019/09/1200px-Visual_Studio_Code_1.35_icon.svg_.png",
    ),
  ],
  "a little": [
    Tool(
      "Visual Studios",
      imageUrl: "https://img.icons8.com/color/480/visual-studio.png",
    ),
    Tool(
      "C++",
      imageUrl:
          "https://user-images.githubusercontent.com/42747200/46140125-da084900-c26d-11e8-8ea7-c45ae6306309.png",
    ),
    Tool(
      "Bitbucket",
      imageUrl:
          "https://cdn.iconscout.com/icon/free/png-512/bitbucket-226075.png",
    ),
    Tool(
      "Python",
      imageUrl: "https://icons.iconarchive.com/icons/cornmanthe3rd/plex/512/Other-python-icon.png",
    ),
    Tool(
      "C",
      imageUrl: "https://img.icons8.com/color/480/c-programming.png",
    ),
  ],
};

class ToolsSection extends StatelessWidget {
  toolListToWidget(List<Tool> tools) {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < tools.length; i++) {
      Tool thisTool = tools[i];
      widgets.add(
        AToolWidget(
          thisTool: thisTool, 
        ),
      );
    }

    //return within wrap
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 16,
      runSpacing: 8,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        experienceToTools.length,
        (index) {
          //get label
          String label;
          switch (index) {
            case 0:
              label = "a lot";
              break;
            case 1:
              label = "competent";
              break;
            default:
              label = "a little";
              break;
          }

          //make section
          return CollapsibleSection(
            label: "\"" + label + "\"",
            labelColor: Colors.white,
            separator: " =>",
            initiallyOpened: label != "a little",
            sectionType: SectionType.Brackets,
            child: toolListToWidget(
              experienceToTools[label],
            ),
          );
        },
      ).toList(),
    );
  }
}

class AToolWidget extends StatelessWidget {
  const AToolWidget({
    Key key,
    @required this.thisTool,
    this.items,
  }) : super(key: key);

  final Tool thisTool;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    //handle image
    Widget image;
    if (thisTool.imageUrl != null) {
      if (thisTool.imageUrl.contains("assets")) {
        image = Image.asset(
          thisTool.imageUrl,
        );
      } else {
        image = Image.network(
          thisTool.imageUrl,
        );
      }
    }

    //handle description
    //handle options items of tool
    List<Widget> items = new List<Widget>();

    //handle description (basically)
    if(thisTool.usedFor!= null){
      items.add(
        Wrap(
          children: [
            Text(
              "used For: ",
            ),
            Text(
              thisTool.usedFor,
            ),
          ],
        ),
      );
    }

    //handlee helper tools
    List<Tool> helperTools = thisTool.usedWith;
    if (helperTools != null) {
      List<Widget> helperToolWidgets = new List<Widget>();
      for(int index = 0; index < helperTools.length; index++){
        helperToolWidgets.add(
          AToolWidget(
            thisTool: helperTools[index],
          ),
        );
      }
      items.add(
        CollapsibleSection(
          allowCollapsing: false,
          label: "with", 
          separator: ":",
          sectionType: SectionType.Brackets, 
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: helperToolWidgets,
          ),
        )
      );
    }

    //return it all
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        Visibility(
          visible: thisTool.imageUrl != null,
          child: Padding(
            padding: EdgeInsets.only(
              top: 4,
              right: 4,
            ),
            child: Container(
              height: 56,
              width: 56,
              padding: EdgeInsets.all(
                8,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: image,
              ),
            ),
          ),
        ),
        Ternary(
          condition: items.length != 0,
          isTrue: CollapsibleSection(
            labelColor: Colors.white,
            label: thisTool.language,
            separator: "",
            allowCollapsing: false,
            sectionType: SectionType.Parenthesis,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items,
            ),
          ),
          isFalse: Text(
            thisTool.language,
            style: GoogleFonts.robotoMono(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
