import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:portfolio/utils/openLink.dart';

class IconWebLink extends StatelessWidget {
  IconWebLink({
    this.longString,
    this.text,
    @required this.url,
    @required this.icon,
  });

  final String longString;
  final String text;
  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconLink(
      longString: longString ?? "",
      onTap: (){
        openWithHtml(
          context, 
          url, 
          openHere: true,
        );
      },
      secondaryActionMessage: "open in another tab",
      onSecondaryAction: (){
        openWithHtml(
          context, 
          url, 
          openHere: false,
        );
      },
      icon: icon,
      text: text ?? "",
    );
  }
}

class IconLink extends StatelessWidget {
  const IconLink({
    Key key,
    @required this.onTap,
    this.onSecondaryAction,
    this.secondaryActionMessage,
    @required this.icon,
    this.text,
    this.longString,
  }) : super(key: key);

  final Function onTap;
  final Function onSecondaryAction;
  final String secondaryActionMessage;
  final IconData icon;
  final String text;
  //has the most width out of all of them
  //so to create equal spacing
  final String longString;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Visibility(
          visible: longString != null && longString.length > 0,
          child: Opacity(
            opacity: 0,
            child: Text(longString),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: text != null && text.length > 0,
              child: SelectableText(
                text,
                enableInteractiveSelection: true,
                toolbarOptions: ToolbarOptions(
                  //not cut or paste
                  selectAll: true,
                  copy: true,
                ),
              ),
            ),
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    onTap();
                    //for mobile
                    if(onSecondaryAction != null){
                      showOnSecondaryAction(
                        context, 
                        secondaryActionMessage,
                      );
                    }
                  },
                  onHover: (h){
                    //for desktop
                    if(onSecondaryAction != null){
                      showOnSecondaryAction(
                        context, 
                        secondaryActionMessage,
                      );
                    }
                  },
                  //safari doesn't seems to allow holding
                  onDoubleTap: browser.isSafari ? onSecondaryAction : null,
                  onLongPress: browser.isSafari ? null : onSecondaryAction,
                  //widget
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      icon,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

showOnSecondaryAction(BuildContext context, String action) {
  BotToast.showAttachedWidget(
    targetContext: context,
    duration: Duration(seconds: 5),
    onlyOne: true,
    attachedBuilder: (_) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          (browser.isSafari ? "Double Tap To" : "Long Press To")
          + "\n" + action,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}