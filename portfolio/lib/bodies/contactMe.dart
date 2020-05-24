//fluter
import 'package:flutter/material.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//plugins
import 'package:portfolio/main.dart';

//internal
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';
import 'package:portfolio/utils/mySnackBar.dart';

//widget
class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 48,
      ),
      child: Column(
        children: <Widget>[
          QuickLinks(),
          QRSection(),
        ],
      ),
    );
  }
}

class QuickLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String number = "(956) 777-2692";
    String email = "bryan.o.cancel@gmail.com";
    String github = "https://github.com/b-cancel";
    String resume = "https://docs.google.com/document/d/1UBKxKsYBhC5d6IxjRxmYIItFoTFb9Fs_AgX5b64sjlA";
    String hackerRank = "https://www.hackerrank.com/bryan_o_cancel?hr_r=1";
    String linkedIn = "https://www.linkedin.com/in/bryan-cancel-069a197a/";

    //build
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.spaceBetween,
      runSpacing: 8,
      spacing: 16,
      children: <Widget>[
        IconPhoneLink(
          icon: IconLinkIcon(
            icon: PortfolioIcons.phone,
          ),
          url: number,
          label: number,
        ),
        IconEmailLink(
          icon: IconLinkIcon(
            icon: PortfolioIcons.email,
          ),
          url: email, 
          label: email,
        ),
        IconWebLink(
          url: github,
          icon: IconLinkIcon(
            icon: PortfolioIcons.github,
          ),
          label: "Github",
        ),
        IconWebLink(
          url: resume,
          icon: IconLinkIcon(
            icon: PortfolioIcons.file_alt,
          ),
          label: "Resume",
        ),
        IconWebLink(
          url: hackerRank,
          icon: IconLinkIcon(
            icon: PortfolioIcons.hackerrank,
          ),
          label: "Hacker Rank",
        ),
        IconWebLink(
          url: linkedIn,
          icon: 
          IconLinkIcon(
            icon: PortfolioIcons.linkedin,
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
          style: MyApp.robotoMono.copyWith(
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
                      icon: PortfolioIcons.check,
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