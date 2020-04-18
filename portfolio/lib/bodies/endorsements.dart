//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/utils/link/iconLink.dart';
import 'package:portfolio/main.dart';

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
    List<Widget> items = List.generate(
      references.length,
      (index) {
        Reference ref = references[index];
        return Card(
          margin: EdgeInsets.all(0),
          color: MyApp.headerColor,
          child: Padding(
            padding: EdgeInsets.only(
              right: 16,
              bottom: 12,
              left: ref.letterUrl == null ? 16 : 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: ref.letterUrl != null,
                  child: IconWebLink(
                    url: ref.letterUrl,
                    icon: FontAwesome5Solid.file_pdf,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: ref.name != null,
                        child: Text(
                          ref.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ref.title != null,
                        child: Text(
                          ref.title,
                        ),
                      ),
                      Visibility(
                        visible: ref.location != null,
                        child: Text(
                          ref.location,
                        ),
                      ),
                      Visibility(
                        visible: ref.email != null,
                        child: Text(
                          ref.email,
                          style: TextStyle(
                            color: MyApp.highlightGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    //build
    return Padding(
      padding: EdgeInsets.only(
        right: 24,
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.spaceBetween,
        children: List.generate(
          references.length,
          (index) {
            return items[index];
          },
        ),
      ),
    );
  }
}
