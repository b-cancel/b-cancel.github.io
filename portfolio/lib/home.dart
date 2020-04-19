//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter/scheduler.dart';
import 'package:portfolio/menu.dart';

//internal: sections
import 'package:portfolio/region/sliverRegion.dart';
import 'package:portfolio/region/regions.dart';

//internal: other
import 'package:portfolio/utils/scrollToTop.dart';
import 'package:portfolio/scrollBar.dart';
import 'package:portfolio/main.dart';

//widgets
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //handles the menu
  final ValueNotifier<bool> isMenuOpen = new ValueNotifier<bool>(false);
  OverlayEntry appOverlayEntry;
  GlobalKey menuKey = GlobalKey();

  //handle the scrolling
  final ScrollController scrollController = new ScrollController();
  //we start off on top
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  //with no overscroll
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  //and without the top bit scrolled away
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

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
  }

  //dipose
  @override
  void dispose() {
    //handle menu
    appOverlayEntry.remove();

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //build
    return Scaffold(
      backgroundColor: MyApp.bodyColor,
      body: SideMenu(
        scrollController: scrollController,
        menuKey: menuKey,
        isMenuOpen: isMenuOpen,
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
          headerKey: thisRegion.headerKey,
          bodyKey: thisRegion.bodyKey,
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
                  scrollController: scrollController,
                  //here they are updated
                  topScrolledAway: topScrolledAway,
                  overScroll: overScroll,
                  onTop: onTop,
                  
                ),
              ),
            ],
          ),
        ),
        ScrollToTopButton(
          scrollController: scrollController,
          //here they are used
          overScroll: overScroll,
          onTop: onTop,
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