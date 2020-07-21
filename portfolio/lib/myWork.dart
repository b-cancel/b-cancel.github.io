import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
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
    //TODO: eventually pass a parameter that has the state of the menu, open or closed
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

  hideToasts() {
    print("hiding toast");
    BotToast.cleanAll();
  }

  //depending on isMenuOpened
  //you might need to wait for the menu's width
  bool waitForMenuWidth;
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
    if (widget.openMenu.value) {
      waitForMenuWidth = true;
      waitingForMenuWidth();
    } else {
      waitForMenuWidth = false;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(hideToasts);
    super.dispose();
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

    int itemCount = 30;

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
              scrollController: scrollController,
              controller: refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: WaterfallFlow.builder(
                controller: scrollController,
                //cacheExtent: 0.0,
                padding: EdgeInsets.all(5.0),
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  if (index != (itemCount - 1)) {
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
                  } else {
                    return SizedBox(
                      width: screenWidth / phonesThatFit.ceil(),
                      height: screenWidth / phonesThatFit.ceil(),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: MyApp.qrCodeBlackWillExpand,
                          ),
                        ],
                      ),
                    );
                  }
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
