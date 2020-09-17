import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/data/projects.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/workLinks.dart';

class WorkHeader extends StatelessWidget {
  WorkHeader({
    @required this.cardSpacing,
    @required this.project,
  });

  final double cardSpacing;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 48,
        bottom: 16,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: cardSpacing,
        ),
        child: Row(
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
      ),
    );
  }
}

/*
[
              SliverToBoxAdapter(
                child: MasonryGrid(
                  children: List.generate(
                    allContent.length + 1,
                    (index) {
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
                                  if (snapShot?.data?.images?.preview?.mp4 ==
                                      null) {
                                    print("\nurl " +
                                        allContent[index].url.toString() +
                                        " in index: " +
                                        index.toString());
                                    print("no data\n");
                                    return Container(
                                      color: Colors.red,
                                      height: 3,
                                      width: 3 *
                                          allContent[index].defaultAspectRatio,
                                    );
                                  } else {
                                    /*
                                    print("data: " +
                                        snapShot?.data?.images?.preview?.mp4
                                            .toString());
                                            */
                                    return Shimmer(
                                      duration:
                                          Duration(seconds: 2), //Default value
                                      color: Colors.white, //Default value
                                      enabled: true, //Default value
                                      direction: ShimmerDirection.fromLTRB(),
                                      child: Container(
                                        height: 3,
                                        width: 3 *
                                            allContent[index]
                                                .defaultAspectRatio,
                                      ),
                                    );
                                  }
                                } else {
                                  return GiphyImage.downScaled(
                                    gif: snapShot.data,
                                    aspectRatio:
                                        allContent[index].defaultAspectRatio,
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
                            margin: EdgeInsets.all(cardSpacing),
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
                  ),
                  column: phonesThatFit.ceil(), //TODO: +1 only para feitos
                  //spacing is handled by the cards each item is in
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
              ),
              SliverToBoxAdapter(
                child: 
              ),
            ],
*/
