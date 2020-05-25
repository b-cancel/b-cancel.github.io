//flutter
import 'package:flutter/material.dart';

//internal: section
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/section/section.dart';

//internal: bodies
import 'package:portfolio/bodies/projects/appDev.dart';
import 'package:portfolio/bodies/projects/gameDev.dart';
import 'package:portfolio/bodies/projects/webDev.dart';
import 'package:portfolio/bodies/projects/graphicDesign.dart';
import 'package:portfolio/bodies/projects/slideShow.dart';

//internal other
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/ui/textLink.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';

//widget
class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Text(
              "/*\n" +
                  "I'm updating this section little by little since there is alot of content to edit and display\n" +
                  "When I'm finished I'll take down this message\n" +
                  "But until then feel free to ask for more information on any individual project\n" +
                  "*/",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          */
          AppDevelopment(), 
          GameDevelopment(),
          WebDevelopment(),
          GraphicDesign(),
        ],
      ),
    );
  }
}

class DevelopmentSection extends StatelessWidget {
  DevelopmentSection({
    @required this.label,
    @required this.child,
    @required this.initiallyOpened,
  });

  final String label;
  final Widget child;
  final bool initiallyOpened;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      separator: "",
      sectionType: SectionType.Parenthesis,
      initiallyOpened: initiallyOpened,
      leftPadding: false,
      otherLeftPadding: 24,
      child: child,
    );
  }
}

class SubSection extends StatelessWidget {
  SubSection({
    @required this.label,
    @required this.child,
    @required this.initiallyOpened,
  });

  final String label;
  final Widget child;
  final bool initiallyOpened;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      sectionType: SectionType.Brackets,
      initiallyOpened: initiallyOpened,
      otherLeftPadding: 24.0 + 16,
      leftPadding: false,
      child: child,
    );
  }
}

class ProjectSection extends StatelessWidget {
  ProjectSection({
    @required this.label,
    @required this.description,
    this.github,
    this.livePage,
    this.googlePlayLink,
    this.appStoreLink,
    this.videoUrls,
    this.videoLabels,
    this.imageUrls,
    @required this.initiallyOpened,
  });

  final String label;
  final String description;
  final String github;
  final String livePage;
  final String googlePlayLink;
  final String appStoreLink;
  final List<String> videoUrls;
  final List<String> videoLabels;
  final List<String> imageUrls;
  final bool initiallyOpened;

  @override
  Widget build(BuildContext context) {
    BorderSide galleryBorder = BorderSide(
      color: MyApp.highlightGreen, //MyApp.lightBlueText, //MyApp.galleryBorder,
      width: 2,
    );

    //build
    return CollapsibleSection(
      initiallyOpened: initiallyOpened,
      label: label,
      labelColor: MyApp.highlightGreen, //MyApp.lightBlueText,
      separator: "",
      sectionType: SectionType.Parenthesis,
      leftPadding: false,
      otherLeftPadding: 24.0 + 16 + 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: imageUrls != null && imageUrls.length > 0,
            child: Slideshow(
              galleryBorder: galleryBorder,
              topLink: github ?? livePage,
              isGithub: github != null,
              imageUrls: imageUrls,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.0 + 16 + 16 + 16,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(
                      "descrip: ",
                      style: TextStyle(
                        color: MyApp.oldGrey,
                      ),
                    ),
                    Text(
                      description + ", ",
                    ),
                  ],
                ),
                Visibility(
                  visible: videoUrls != null,
                  child: Wrap(
                    children: List.generate(
                      videoUrls?.length ?? 0, 
                      (index){
                        return IconWebLink(
                          url: videoUrls[index], 
                          icon: IconLinkIcon(
                            icon: PortfolioIcons.video,
                            text: videoLabels[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    Visibility(
                      visible: livePage != null && github != null,
                      child: IconWebLink(
                        url: livePage,
                        label: "Live Page",
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.window_maximize,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: googlePlayLink != null,
                      child: IconWebLink(
                        url: googlePlayLink,
                        label: "Google Play",
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.google_play,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: appStoreLink != null,
                      child: IconWebLink(
                        url: appStoreLink,
                        label: "App Store",
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.app_store_ios,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: github != null && (imageUrls == null || imageUrls.length == 0),
                      child: IconWebLink(
                        url: github,
                        label: "Repository",
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.github,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryHeader extends StatelessWidget {
  const GalleryHeader({
    Key key,
    @required this.galleryBorder,
    @required this.isGithub,
    @required this.topLink,
    this.invisible: false,
  }) : super(key: key);

  final BorderSide galleryBorder;
  final bool isGithub;
  final String topLink;
  final bool invisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyApp.galleryTopRibbon,
        border: Border(
          bottom: galleryBorder,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: Stack(
        children: <Widget>[
          Visibility(
            visible: topLink != null,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.0 + 16 + 16 + 16,
              ),
              child: ClipRect(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconWebLink(
                      url: topLink,
                      addOvalClipper: false,
                      icon: Padding(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        child: Icon(
                          isGithub ? PortfolioIcons.github : PortfolioIcons.window_maximize,
                        ),
                      ),
                    ),
                    TextWebLink(
                      url: topLink,
                      text: Text(
                        "See More",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(" - "),
                    Flexible(
                      child: TextWebLink(
                        url: topLink,
                        text: Text(
                          topLink,
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: invisible,
              child: Container(
                color: MyApp.bodyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
