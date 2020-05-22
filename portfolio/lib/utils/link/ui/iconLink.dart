//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';

//internal: ui
import 'package:portfolio/utils/link/ui/linkOptions.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//internal: function
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/openLink.dart';

//widget
class IconPhoneLink extends StatelessWidget {
  IconPhoneLink({
    @required this.url,
    @required this.icon,
    this.label,
  });

  final String url;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: Icons.phone,
              label: "Call",
              onTap: () {
                callNumber(context, url);
              },
            ),
            OptionButton(
              icon: Icons.message,
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
  });

  final String url;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: Icons.email,
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
  });

  final String url;
  final Widget icon;
  final String label;
  final bool addOvalClipper;

  @override
  Widget build(BuildContext context) {
    return IconLink(
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
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: Icons.open_in_new,
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
              icon: Icons.content_copy,
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

class IconLink extends StatelessWidget {
  const IconLink({
    Key key,
    @required this.onTap,
    this.onShowOptions,
    @required this.icon,
    this.addOvalClipper: true,
  }) : super(key: key);

  final Function onTap;
  final Function onShowOptions;
  final Widget icon;
  final bool addOvalClipper;

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

    if (addOvalClipper) {
      inkWell = ClipOval(
        child: inkWell,
      );
    }

    return OpaqueOnHover(
      child: inkWell,
    );
  }
}

class IconLinkIcon extends StatelessWidget {
  IconLinkIcon({
    @required this.icon,
    this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 36,
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
