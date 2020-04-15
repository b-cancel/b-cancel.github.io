import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          right: 34, //padding that fully centers items
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  "assets/qrCode.png",
                  width: 200,
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ()async{
                        //NOTE: this only works in the web but that's where I need it to work
                        String url = "assets/vcards/Bryan_Cancel_Contact_V2P1.vcf";
                        try {
                          await launch(
                            url,
                            forceSafariVC: false,
                            forceWebView: false,
                            headers: <String, String>{'my_header_key': 'my_header_value'},
                          );
                        } catch (e){
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(),
                    )
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}