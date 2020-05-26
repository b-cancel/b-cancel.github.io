import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/prefer_universal/html.dart' as uniHTML;

class MyWork extends StatefulWidget {
  MyWork({
    @required this.openMenu,
  });

  final ValueNotifier<bool> openMenu;

  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  void _onRefresh() async {
    uniHTML.window.location.reload();
    //html.window.location.assign();
    /*
    html.window.location.replace(
      "http://b-cancel.github.io/",
    );
    */
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  //depending on isMenuOpened
  //you might need to wait for the menu's width
  bool waitForMenuWidth;
  @override
  void initState() {
    super.initState();

    //when the menu is automatically opened
    //to avoid snapping into place
    //once the menu width is read in
    //you wait until you can shift
    //and after you shift you progressively fade in
    if (widget.openMenu.value) {
      waitForMenuWidth = true;
      waitingForMenuWidth();
    } else {
      waitForMenuWidth = false;
    }
  }

  double shiftValue;
  waitingForMenuWidth() {
    shiftValue = getMenuWidth();
    if (shiftValue == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        waitingForMenuWidth();
      });
    } else {
      setState(() {
        waitForMenuWidth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      //visible if we can shift
      opacity: waitForMenuWidth ? 0 : 1,
      //TODO: edit this to feel nice
      duration: kTabScrollDuration * 9,
      //shift the main page in and out of view
      child: AnimatedBuilder(
        animation: widget.openMenu,
        //the main page doesn't need to be rebuilt to be shifted
        child: Stack(
          children: <Widget>[
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                //When this is true, the scroll view is scrollable
                //even if it does not have sufficient content to actually scroll
                //primary: true, //TODO: be enable this
                //iOS feel
                physics: BouncingScrollPhysics(),
                //so scrolling up and down with a finger keeps things in view
                //cacheExtent: MyApp.screenHeight,
                controller: scrollController,
                children: [
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          print("left");
                        },
                        child: Text("left"),
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            print("Works");
                          },
                          child: Text("Under Construction"),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          print("right");
                        },
                        child: Text("right"),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
        //only handle shifting on isMenuOpened Toggle
        builder: (BuildContext context, Widget nonChangingChild) {
          return AnimatedContainer(
            duration: kTabScrollDuration,
            transform: Matrix4.translationValues(
              (widget.openMenu.value) ? shiftValue : 0,
              0,
              0,
            ),
            child: nonChangingChild,
          );
          /*
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0, 
              sigmaY: 10.0,
            ),
            child: 
          );*/
        },
      ),
    );
  }
}
