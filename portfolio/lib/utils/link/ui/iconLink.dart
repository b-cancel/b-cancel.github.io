//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//internal: ui
import 'package:portfolio/utils/link/ui/linkOptions.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//internal: function
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';

//internal
import 'package:portfolio/main.dart';

//widget
class IconPhoneLink extends StatelessWidget {
  IconPhoneLink({
    @required this.url,
    @required this.icon,
    this.label,
    this.lightMode: true,
  });

  final String url;
  final Widget icon;
  final String label;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      lightMode: lightMode,
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          lightMode: lightMode,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: PortfolioIcons.phone,
              label: "Call",
              onTap: () {
                callNumber(context, url);
              },
            ),
            OptionButton(
              icon: PortfolioIcons.message,
              label: "Text",
              onTap: () {
                textNumber(context, url);
              },
            ),
          ],
        );
      },
      icon: icon,
    );
  }
}

class IconEmailLink extends StatelessWidget {
  IconEmailLink({
    @required this.url,
    @required this.icon,
    this.label,
    this.lightMode: true,
  });

  final String url;
  final Widget icon;
  final String label;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      lightMode: lightMode,
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          lightMode: lightMode,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: PortfolioIcons.email,
              label: "Email",
              onTap: () {
                sendEmail(context, url);
              },
            ),
          ],
        );
      },
      icon: icon,
    );
  }
}

class IconWebLink extends StatelessWidget {
  IconWebLink({
    @required this.url,
    @required this.icon,
    this.label,
    this.addOvalClipper: true,
    this.lightMode: true,
  });

  final String url;
  final Widget icon;
  final String label;
  final bool addOvalClipper;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      lightMode: lightMode,
      addOvalClipper: addOvalClipper,
      onTap: () {
        openWithHtml(
          context,
          url,
          openHere: true,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          lightMode: lightMode,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: PortfolioIcons.open_in_new,
              label: "New Tab",
              onTap: () {
                openWithHtml(
                  context,
                  url,
                  openHere: false,
                );
              },
            ),
            OptionButton(
              icon: PortfolioIcons.content_copy,
              label: "Copy",
              onTap: () {
                copyToClipboard(
                  context,
                  url,
                );
              },
            ),
          ],
        );
      },
      icon: icon,
    );
  }
}

class IconLabelLink extends StatelessWidget {
  IconLabelLink({
    @required this.icon,
    this.label,
    this.lightMode: true,
  });

  final Widget icon;
  final String label;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    Function onShowLabel = () {
      showOptions(
        context,
        lightMode: lightMode,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    };

    //build
    return IconLink(
      onTap: () {
        onShowLabel();
      },
      onShowOptions: () {
        onShowLabel();
      },
      addOpaqueOnHover: false,
      addColorizeOnHover: true,
      icon: icon,
      lightMode: lightMode,
    );
  }
}

class IconLink extends StatelessWidget {
  const IconLink({
    Key key,
    @required this.onTap,
    this.onShowOptions,
    @required this.icon,
    this.addOvalClipper: true,
    this.addOpaqueOnHover: true,
    this.addColorizeOnHover: false,
    @required this.lightMode,
  }) : super(key: key);

  final Function onTap;
  final Function onShowOptions;
  final Widget icon;
  final bool addOvalClipper;
  final bool addOpaqueOnHover;
  final bool addColorizeOnHover;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    Widget inkWell = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
        },
        onHover: (h) {
          onShowOptions();
        },
        onDoubleTap: () {
          onShowOptions();
        },
        onLongPress: () {
          onShowOptions();
        },
        child: icon,
      ),
    );

    inkWell = Theme(
      data: lightMode ? ThemeData.light() : ThemeData.dark(),
      child: inkWell,
    );

    if (addOvalClipper) {
      inkWell = ClipOval(
        child: inkWell,
      );
    }

    if (addOpaqueOnHover) {
      return OpaqueOnHover(
        invert: lightMode,
        child: inkWell,
      );
    } else {
      return inkWell;
    }
  }
}

class IconLinkIcon extends StatelessWidget {
  IconLinkIcon({
    @required this.icon,
    this.mini: false,
    this.color,
    this.text,
  });

  final IconData icon;
  final Color color;
  final String text;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    //48 normal size of button
    //40 another size of button
    //36 smallest size of button
    return Padding(
      padding: EdgeInsets.all(
        (mini == false) ? 12.0 : 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: (mini == false) ? 36 : 22,
          ),
          Visibility(
            visible: text != null && text.length > 0,
            child: Text(text ?? ""),
          ),
        ],
      ),
    );
  }
}
