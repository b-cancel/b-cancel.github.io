//flutter
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/bodies/projects/slideShow.dart';
import 'package:portfolio/main.dart';

//internal
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/section/section.dart';

//internal: subsection
import 'package:portfolio/bodies/projects/appDev.dart';
import 'package:portfolio/bodies/projects/gameDev.dart';
import 'package:portfolio/bodies/projects/webDev.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/ui/textLink.dart';
import 'package:portfolio/utils/wrappedText.dart';

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
          Text(
            "/*\n" +
                "I'm updating this section little by little since there is alot of content to edit and display\n" +
                "When I'm finished I'll take down this message\n" +
                "But until then feel free to ask for more information on any individual project\n" +
                "*/",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          AppDevelopment(),
          GameDevelopment(),
          WebDevelopment(),
        ],
      ),
    );
  }
}

class DevelopmentSection extends StatelessWidget {
  DevelopmentSection({
    @required this.label,
    @required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      separator: "",
      sectionType: SectionType.Parenthesis,
      initiallyOpened: false,
      child: child,
    );
  }
}

class SubSection extends StatelessWidget {
  SubSection({
    @required this.label,
    @required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      sectionType: SectionType.Brackets,
      child: child,
    );
  }
}

class ProjectSection extends StatelessWidget {
  ProjectSection({
    @required this.label,
    @required this.description,
    @required this.github,
    this.livePage,
    this.googlePlayLink,
    this.appStoreLink,
    this.imageUrls,
  });

  final String label;
  final String description;
  final String github;
  final String livePage;
  final String googlePlayLink;
  final String appStoreLink;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    BorderSide galleryBorder = BorderSide(
      color: MyApp.highlightGreen, //MyApp.lightBlueText, //MyApp.galleryBorder,
      width: 2,
    );

    //build
    return CollapsibleSection(
      label: label,
      labelColor: MyApp.highlightGreen, //MyApp.lightBlueText,
      separator: "",
      sectionType: SectionType.Parenthesis,
      leftPadding: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Slideshow(
            galleryBorder: galleryBorder,
            github: github,
            imageUrls: imageUrls,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(
                      "descrip: ",
                      style: GoogleFonts.robotoMono(
                        color: MyApp.oldGrey,
                      ),
                    ),
                    Text(
                      description + ", ",
                    ),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Visibility(
                      visible: livePage != null,
                      child: IconWebLink(
                        url: livePage,
                        label: "Live Page",
                        icon: IconLinkIcon(
                          icon: FontAwesome5.window_maximize,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: googlePlayLink != null,
                      child: IconWebLink(
                        url: googlePlayLink,
                        label: "Google Play",
                        icon: IconLinkIcon(
                          icon: FontAwesome5Brands.google_play,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: appStoreLink != null,
                      child: IconWebLink(
                        url: appStoreLink,
                        label: "App Store",
                        icon: IconLinkIcon(
                          icon: FontAwesome5Brands.app_store_ios,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: github != null && imageUrls == null,
                      child: IconWebLink(
                        url: github,
                        label: "Repository",
                        icon: IconLinkIcon(
                          icon: FontAwesome5Brands.github,
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
    @required this.github,
    this.invisible: false,
  }) : super(key: key);

  final BorderSide galleryBorder;
  final String github;
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
          Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconWebLink(
                    url: github,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        right: 8,
                      ),
                      child: Icon(
                        FontAwesome.github,
                      ),
                    ),
                  ),
                  TextWebLink(
                    url: github,
                    text: Text(
                      "See More",
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(" - "),
                  TextWebLink(
                    url: github,
                    text: Text(
                      github,
                      style: GoogleFonts.robotoMono(
                        color: MyApp.oldGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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
