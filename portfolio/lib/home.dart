//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:side_header_list_view/side_header_list_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/html.dart';

//internal: sections
import 'package:portfolio/region/sliverRegion.dart';
import 'package:portfolio/region/regions.dart';

//internal: other
import 'package:portfolio/utils/scrollToTop.dart';
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/scrollBar.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu.dart';

//widgets
class Home extends StatefulWidget {
  //handles the menu
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<bool> isMenuOpen = new ValueNotifier<bool>(false);
  final GlobalKey menuKey = GlobalKey();
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    window.location.reload();
    //html.window.location.assign();
    /*
    html.window.location.replace(
      "http://b-cancel.github.io/",
    );
    */
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sliverSections = new List<Widget>();
    /*[
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
                PortfolioIcons.menu,
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
    ];*/

    //add all the regions
    sliverSections.addAll(
      List.generate(
        regions.length,
        (index) {
          Region thisRegion = regions[index];
          return SliverRegion(
            headerKey: thisRegion.headerKey,
            bodyKey: thisRegion.bodyKey,
            title: thisRegion.title,
            leftSpacing: thisRegion.addLeftPadding,
            body: index == 0
                ? Padding(
                    padding: EdgeInsets.only(
                      right: 48,
                    ),
                    child: AboutMeBody(
                      scrollController: scrollController,
                    ),
                  )
                : thisRegion.body,
            initiallyOpened: thisRegion.initiallyOpened,
          );
        },
      ),
    );

    //add last 2 bottom bits
    /*
    sliverSections.addAll([
      RightBottom(),
      FillRemaining(),
    ].toList());
    */

    sliverSections.add(
      RightBottom(
        addSliverAdapter: false,
      ),
    );

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
              ListView(
                primary: false,
                //physics: BouncingScrollPhysics(),
                //so scrolling up and down with a finger keeps things in view
                //cacheExtent: MyApp.screenHeight,
                controller: scrollController,
                children: sliverSections,
              ),

              /*
              CustomScrollView( 
                primary: false,
                //physics: BouncingScrollPhysics(),
                //so scrolling up and down with a finger keeps things in view
                //cacheExtent: MyApp.screenHeight,
                controller: scrollController,
                slivers: sliverSections,
              ),
              */

              /*
              SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: CustomScrollView( 
                  primary: false,
                  physics: BouncingScrollPhysics(),
                  //so scrolling up and down with a finger keeps things in view
                  //cacheExtent: MyApp.screenHeight,
                  controller: scrollController,
                  slivers: sliverSections,
                ),
              ),*/
              /*CustomScrollView(
                controller: scrollController,
                slivers: sliverSections,
              ),*/
              /*
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
              */
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

    //build
    return AnimatedBuilder(
      animation: isMenuOpen,
      child: theStack,
      builder: (_, Widget reusableChild) {
        final keyContext = menuKey.currentContext;

        //grab the shift value from the menu size
        double shiftValue = 0;
        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          shiftValue = box.size.width;
        }

        //shift if needed
        return Scaffold(
          backgroundColor: MyApp.bodyColor,
          appBar: AppBar(
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
                    PortfolioIcons.menu,
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
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(
                    (isMenuOpen.value) ? -shiftValue : 0,
                    0,
                  ),
                  child: reusableChild,
                ),
              ),
              /*
              Positioned.fill(
                child: Visibility(
                  visible: isMenuOpen.value,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                  child: SideMenu(
                    scrollController: scrollController,
                    menuKey: menuKey,
                    isMenuOpen: isMenuOpen,
                  ),
                ),
              ),
              */
            ],
          ),
        );
      },
    );
  }
}
