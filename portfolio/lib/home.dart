//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

//internal: sections
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/hardSkills.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/softSkills.dart';
import 'package:portfolio/bodies/work.dart';
import 'package:portfolio/region/regions.dart';

//internal: other
import 'package:portfolio/region/sliverRegion.dart';
import 'package:portfolio/scrollBar.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/utils/scrollToTop.dart';
import 'package:portfolio/main.dart';

/*
class DrawerScaffold extends StatefulWidget{
  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> menuIsExpanded = new ValueNotifier(false);
  AnimationController buttonController;

  //init
  @override
  void initState() {
    //super init
    super.initState();
    
    //Scaffold.of(context).openDrawer();

    //animated icon
    buttonController = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
      reverseDuration: kTabScrollDuration,
    );
  }

  //dipose
  @override
  void dispose() {
    //animated icon
    buttonController.dispose();

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );

    IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: buttonController,
              semanticLabel: 'show menu',
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();

              //toggleMenu();
              setState(() {
                menuIsExpanded ? buttonController.forward() : buttonController.reverse();
                menuIsExpanded = !menuIsExpanded;
              });
            },
          ),
  }
}
*/

//widgets
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<bool> isMenuOpen = new ValueNotifier<bool>(false);
  OverlayEntry appOverlayEntry;
  GlobalKey menuKey = GlobalKey();

  //scroll to top function=
  final ScrollController scrollController = new ScrollController();
  //must be updated after the run of build
  final ValueNotifier<double> totalScrollArea = new ValueNotifier<double>(0);
  //we start off on top
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  //with no overscroll
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  //with all the extra top padding
  final ValueNotifier<double> extraTopPadding =
      new ValueNotifier<double>(topIntroHeight);
  //and without the top bit scrolled away
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  //If we scroll down have the scroll up button come up
  updateAfterScroll() {
    haveScrolled = true;
    ScrollPosition position = scrollController.position;
    //double currentOffset = scrollController.offset;

    //update overscroll to cover pill bottle if possible
    double curr = position.pixels;
    double max = position.maxScrollExtent;
    overScroll.value = (curr < max) ? 0 : curr - max;

    //Determine whether we are on the top of the scroll area
    if (curr <= position.minScrollExtent) {
      onTop.value = true;
    } else {
      onTop.value = false;
    }

    //Determine whether how much the top peice is scrolled away
    extraTopPadding.value = (topIntroHeight - curr).clamp(0, topIntroHeight);

    //ease of use variable
    topScrolledAway.value = (extraTopPadding.value.round() == 0);

    //update this (that includes overscroll to set the height scrollbar)
    totalScrollArea.value = max + overScroll.value;

    //remove toast when pop up
    BotToast.cleanAll();
  }

  updateWithoutScroll(){
    ScrollPosition position = scrollController.position;
    double max = position.maxScrollExtent;
    totalScrollArea.value = max;
  }

  //init
  @override
  void initState() {
    //super init
    super.initState();

    //handle menu
    if (appOverlayEntry != null) {
      appOverlayEntry.remove();
    }
    appOverlayEntry = OverlayEntry(
      builder: (context) {
        return appBuilder(context);
      },
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(appOverlayEntry);
    });

    //set initial size of scroll bar
    initScrollAfterAttach();

    //show or hide the to top button
    scrollController.addListener(updateAfterScroll);
  }

  //wait till the scroll controller is attached to make the first update of the scroll bar
  initScrollAfterAttach(){
    if(scrollController.hasClients){
      updateScrollUntilStablize();
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_){
        initScrollAfterAttach();
      });
    }
  }

  //set to true once the user scroll the first time
  bool haveScrolled = false;

  //because of sticky headers not everything rebuilds immediately
  //I need to continue updating the variables until the user scrolls
  updateScrollUntilStablize(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      updateWithoutScroll();
      if(haveScrolled == false){
        print("repeat");
        updateScrollUntilStablize();
      }
      else{
        print("no repeat");
      }
    });
  }

  //dipose
  @override
  void dispose() {
    //handle menu
    appOverlayEntry.remove();

    //remove listener
    scrollController.removeListener(updateAfterScroll);

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //build
    return Scaffold(
      backgroundColor: MyApp.bodyColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(),
            Container(
              key: menuKey,
              child: Column(
                children: List.generate(
                  regions.length,
                  (index) {
                    Region thisRegion = regions[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          thisRegion.title,
                        ),
                        Icon(
                          thisRegion.icon,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBuilder(BuildContext context) {
    List<Widget> sliverSections = [
      TopIntro(),
      SliverAppBar(
        pinned: true,
        backgroundColor: MyApp.inactiveTabColor,
        title: AnimatedBuilder(
          animation: topScrolledAway,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 480) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Name(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 12,
                          bottom: 6.0,
                        ),
                        child: Joke(),
                      ),
                    ),
                  ],
                );
              } else if (constraints.maxWidth <= 320) {
                return FittedBox(
                  fit: BoxFit.contain,
                  child: Name(),
                );
              } else {
                return Container(
                  height: 56,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Name(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                        ),
                        child: Joke(),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          builder: (context, child) {
            if (topScrolledAway.value) {
              return FittedBox(
                fit: BoxFit.contain,
                child: Name(),
              );
            } else {
              return child;
            }
          },
        ),
        actions: <Widget>[
          AnimatedBuilder(
            animation: isMenuOpen,
            child: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () {
                isMenuOpen.value = true;
              },
            ),
            builder: (context, child) {
              return Visibility(
                visible: isMenuOpen.value == false,
                child: child,
              );
            },
          )
        ],
      ),
    ];

    //add all the regions
    sliverSections.addAll(
      List.generate(regions.length, (index) {
        Region thisRegion = regions[index];
        return SliverRegion(
          title: thisRegion.title,
          body: thisRegion.body,
          initiallyOpened: thisRegion.initiallyOpened,
        );
      }),
    );

    //add last 2 bottom bits
    sliverSections.addAll([
      RightBottom(),
      FillRemaining(),
    ].toList());

    //create the stack
    Stack theStack = Stack(
      children: <Widget>[
        //section sliver padding
        //22 + 4 + 24
        SafeArea(
          //NOTE: Flutter has 2 options
          //1. ScrollBar (but you cant drag it)
          //2. CupertinoScrollBar (but you cant click to travel)
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                controller: scrollController,
                slivers: sliverSections,
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: ScrollBar(
                  totalScrollArea: totalScrollArea,
                  scrollController: scrollController,
                  extraTopPadding: extraTopPadding,
                ),
              ),
            ],
          ),
        ),
        ScrollToTopButton(
          onTop: onTop,
          overScroll: overScroll,
          scrollController: scrollController,
        ),
      ],
    );

    //things that change
    return AnimatedBuilder(
      animation: isMenuOpen,
      builder: (_, Widget child) {
        final keyContext = menuKey.currentContext;
        if (keyContext == null) {
          return Container();
        } else {
          // widget is visible
          final box = keyContext.findRenderObject() as RenderBox;
          return Positioned.fill(
            child: Transform.translate(
              offset: Offset(
                (isMenuOpen.value) ? -box.size.width : 0,
                0,
              ),
              child: Scaffold(
                backgroundColor: MyApp.bodyColor,
                body: Stack(
                  children: <Widget>[
                    theStack,
                    Visibility(
                      visible: isMenuOpen.value,
                      child: Positioned.fill(
                        child: Material(
                          color: Colors.black.withOpacity(.75),
                          child: InkWell(
                            onTap: () {
                              isMenuOpen.value = false;
                            },
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}