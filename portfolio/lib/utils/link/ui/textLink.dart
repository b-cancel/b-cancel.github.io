//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';

//internal: ui
import 'package:portfolio/utils/link/ui/linkOptions.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//internal: function
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/openLink.dart';

//widget
class TextPhoneLink extends StatelessWidget {
  TextPhoneLink({
    @required this.url,
    @required this.text,
    this.preferDirection,
    this.label,
  });

  final String url;
  final Widget text;
  final PreferDirection preferDirection;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextLink(
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          preferDirection: preferDirection,
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
      text: text,
    );
  }
}

class TextEmailLink extends StatelessWidget {
  TextEmailLink({
    @required this.url,
    @required this.text,
    this.preferDirection,
    this.label,
  });

  final String url;
  final Widget text;
  final PreferDirection preferDirection;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextLink(
      onTap: () {
        copyToClipboard(
          context,
          url,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          preferDirection: preferDirection,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: Icons.send,
              label: "Email",
              onTap: () {
                sendEmail(context, url);
              },
            ),
          ],
        );
      },
      text: text,
    );
  }
}

class TextWebLink extends StatelessWidget {
  TextWebLink({
    @required this.url,
    @required this.text,
    this.label,
  });

  final String url;
  final Widget text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextLink(
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
      text: text,
    );
  }
}

class TextLink extends StatelessWidget {
  const TextLink({
    Key key,
    @required this.onTap,
    this.onShowOptions,
    @required this.text,
  }) : super(key: key);

  final Function onTap;
  final Function onShowOptions;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Material(
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
        child: UnderlineOnHover(
          child: text,
        ),
      ),
    );
  }
}