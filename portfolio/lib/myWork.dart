import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/giphyImage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/prefer_universal/html.dart' as uniHTML;
import 'package:giphy_client/giphy_client.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:video_player_web/video_player_web.dart';

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
    //vars used to determine grid scaling
    double requiredPhonesOnScreen = 2;
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

    //build
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
              child: WaterfallFlow.builder(
                //cacheExtent: 0.0,
                padding: EdgeInsets.all(5.0),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: client.random(),
                    builder: (BuildContext context,
                        AsyncSnapshot<GiphyGif> snapShot) {
                      if (snapShot.connectionState == ConnectionState.done) {
                        print(snapShot.data.images.preview.mp4);
                        return GiphyImage.video(
                          gif: snapShot.data,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: phonesThatFit.ceil(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,

                  /// follow max child trailing layout offset and layout with full cross axis extend
                  /// last child as loadmore item/no more item in [GridView] and [WaterfallFlow]
                  /// with full cross axis extend
                  //  LastChildLayoutType.fullCrossAxisExtend,

                  /// as foot at trailing and layout with full cross axis extend
                  /// show no more item at trailing when children are not full of viewport
                  /// if children is full of viewport, it's the same as fullCrossAxisExtend
                  //  LastChildLayoutType.foot,
                  lastChildLayoutTypeBuilder: (index) => (index == 50)
                      ? LastChildLayoutType.foot
                      : LastChildLayoutType.none,
                ),
              ),

              /*
              StaggeredGridView.countBuilder(
                crossAxisCount: phonesThatFit.ceil(),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) => FutureBuilder(
                  future: client.random(),
                  builder:
                      (BuildContext context, AsyncSnapshot<GiphyGif> snapShot) {
                    if (snapShot.connectionState == ConnectionState.done) {
                      return GiphyImage.original(
                        gif: snapShot.data,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                    phonesThatFit.ceil(), index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              */

              /*ListView(
                //When this is true, the scroll view is scrollable
                //even if it does not have sufficient content to actually scroll
                //primary: true, //TODO: be enable this
                //iOS feel
                physics: BouncingScrollPhysics(),
                //so scrolling up and down with a finger keeps things in view
                //cacheExtent: MyApp.screenHeight,
                controller: scrollController,
                children: List.generate(
                  AppDev.swol.length,
                  (index) {
                    return FutureBuilder(
                      future: client.byId(
                        AppDev.swol[index],
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<GiphyGif> snapShot) {
                        if (snapShot.connectionState == ConnectionState.done) {
                          return GiphyImage.original(
                            gif: snapShot.data,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  },
                ),

                /*
                [
                  
                  
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
                  ),
                  
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 320,
                        maxHeight: 320,
                      ),
                      child: MyApp.qrCodeWhiteWillExpand,
                    ),
                  ),
                ],
                */
              ),*/
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
