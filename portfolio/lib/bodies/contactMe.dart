//fluter
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/openLink.dart';
import 'package:url_launcher/url_launcher.dart';

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
                onPressed: ()async{
                  var worked = await copyWithClippy("clippy one");
                  String type = worked.runtimeType.toString();
                  String str = worked.toString();
                  showSnackBar(context,text: "clip worked? " + type + " & " + str);
                  //openLinkHere(context, "https://www.google.com");
                  /*
                  String number = "(956) 777-2692";
                  copyItem(
                    context,
                    Icons.phone,
                    item: number,
                    message: "Call or Text Me @ " + number,
                  );
                  */
                },
                onLongPress: (){
                  //url: "tel:" + number,
                },
                icon: Icons.phone,
                text: "Number",
              ),
              IconTextButton(
                onPressed: () async{
                  
                  bool worked = await copyWithClipboardManager("CM one");
                  String type = worked.runtimeType.toString();
                  String str = worked.toString();
                  showSnackBar(context,text: "clip worked? " + type + " & " + str);
                  //openLinkHere(context, "https://www.google.com");
                  /*
                  String email = "bryan.o.cancel@gmail.com";
                  copyItem(
                    context,
                    Icons.email,
                    item: email,
                    message: "Email Me @ " + email,
                  );
                  */
                },
                onLongPress: (){
                  //mailto:smith@example.org?subject=News&body=New%20plugin
                },
                icon: Icons.email,
                text: "Email",
              ),
              IconTextButton(
                onPressed: () async{
                  bool worked = await copyWithFlutterClipboardManager("FCM one");
                  String type = worked.runtimeType.toString();
                  String str = worked.toString();
                  showSnackBar(context,text: "clip worked? " + type + " & " + str);
                  //openLinkHere(context, "https://www.google.com");
                },
                icon: FontAwesome.github,
                text: "Github",
              ),
              IconTextButton(
                onPressed: () {
                  copyWithClippy("clippy two");
                  //openLinkHere(context, "https://www.google.com");
                },
                icon: FontAwesome.file_text,
                text: "Resume",
              ),
              IconTextButton(
                onPressed: () {
                  copyWithClipboardManager("CM two");
                  //openLinkHere(context, "https://www.google.com");
                },
                icon: FontAwesome5Brands.hackerrank,
                text: "Hacker Rank",
              ),
              IconTextButton(
                onPressed: () {
                  copyWithFlutterClipboardManager("FCM two");
                  //openLinkHere(context, "https://www.google.com");
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
                                    String url =
                                        "assets/vcards/Bryan_Cancel_Contact_V2P1.vcf";
                                    try {
                                      await launch(
                                        url,
                                        forceSafariVC: false,
                                        forceWebView: false,
                                        headers: <String, String>{
                                          'my_header_key': 'my_header_value'
                                        },
                                      );
                                    } catch (e) {
                                      showSnackBar(
                                        context,
                                        text:
                                            'Virtual Contact Card Download Not Supported',
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
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Function onPressed;
  final Function onLongPress;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    //basic button
    Widget button = IconButton(
      onPressed: () => onPressed(),
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
