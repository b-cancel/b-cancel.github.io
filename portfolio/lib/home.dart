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

  //scroll to top function
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);

  //If we scroll down have the scroll up button come up
  updateOnTopValue() {
    ScrollPosition position = scrollController.position;
    //double currentOffset = scrollController.offset;

    //update overscroll to cover pill bottle if possible
    double curr = position.pixels;
    double max = position.maxScrollExtent;
    overScroll.value = (curr < max) ? 0 : curr - max;
    print("max: " + max.toString());

    //Determine whether we are on the top of the scroll area
    if (curr <= position.minScrollExtent) {
      onTop.value = true;
    } else {
      onTop.value = false;
    }

    //remove toast when pop up
    BotToast.cleanAll();
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

    //show or hide the to top button
    scrollController.addListener(updateOnTopValue);
  }

  //dipose
  @override
  void dispose() {
    //handle menu
    appOverlayEntry.remove();

    //remove listener
    scrollController.removeListener(updateOnTopValue);

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
        title: LayoutBuilder(
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
            }
            else if(constraints.maxWidth <= 320){
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
      //BottomIntro(),
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
          child: DraggableScrollbar(
            alwaysVisibleScrollThumb: true,
            backgroundColor: Colors.red,
            heightScrollThumb: 48,
            scrollThumbBuilder: (
              Color backgroundColor,
              Animation<double> thumbAnimation,
              Animation<double> labelAnimation,
              double height, {
              BoxConstraints labelConstraints,
              Text labelText,
            }) {
              return Container(
                height: height,
                width: 20.0,
                color: backgroundColor,
              );
            },
            controller: scrollController,
            child: CustomScrollView(
              controller: scrollController,
              slivers: sliverSections,
            ),
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
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.red,
                        height: 8.0 + 16,
                      ),
                    ),
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

class Joke extends StatelessWidget {
  const Joke({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: Colors.white,
        fontSize: MyApp.h5,
        height: 1,
      ),
      child: WrappedText(
        "> echo \"yes... like cancel my order of fries :P\"",
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key key,
    this.isTiny: false,
  }) : super(key: key);

  final bool isTiny;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: Colors.white,
        fontSize: isTiny ? MyApp.h3 : MyApp.h1,
      ),
      child: Transform.translate(
        offset: Offset(5, 0),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(3, 2),
              child: Text(
                "Bryan_Cancel",
                style: TextStyle(
                  color: MyApp.highlightPink,
                ),
              ),
            ),
            Text(
              "Bryan_Cancel",
              style: TextStyle(
                color: MyApp.highlightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
