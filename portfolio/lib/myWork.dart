import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/contact.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/giphyImage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:universal_html/prefer_universal/html.dart' as uniHTML;
import 'package:giphy_client/giphy_client.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class MyWork extends StatefulWidget {
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
    await Future.delayed(kTabScrollDuration);
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(kTabScrollDuration);
    refreshController.loadComplete();
  }

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

  Map<String, GiphyGif> storedGifs = Map<String, GiphyGif>();

  Future<GiphyGif> getGiphy(String url) async {
    if (storedGifs.containsKey(url) == false) {
      storedGifs[url] = await client.byId(
        url,
      );
    }
    return storedGifs[url];
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

    //TODO: use better version of this
    double cardSpacing = 8;

    //grab all the needed data
    List<SomeContent> allContent = getContentFromProjectType(
      projectType: ProjectType.AppDev,
    );
    /*
    allContent.addAll(getContentFromProjectType(
      projectType: ProjectType.GameDev,
    ));
    allContent.addAll(
      getContentFromProjectType(
        projectType: ProjectType.WebDev,
      ),
    );
    allContent.addAll(
      getContentFromProjectType(
        projectType: ProjectType.Graphics,
      ),
    );
    */

    //build
    return SwipeDetector(
      onSwipeRight: () {
        if (Home.openMenu.value == false) {
          Home.openMenu.value = true;
          setMenuOpenCookie(true);
        }
      },
      child: AnimatedBuilder(
        animation: Home.openMenu,
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
                addAutomaticKeepAlives: true,
                controller: scrollController,
                //cacheExtent: 0.0,
                padding: EdgeInsets.all(5.0),
                itemCount: allContent.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index != allContent.length) {
                    return Card(
                      margin: EdgeInsets.all(cardSpacing),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: FutureBuilder(
                          future: getGiphy(
                            allContent[index].url,
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<GiphyGif> snapShot) {
                            if (snapShot.connectionState ==
                                ConnectionState.done) {
                              print(snapShot.data.images.preview.mp4);
                              return GiphyImage.downScaled(
                                gif: snapShot.data,
                                aspectRatio:
                                    allContent[index].defaultAspectRatio,
                              );
                            } else {
                              return Shimmer(
                                duration: Duration(seconds: 2), //Default value
                                color: Colors.white, //Default value
                                enabled: true, //Default value
                                direction: ShimmerDirection.fromLTRB(),
                                child: Container(
                                  height: 3,
                                  width:
                                      3 * allContent[index].defaultAspectRatio,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 48,
                      ),
                      child: Card(
                        margin: EdgeInsets.all(cardSpacing / 2),
                        color: Colors.white,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: QRWidget(
                            isDialog: false,
                          ),
                        ),
                      ),
                    );
                  }
                },
                gridDelegate:
                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      phonesThatFit.ceil(), //TODO: +1 only para feitos
                  //spacing is handled by the cards each item is in
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,

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
            duration:
                Home.startUpComplete.value ? kTabScrollDuration : Duration.zero,
            transform: Matrix4.translationValues(
              (Home.openMenu.value) ? getMenuWidth() : 0,
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
