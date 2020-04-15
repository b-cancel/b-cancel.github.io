import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

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
                onPressed: (){}, 
                icon: Icons.phone, 
                text: "Number",
              ),
              IconTextButton(
                onPressed: (){}, 
                icon: Icons.email, 
                text: "Email",
              ),
              IconTextButton(
                onPressed: (){}, 
                icon: FontAwesome.github,
                text: "Github",
              ),
              IconTextButton(
                onPressed: (){}, 
                icon: FontAwesome.file_text,
                text: "Resume",
              ),
              IconTextButton(
                onPressed: (){}, 
                icon: FontAwesome5Brands.hackerrank,
                text: "Hacker Rank",
              ),
              IconTextButton(
                onPressed: (){}, 
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
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(text),
        IconButton(
          onPressed: () => onPressed(),
          icon: Icon(
            icon,
            size: 36,
          ),
        ),
        
      ],
    );
  }
}
