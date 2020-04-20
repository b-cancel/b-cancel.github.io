//fluter
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';
import 'package:portfolio/utils/mySnackBar.dart';

//widget
class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        QuickLinks(),
        QRSection(),
      ],
    );
  }
}

class QuickLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "(956) 777-2692";
    String email = "bryan.o.cancel@gmail.com";

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.spaceBetween,
      runSpacing: 8,
      spacing: 16,
      children: <Widget>[
        IconPhoneLink(
          icon: IconLinkIcon(
            icon: Icons.phone,
          ),
          url: number,
          label: number,
        ),
        IconEmailLink(
          icon: IconLinkIcon(
            icon: Icons.email,
          ),
          url: email, 
          label: email,
        ),
        IconWebLink(
          url: "https://www.google.com",
          icon: IconLinkIcon(
            icon: FontAwesome.github,
          ),
          label: "Github",
        ),
        IconWebLink(
          url: "https://www.google.com",
          icon: IconLinkIcon(
            icon: FontAwesome.file_text,
          ),
          label: "Resume",
        ),
        IconWebLink(
          url: "https://www.google.com",
          icon: IconLinkIcon(
            icon: FontAwesome5Brands.hackerrank,
          ),
          label: "Hacker Rank",
        ),
        IconWebLink(
          url: "https://www.google.com",
          icon: 
          IconLinkIcon(
            icon: FontAwesome5Brands.linkedin,
          ),
          label: "Linked In",
        ),
      ],
    );
  }
}

class QRSection extends StatelessWidget {
  const QRSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                QRCode(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QRCode extends StatelessWidget {
  const QRCode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  if (await downloadFile(url)) {
                    showSnackBar(
                      context,
                      text: "Contact Card Downloaded",
                      icon: Icons.check,
                    );
                  }
                  else{
                    showSnackBar(
                      context,
                      text: 'Contact Card Download Not Supported',
                    );
                  }
                },
                child: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}