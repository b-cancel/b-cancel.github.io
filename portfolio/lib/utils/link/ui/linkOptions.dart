import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//options tool bar for links
//should be used for text link and icons links
showOptions(
  BuildContext context, {
  List<Widget> children,
  bool lightMode: true,
  PreferDirection preferDirection: PreferDirection.topCenter,
}) {
  BotToast.showAttachedWidget(
    targetContext: context,
    preferDirection: preferDirection,
    duration: Duration(days: 1),
    enableSafeArea: true,
    onlyOne: true,
    attachedBuilder: (_) {
      return Theme(
        data: lightMode ? ThemeData.dark() : ThemeData.light(),
        child: Card(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ),
      );
    },
  );
}
