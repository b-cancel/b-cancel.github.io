import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/giphyImage.dart';
import 'package:portfolio/workLinks.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WorkHeader extends StatefulWidget {
  WorkHeader({
    @required this.cardSpacing,
    @required this.project,
    @required this.isFirst,
  });

  final double cardSpacing;
  final Project project;
  final bool isFirst;

  @override
  _WorkHeaderState createState() => _WorkHeaderState();
}

class _WorkHeaderState extends State<WorkHeader> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    Home.openMenu.addListener(updateState);
    super.initState();
  }

  @override
  void dispose() {
    Home.openMenu.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Home.openMenu.value) {
      return EmptyContainer();
    } else {
      return TheTitle(
        widget: widget,
      );
    }
    /*
    return AnimatedSwitcher(
      duration: kTabScrollDuration,
      transitionBuilder: (widget, animation) {
        
        
        return SizeTransition(
          child: widget,
          sizeFactor: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
        );
      },
      child: (Home.openMenu.value)
          ? EmptyContainer()
          : TheTitle(
              widget: widget,
            ),
    );*/
  }
}

class TheTitle extends StatelessWidget {
  const TheTitle({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final WorkHeader widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.isFirst ? 16 : 36,
        bottom: 16,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.cardSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.project.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: MyApp.h2,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.project.github != null,
                          child: webLinkWidget(
                            context,
                            title: "Github Repository",
                            icon: PortfolioIcons.github,
                            generalUrl: generalGithub + myGithub + "/",
                            specificUrl: widget.project.github ?? "",
                          ),
                        ),
                        Visibility(
                          visible: widget.project?.playStore != null &&
                              widget.project.playStore.length > 1,
                          child: webLinkWidget(
                            context,
                            title: "Play Store",
                            icon: FontAwesomeIcons.googlePlay,
                            generalUrl: googlePlayPrefix,
                            specificUrl: widget.project.playStore ?? "",
                          ),
                        ),

                        /*
                  Visibility(
                    visible: project.appleStore != null,
                    child: webLinkWidget(
                      context,
                      title: "App Store",
                      icon: null,
                      generalUrl: null,
                      specificUrl: null,
                    ),
                  ),
                  */
                        Visibility(
                          visible: widget.project.web != null,
                          child: webLinkWidget(
                            context,
                            title: widget.project.web ?? "",
                            icon: Icons.web,
                            generalUrl: "",
                            specificUrl: widget.project.web ?? "",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                bottom: 4.0,
              ),
              child: Divider(
                height: 1,
                thickness: .5,
                color: Colors.white,
              ),
            ),
            Visibility(
              visible: widget.project.description != null,
              child: Text(
                widget.project.description ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      width: 0,
    );
  }
}

class WorkBody extends StatefulWidget {
  WorkBody({
    @required this.content,
    @required this.defaultAspectRatio,
    @required this.cardSpacing,
    @required this.columnCount,
  });

  final List<Content> content;
  final StdAspectRatio defaultAspectRatio;
  final double cardSpacing;
  final int columnCount;

  @override
  _WorkBodyState createState() => _WorkBodyState();
}

class _WorkBodyState extends State<WorkBody> {
  final ScrollController controller = new ScrollController();
  final ValueNotifier<bool> gifTapped = new ValueNotifier<bool>(false);
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
    bool hasScroll = ((MediaQuery.of(context).size.width / widget.columnCount) *
            widget.content.length) >
        MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.content.length,
                (index) {
                  Content content = widget.content[index];
                  return Container(
                    width:
                        MediaQuery.of(context).size.width / widget.columnCount,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContentCard(
                          isFirst: index == 0,
                          content: content,
                          playableContentTapped: gifTapped,
                          getGiphy: getGiphy,
                          cardSpacing: widget.cardSpacing,
                          aspectRatio: content.aspectRatioOverride ??
                              stdAspectRatioToAspectRatio[
                                  widget.defaultAspectRatio],
                        ),
                        AnimatedBuilder(
                          animation: Home.openMenu,
                          builder: (context, child) {
                            if (Home.openMenu.value) {
                              return EmptyContainer();
                            } else {
                              return TheDescription(
                                content: content,
                                widget: widget,
                              );
                            }
                            /*
                            return AnimatedSwitcher(
                              duration: kTabScrollDuration,
                              transitionBuilder: (widget, animation) {
                                return SizeTransition(
                                  child: widget,
                                  sizeFactor: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(animation),
                                );
                              },
                              child: (Home.openMenu.value)
                                  ? EmptyContainer()
                                  : TheDescription(
                                      content: content,
                                      widget: widget,
                                    ),
                            );
                            */
                          },
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Visibility(
            visible: hasScroll,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  controller.animateTo(
                    controller.offset + MediaQuery.of(context).size.width,
                    duration: kTabScrollDuration,
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.chevronCircleRight,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Visibility(
            visible: hasScroll,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  controller.animateTo(
                    controller.offset - MediaQuery.of(context).size.width,
                    duration: kTabScrollDuration,
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.chevronCircleLeft,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TheDescription extends StatelessWidget {
  const TheDescription({
    Key key,
    @required this.content,
    @required this.widget,
  }) : super(key: key);

  final Content content;
  final WorkBody widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content.description != null,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 16,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.cardSpacing,
          ),
          child: Text(content.description ?? ""),
        ),
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  ContentCard({
    @required this.content,
    //only for gifs and videos
    @required this.playableContentTapped,
    @required this.getGiphy,
    //don't change
    @required this.cardSpacing,
    @required this.aspectRatio,
    @required this.isFirst,
  });

  final Content content;
  //only for gifs and videos
  final ValueNotifier<bool> playableContentTapped;
  final Function getGiphy;
  //don't change
  final double cardSpacing;
  final double aspectRatio;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    //TODO: handle .png, .jpg, and .mp4 content as well
    return Card(
      margin: EdgeInsets.all(cardSpacing),
      child: FutureBuilder(
        future: getGiphy(
          content.url,
        ),
        builder: (BuildContext context, AsyncSnapshot<GiphyGif> snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData == false) {
              print("no gify");
              return ShimmeringContent(
                aspectRatio: aspectRatio,
                isLoading: false,
              );
            } else {
              return GiphyController(
                gif: snapShot.data,
                aspectRatio: aspectRatio,
                playableContentTapped: playableContentTapped,
                isFirst: isFirst,
              );
            }
          } else {
            return ShimmeringContent(
              aspectRatio: aspectRatio,
            );
          }
        },
      ),
    );
  }
}

class ShimmeringContent extends StatelessWidget {
  const ShimmeringContent({
    Key key,
    @required this.aspectRatio,
    this.isLoading: true,
  }) : super(key: key);

  final double aspectRatio;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Shimmer(
        duration: Duration(seconds: 2), //Default value
        color: Colors.white, //Default value
        enabled: true, //Default value
        direction: ShimmerDirection.fromLTRB(),
        child: Container(
          height: 3,
          width: 3 * aspectRatio,
          color: isLoading ? Colors.transparent : Colors.red,
        ),
      ),
    );
  }
}
