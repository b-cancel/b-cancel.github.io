//fluter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';
import 'package:platform_detect/platform_detect.dart';

//internal
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/nonWebLink.dart';
import 'package:portfolio/utils/openLink.dart';
import '../utils/copyToClipboard.dart';
import '../utils/mySnackBar.dart';
import '../utils/openLink.dart';

//widget
class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "(956) 777-2692";
    String email = "bryan.o.cancel@gmail.com";

    //build
    return Padding(
      padding: EdgeInsets.only(
        //left bracket, line, right bracket, ???
        right: 16.0 + 4 + 24 + 8, //padding that fully centers items
      ),
      child: Column(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8,
            spacing: 16,
            children: <Widget>[
              IconTextButton(
                email: email,
                onTap: () async {
                  print("Clicked phone");
                  if(await copyToClipboard(number)){
                    print("copied to clipboard");
                    showSnackBar(
                      context,
                      text: number + " Copied To Clipboard",
                      icon: Icons.content_copy,
                    );
                  }
                  else{
                    print("could copy");
                    showSnackBar(
                      context,
                      text: "Use " + number + " to Call or Text Me",
                      icon: Icons.phone,
                    );
                  }
                },
                secondaryActionMessage: "Message Me",
                onSecondaryAction: () async{
                  if (await messageNumber(number) == false) {
                    showSnackBar(
                      context,
                      text: "Unable To Message Number",
                    );
                  }
                },
                icon: Icons.phone,
                text: number,
              ),
              IconTextButton(
                email: email,
                onTap: () async {
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
                secondaryActionMessage: "Email Me",
                onSecondaryAction: ()async{
                  if (await sendEmail(email) == false) {
                    showSnackBar(
                      context,
                      text: "Unable To Send Email",
                    );
                  }
                },
                icon: Icons.email,
                text: email,
              ),
              IconTextButton(
                email: email,
                onTap: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: true,
                  );
                },
                secondaryActionMessage: "open in another tab",
                onSecondaryAction: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: false,
                  );
                },
                icon: FontAwesome.github,
                text: "Github",
              ),
              IconTextButton(
                email: email,
                onTap: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: true,
                  );
                },
                secondaryActionMessage: "open in another tab",
                onSecondaryAction: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: false,
                  );
                },
                icon: FontAwesome.file_text,
                text: "Resume",
              ),
              IconTextButton(
                email: email,
                onTap: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: true,
                  );
                },
                secondaryActionMessage: "open in another tab",
                onSecondaryAction: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: false,
                  );
                },
                icon: FontAwesome5Brands.hackerrank,
                text: "Hacker Rank",
              ),
              IconTextButton(
                email: email,
                onTap: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: true,
                  );
                },
                secondaryActionMessage: "open in another tab",
                onSecondaryAction: (){
                  openWithHtml(
                    context, 
                    "https://www.google.com", 
                    openHere: false,
                  );
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
    @required this.onTap,
    this.onSecondaryAction,
    this.secondaryActionMessage,
    @required this.icon,
    @required this.text,
    @required this.email,
  }) : super(key: key);

  final Function onTap;
  final Function onSecondaryAction;
  final String secondaryActionMessage;
  final IconData icon;
  final String text;
  //has the most width out of all of them
  //so to create equal spacing
  final String email;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0,
          child: Text(email),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SelectableText(
              text,
              enableInteractiveSelection: true,
              toolbarOptions: ToolbarOptions(
                //not cut or paste
                selectAll: true,
                copy: true,
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

//TODO: make it disapear immediately when scroll
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
