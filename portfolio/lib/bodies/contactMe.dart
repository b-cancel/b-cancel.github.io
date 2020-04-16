//fluter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/nonWebLink.dart';
import 'package:portfolio/utils/openLink.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/copyToClipboard.dart';
import '../utils/mySnackBar.dart';
import '../utils/mySnackBar.dart';
import '../utils/openLink.dart';

/*
showSnackBar(
          context,
          text: item + " Copied To Clipboard",
          duration: Duration(minutes: 1),
          icon: Icons.content_copy,
        );
      } else {
        print("no");
        showSnackBar(
          context,
          text: message,
          duration: Duration(minutes: 1),
          icon: Icons.phone,
        );
*/

//widget
class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "(956) 777-2692";
    String email = "bryan.o.cancel@gmail.com";

    //build
    return Padding(
      padding: EdgeInsets.only(
        right: 34, //padding that fully centers items
      ),
      child: Column(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8,
            spacing: 16,
            children: <Widget>[
              IconTextButton(
                onPressed: () async {
                  if(await copyToClipboard(number)){
                    showSnackBar(
                      context,
                      text: number + " Copied To Clipboard",
                      icon: Icons.content_copy,
                    );
                  }
                  else{
                    showSnackBar(
                      context,
                      text: "Use " + number + " to Call or Text Me",
                      icon: Icons.phone,
                    );
                  }
                },
                longPressMessage: "Message Me",
                onLongPress: () async{
                  if (await messageNumber(number) == false) {
                    showSnackBar(
                      context,
                      text: "Unable To Message Number",
                    );
                  }
                },
                icon: Icons.phone,
                text: "Number",
              ),
              IconTextButton(
                onPressed: () async {
                  if(await copyToClipboard(email)){
                    showSnackBar(
                      context,
                      text: email + " Copied To Clipboard",
                      icon: Icons.content_copy,
                    );
                  }
                  else{
                    showSnackBar(
                      context,
                      text: "Use " + email + " to Email Me",
                      icon: Icons.email,
                    );
                  }
                },
                longPressMessage: "Email Me",
                onLongPress: ()async{
                  if (await sendEmail(email) == false) {
                    showSnackBar(
                      context,
                      text: "Unable To Send Email",
                    );
                  }
                },
                icon: Icons.email,
                text: "Email",
              ),
              IconTextButton(
                onPressed: () async {
                  openWithHtml(context, "https://www.google.com");
                },
                icon: FontAwesome.github,
                text: "Github",
              ),
              IconTextButton(
                onPressed: () {
                  openWithHtml(context, "https://www.google.com");
                },
                icon: FontAwesome.file_text,
                text: "Resume",
              ),
              IconTextButton(
                onPressed: () {
                  openWithHtml(context, "https://www.google.com");
                },
                icon: FontAwesome5Brands.hackerrank,
                text: "Hacker Rank",
              ),
              IconTextButton(
                onPressed: () {
                  openWithHtml(context, "https://www.google.com");
                },
                icon: FontAwesome5Brands.linkedin,
                text: "Linked In",
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.0,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "IFF you want my",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "V-Card / Contact Info",
                        textAlign: TextAlign.center,
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "(Click || Scan)",
                        ),
                      ),
                      Text(
                        "this QR Code",
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              "assets/qrCode.png",
                              width: 200,
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    //NOTE: this only works in the web but that's where I need it to work
                                    String fileName =
                                        "Bryan_Cancel_Contact_V2P1.vcf";
                                    String url = "assets/vcards/" + fileName;
                                    if (await downloadFile(url) == false) {
                                      showSnackBar(
                                        context,
                                        text: 'Contact Card Download Not Supported',
                                      );
                                    }
                                    else{
                                      showSnackBar(
                                        context,
                                        text: "Contact Card Downloaded",
                                        icon: Icons.check,
                                      );
                                    }
                                  },
                                  child: Container(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key key,
    @required this.onPressed,
    this.onLongPress,
    this.longPressMessage,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Function onPressed;
  final Function onLongPress;
  final String longPressMessage;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    //basic button
    Widget button = IconButton(
      onPressed: (){
        //do whatever action was going to be done
        onPressed();

        //inform the user of the other action
        if(onLongPress != null){
          showOnLongPressAction(longPressMessage);
        }
      },
      icon: Icon(
        icon,
        size: 36,
      ),
    );

    //build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(text),
        Ternary(
          condition: onLongPress == null,
          isTrue: button,
          isFalse: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onLongPress: () => onLongPress(),
            child: button,
          ),
        )
      ],
    );
  }
}

showOnLongPressAction(String action) {
  BotToast.showAttachedWidget(
    attachedBuilder: (_) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Long Press To"
          + "\n" + action,
        ),
      ),
    ),
  );
}
