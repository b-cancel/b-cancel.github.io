import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/giphyImage.dart';
import 'package:portfolio/workLinks.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WorkHeader extends StatelessWidget {
  WorkHeader({
    @required this.cardSpacing,
    @required this.project,
    @required this.isFirst,
  });

  final double cardSpacing;
  final Project project;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: isFirst ? 16 : 36,
        bottom: 16,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: cardSpacing,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  project.name,
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
                          visible: project.github != null,
                          child: webLinkWidget(
                            context,
                            title: "Github Repository",
                            icon: PortfolioIcons.github,
                            generalUrl: generalGithub + myGithub + "/",
                            specificUrl: project.github ?? "",
                          ),
                        ),
                        Visibility(
                          visible: project?.playStore != null &&
                              project.playStore.length > 1,
                          child: webLinkWidget(
                            context,
                            title: "Play Store",
                            icon: FontAwesomeIcons.googlePlay,
                            generalUrl: googlePlayPrefix,
                            specificUrl: project.playStore ?? "",
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
                          visible: project.web != null,
                          child: webLinkWidget(
                            context,
                            title: project.web ?? "",
                            icon: Icons.web,
                            generalUrl: "",
                            specificUrl: project.web ?? "",
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
              ),
              child: Divider(
                height: 1,
                thickness: .5,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
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
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      /*
      column: widget.columnCount,
      //spacing is handled by the cards each item is in
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      */
      children: List.generate(
        widget.content.length,
        (index) {
          Content content = widget.content[index];
          return Container(
            width: MediaQuery.of(context).size.width / widget.columnCount,
            height: 250,
            /*
            child: Column(
              children: [
                ContentCard(
                  content: content,
                  playableContentTapped: gifTapped,
                  getGiphy: getGiphy,
                  cardSpacing: widget.cardSpacing,
                  aspectRatio: content.aspectRatioOverride ??
                      stdAspectRatioToAspectRatio[widget.defaultAspectRatio],
                ),
                Visibility(
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
                ),
              ],
            ),*/
          );
        },
      ).toList(),
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
  });

  final Content content;
  //only for gifs and videos
  final ValueNotifier<bool> playableContentTapped;
  final Function getGiphy;
  //don't change
  final double cardSpacing;
  final double aspectRatio;

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
