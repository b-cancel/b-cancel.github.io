//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/utils/copyToClipboard.dart';

//plugin
import 'package:portfolio/utils/link/linkOptions.dart';

//internal
import 'package:portfolio/utils/openLink.dart';
import 'package:portfolio/utils/hover.dart';

//widget
class IconWebLink extends StatelessWidget {
  IconWebLink({
    @required this.url,
    @required this.icon,
    this.label,
  });

  final String url;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OpaqueOnHover(
      child: IconLink(
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
                label: "new tab",
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
                label: "copy",
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
        optionsText: label ?? "",
      ),
    );
  }
}

class IconLink extends StatelessWidget {
  const IconLink({
    Key key,
    @required this.onTap,
    this.onShowOptions,
    @required this.icon,
    this.optionsText,
  }) : super(key: key);

  final Function onTap;
  final Function onShowOptions;
  final IconData icon;
  final String optionsText;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
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
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              icon,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
