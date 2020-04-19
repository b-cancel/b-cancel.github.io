//fluter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/link/iconLink.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/nonWebLink.dart';
import '../utils/copyToClipboard.dart';
import '../utils/mySnackBar.dart';

//widget
class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "(956) 777-2692";
    String email = "bryan.o.cancel@gmail.com";

    //build
    return Column(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.spaceBetween,
          runSpacing: 8,
          spacing: 16,
          children: <Widget>[
            IconLink(
              longString: email,
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
            IconLink(
              longString: email,
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
            IconWebLink(
              longString: email,
              url: "https://www.google.com",
              icon: FontAwesome.github,
              text: "Github",
            ),
            IconWebLink(
              longString: email,
              url: "https://www.google.com",
              icon: FontAwesome.file_text,
              text: "Resume",
            ),
            IconWebLink(
              longString: email,
              url: "https://www.google.com",
              icon: FontAwesome5Brands.hackerrank,
              text: "Hacker Rank",
            ),
            IconWebLink(
              longString: email,
              url: "https://www.google.com",
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
    );
  }
}