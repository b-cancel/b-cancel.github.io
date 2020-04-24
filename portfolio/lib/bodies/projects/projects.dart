//flutter
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';

//internal
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/section/section.dart';

//internal: subsection
import 'package:portfolio/bodies/projects/appDev.dart';
import 'package:portfolio/bodies/projects/gameDev.dart';
import 'package:portfolio/bodies/projects/webDev.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';

class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "/*\n" 
            + "I'm updating this section little by little since there is alot of content to edit and display\n"
            + "When I'm finished I'll take down this message\n"
            + "But until then feel free to ask for more information on any individual project\n"
            + "*/",
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
    return CollapsibleSection(
      label: label,
      labelColor: Colors.white,
      separator: "",
      sectionType: SectionType.Parenthesis,
      leftPadding: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "descrip: ",
                style: GoogleFonts.robotoMono(
                  color: MyApp.oldGrey,
                ),
              ),
              Expanded(
                child: Text(description + ", "),
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
          //TODO: add github gallery link combo
        ],
      ),
    );
  }
}
