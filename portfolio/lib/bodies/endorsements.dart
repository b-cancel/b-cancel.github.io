//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//plugin

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/ui/textLink.dart';

class Reference {
  String name;
  String title;
  String location;
  String email;
  String phone;
  String letterUrl;
  Reference({
    this.name,
    this.title, 
    this.location,
    this.email,
    this.phone,
    this.letterUrl,
  });
}

List<Reference> references = [
  Reference(
    name: "Dr. Richard Frnka",
    title: "CleverSolve Co-Owner",
    location: "CleverSolve LLC – Edinburg, TX",
    email: "admin@cleversolve.com",
    phone: "(817) 279-3965",
    letterUrl: "https://www.google.com",
  ),
  Reference(
    name: "Dr. Constantine M. Tarawneh",
    title: "Director of the Center for Railway Safety",
    location: "UTRGV – Edinburg, TX",
    email: "constantine.tarawneh@utrgv.edu",
    letterUrl: "https://www.google.com",
  ),
  Reference(
    name: "Mrs. Vickie Roge",
    title: "Founder of BETA TSA",
    location: "BETA – Edinburg, TX",
    email: "vickie.roge@stisd.net",
    letterUrl: "https://www.google.com",
  ),
  Reference(
    name: "Jesus Reyes",
    title: "Peer, Major: Computer Science",
    location: "BETA & UTRGV – Edinburg, TX",
    email: "jesus.e.reyes01@utrgv.edu",
  ),
  Reference(
    name: "Mrs. Nashla Showery",
    title: "Internship Coordinator",
    location: "BETA – Edinburg, TX",
    email: "nashla.showery@stisd.net",
  ),
  Reference(
    name: "Mr. Alejandro Garcia",
    title: "TSA Chapter 513 Sponsor",
    location: "BETA – Edinburg, TX",
    email: "alejandro.garcia@stisd.net",
  ),
  Reference(
    name: "Mrs. Irma Hermida",
    title: "Internship Director",
    location: "UTRGV – Edinburg, TX",
    email: "hermidaid@utpa.edu",
    letterUrl: "https://www.google.com",
  ),
];

class ReferencesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        references.length,
        (index) {
          Reference ref = references[index];
          return Padding(
            padding: EdgeInsets.only(
              right: 48.0,
            ),
            child: CollapsibleSection(
              label: "Ref",
              separator: "",
              sectionType: SectionType.Parenthesis,
              leftPadding: ref.letterUrl == null,
              child: Wrap(
                children: <Widget>[
                  Visibility(
                    visible: ref.letterUrl != null,
                    child: IconWebLink(
                      url: ref.letterUrl,
                      label: "Recommendation Letter",
                      icon: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            //give red border
                            Icon(
                              FontAwesomeIcons.solidFilePdf,
                              color: Colors.red,
                              size: 36,
                            ),
                            //make center bit red
                            Padding(
                              //36 total
                              padding: EdgeInsets.only(
                                top: 14.0,
                                bottom: 4.0,
                              ),
                              child: Container(
                                color: Colors.red,
                                height: 18,
                                width: 24,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.solidFilePdf,
                              color: Colors.white,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: ref.name != null,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          child: Text(
                            (ref.name ?? "") + ",",
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ref.title != null,
                        child: Text(
                          (ref.title ?? "") + ",",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ref.location != null,
                        child: Text(
                          (ref.location ?? "") + ",",
                        ),
                      ),
                      Visibility(
                        visible: ref.email != null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: TextEmailLink(
                            url: ref.email,
                            preferDirection: PreferDirection.rightCenter,
                            text: Text(
                              (ref.email ?? "") + ",",
                              style: TextStyle(
                                color: MyApp.highlightGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ref.phone != null,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: TextPhoneLink(
                            url: ref.phone,
                            preferDirection: PreferDirection.rightCenter,
                            text: Text(
                              (ref.phone ?? "") + ",",
                              style: TextStyle(
                                color: MyApp.oldOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}