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

  //scroll to top function
  final ScrollController scrollController = new ScrollController();
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
  updateOnTopValue() {
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

class ScrollBar extends StatefulWidget {
  const ScrollBar({
    Key key,
    @required this.extraTopPadding,
  }) : super(key: key);

  final ValueNotifier<double> extraTopPadding;

  @override
  _ScrollBarState createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  updateState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  void initState() {
    widget.extraTopPadding.addListener(updateState);
    super.initState();
  }

  @override
  void dispose() {
    widget.extraTopPadding.removeListener(updateState);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //orientation
    Size size = MediaQuery.of(context).size;
    bool isPortrait = size.height > size.width;
    double totalScrollBarWidth = isPortrait ? 36 : 48;

    //maths
    double totalHeight = MediaQuery.of(context).size.height;
    double topBitHeight = widget.extraTopPadding.value;
    double appBarHeight = 56;
    double usableHeight = totalHeight - topBitHeight + appBarHeight;

    //build
    return Container(
      width: totalScrollBarWidth,
      height: totalHeight,
      padding: EdgeInsets.only(
        top: topBitHeight + appBarHeight,
      ),
      child: Material(
        color: Colors.transparent,
        child: InvisibleInkWell(
          onTap: (){},
          //material is 48 by 48 atleast
          //we can fake it and make it 
          //24 and 24 of space that actually also scrolls
          //but for now
          child: Container(
            width: totalScrollBarWidth/2,
            height: usableHeight,
            margin: EdgeInsets.only(
              left: totalScrollBarWidth/2,
            ),
            decoration: BoxDecoration(
              color: MyApp.bodyColor,
              border: Border(
                left: BorderSide(
                  color: MyApp.oldGrey,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
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
