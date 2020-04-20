//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:platform_detect/platform_detect.dart';
import 'package:bot_toast/bot_toast.dart';
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
        onTap: (){
          openWithHtml(
            context, 
            url, 
            openHere: true,
          );
        },
        onShowOptions: (){
          showOptions(
            context, 
            children: [
              OptionButton(
                label: label,
                onTap: (){
                  
                },
              ),
              OptionButton(
                label: "new tab",
                icon: Icons.open_in_new,
                onTap: (){
                  openWithHtml(
                    context, 
                    url, 
                    openHere: false,
                  );
                },
              ),
              OptionButton(
                label: "copy",
                icon: Icons.content_copy,
                onTap: (){

                },
              )
            ]
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
          onTap: (){
            onTap();
          },
          onHover: (h){
            onShowOptions();
          },
          onDoubleTap: (){
            onShowOptions();
          },
          onLongPress: (){
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