import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:portfolio/contact.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/headerFooter.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/giphyImage.dart';
import 'package:portfolio/workContent.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:universal_html/prefer_universal/html.dart' as uniHTML;
import 'package:giphy_client/giphy_client.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class SomeContent {
  String url;
  double defaultAspectRatio;

  SomeContent({
    @required this.url,
    @required this.defaultAspectRatio,
  });
}

class MyWork extends StatefulWidget {
  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  hideToasts() {
    BotToast.cleanAll();
  }

  @override
  void initState() {
    super.initState();

    //dimiss attached bot toasts on scroll
    scrollController.addListener(hideToasts);

    //when the menu is automatically opened
    //to avoid snapping into place
    //once the menu width is read in
    //you wait until you can shift
    //and after you shift you progressively fade in
    waitingForMenuWidth();
  }

  @override
  void dispose() {
    scrollController.removeListener(hideToasts);
    super.dispose();
  }

  waitingForMenuWidth() {
    double shiftValue = getMenuWidth();
    if (shiftValue == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        waitingForMenuWidth();
      });
    } else {
      print("Menu size: " + shiftValue.toString());
      //the menu size has been read
      //now we can insta close the page
      Home.openMenu.value = false;

      //wait one from for that to happen before opening the page
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        //check if the reload happened from an open or closed menu
        SharedPreferences prefs = await SharedPreferences.getInstance();

        //react depending on how the menu was before reloading
        Home.openMenu.value = prefs.getBool('menuOpened') ?? true;
        Home.startUpComplete.value = true;
      });
    }
  }

  /*
  List<SomeContent> getContentFromProjectType({ProjectType projectType}) {
    //grab all data
    List<Project> projects = projectTypeToProjects[projectType];
    StdAspectRatio stdAspectRatio =
        projectTypeToDefaultAspectRatio[projectType];
    double aspectRatio = stdAspectRatioToAspectRatio[stdAspectRatio];
    print("\n\n\n\n\n" + aspectRatio.toString() + " AR");

    //fill this with project data
    List<SomeContent> content = new List<SomeContent>();

    //for each project of this type
    for (int projIndex = 0; projIndex < projects.length; projIndex++) {
      Project thisProject = projects[projIndex];
      if (thisProject.content != null) {
        List<String> projectContent = thisProject.content;
        for (int contIndex = 0;
            contIndex < projectContent.length;
            contIndex++) {
          String thisContent = projectContent[contIndex];
          if (thisContent.contains(".png") == false &&
              thisContent.contains(".jpg") == false) {
            content.add(
              SomeContent(
                url: thisContent,
                defaultAspectRatio: aspectRatio,
              ),
            );
          }
        }
      }
    }

    return content;
  }
  */

  List<Widget> getAllProjectsOfType(
    double cardSpacing,
    ProjectType projectType,
    int columnCount,
  ) {
    StdAspectRatio stdAspectRatio =
        projectTypeToDefaultAspectRatio[projectType];
    List<Widget> projectWidgets = new List<Widget>();
    List<Project> projectObjects = projectTypeToProjects[projectType];
    for (int i = 0; i < projectObjects.length; i++) {
      Project project = projectObjects[i];
      projectWidgets.add(
        WorkHeader(
          isFirst: i == 0,
          cardSpacing: cardSpacing,
          project: project,
        ),
      );
      projectWidgets.add(
        WorkBody(
          cardSpacing: cardSpacing,
          content: project.content,
          defaultAspectRatio: stdAspectRatio,
          columnCount: columnCount,
        ),
      );
    }
    return projectWidgets;
  }

  @override
  Widget build(BuildContext context) {
    //vars used to determine grid scaling
    double requiredPhonesOnScreen =
        2; //NOT 2 to avoid alot of gifs showing in phone portrait modes
    double screenHeight = MediaQuery.of(context).size.height;
    double deviceHeight = screenHeight / requiredPhonesOnScreen;

    //most everything will be phone sized gifs
    //but we don't want monitor sized gifs to look terrible either
    double phoneAspectRatio = (9 / 16);
    double monitorAspectRatio = (16 / 9);
    double squareAspectRatio = 1;
    double phonePrimary = (phoneAspectRatio + squareAspectRatio) / 2;
    double monitorPrimary = (monitorAspectRatio + squareAspectRatio) / 2;

    //grid column calcs
    double deviceWidth = deviceHeight * phonePrimary;
    double screenWidth = MediaQuery.of(context).size.width;
    double phonesThatFit = screenWidth / deviceWidth;

    //TODO: use better version of this
    double cardSpacing = 8;
    int columnCount = phonesThatFit.ceil(); //TODO: +1 only para feitos

    //prep the widget list, where each item will be wrapped in sliverToBoxAdapters
    List<Widget> listItems = new List<Widget>();

    //grab all the data
    listItems.addAll(
      getAllProjectsOfType(
        cardSpacing,
        ProjectType.Apps,
        columnCount,
      ),
    );
    //TODO: do the same thing for games, websites, and graphics

    //add the rights footer
    listItems.add(
      RightsFooter(),
    );

    //build
    return AnimatedBuilder(
      animation: Home.openMenu,
      //the main page doesn't need to be rebuilt to be shifted
      child: CustomScrollView(
        controller: scrollController,
        slivers: listItems
            .map((e) => SliverToBoxAdapter(
                  child: e,
                ))
            .toList(),
      ),
      //only handle shifting on isMenuOpened Toggle
      builder: (BuildContext context, Widget nonChangingChild) {
        return AnimatedContainer(
          duration:
              Home.startUpComplete.value ? kTabScrollDuration : Duration.zero,
          transform: Matrix4.translationValues(
            (Home.openMenu.value) ? getMenuWidth() : 0,
            0,
            0,
          ),
          child: nonChangingChild,
        );
      },
    );
  }
}
