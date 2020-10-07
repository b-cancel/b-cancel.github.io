import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/contact.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/headerFooter.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/workContent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' as ui;

import 'package:universal_html/html.dart';

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

    listItems.add(
      QRWidget(
        isNormal: false,
      ),
    );

    //add the rights footer
    listItems.add(
      RightsFooter(),
    );

    //build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedBuilder(
        animation: Home.openMenu,
        //the main page doesn't need to be rebuilt to be shifted
        child: ListView(
          controller: scrollController,
          children: listItems,
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
      ),
    );
  }
}

class MyWork2 extends StatefulWidget {
  @override
  _MyWork2State createState() => _MyWork2State();
}

class _MyWork2State extends State<MyWork2> {
  final IFrameElement _iframeElement = IFrameElement();
  Widget _iframeWidget;

  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  hideToasts() {
    BotToast.cleanAll();
  }

  closeMenu() {
    print("/n/n/ntapped/n/n/n");
    Home.openMenu.value = false;
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

    //the basics
    _iframeElement.height = '9';
    _iframeElement.width = '16';
    _iframeElement.src = 'https://b-cancel.github.io/websites/';
    _iframeElement.style.border = 'none';

    //close menu [desktop]
    _iframeElement.onScroll.capture((event) {});
    _iframeElement.onMouseWheel.capture((event) {});
    _iframeElement.onWheel.capture((event) {});

    _iframeElement.onClick.capture((event) {});
    _iframeElement.onDoubleClick.capture((event) {});

    //maybes
    _iframeElement.onMouseEnter.capture((event) {});
    _iframeElement.onMouseUp.capture((event) {});
    _iframeElement.onMouseLeave.capture((event) {});
    _iframeElement.onMouseOut.capture((event) {});

    //close menu [mobile]

    //all below are maybes
    _iframeElement.onDragEnd.capture((event) {});
    _iframeElement.onDragEnter.capture((event) {});
    _iframeElement.onDragLeave.capture((event) {});
    _iframeElement.onDragOver.capture((event) {});
    _iframeElement.onDragStart.capture((event) {});

    _iframeElement.onTouchCancel.capture((event) {});
    _iframeElement.onTouchEnd.capture((event) {});
    _iframeElement.onTouchEnter.capture((event) {});
    _iframeElement.onTouchLeave.capture((event) {});
    _iframeElement.onTouchMove.capture((event) {});
    _iframeElement.onTouchStart.capture((event) {});

    // ignore: ERROR undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
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

    int columnCount = phonesThatFit.ceil();

    int colWidth = (columnCount * 250);
    int gutterWidth = ((columnCount + 1) * 16);
    int iframeWidth = colWidth + gutterWidth;

    //calcing height
    double iframeHeight = iframeWidth * ((screenHeight - 56) / screenWidth);

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: AnimatedBuilder(
        animation: Home.openMenu,
        //the main page doesn't need to be rebuilt to be shifted
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: iframeWidth.toDouble(),
            height: iframeHeight,
            child: _iframeWidget,
          ),
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
      ),
    );
  }
}
