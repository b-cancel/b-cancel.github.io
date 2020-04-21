//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//plugin
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/main.dart';
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
    /*
    List<Widget> items = List.generate(
      references.length,
      (index) {
        Reference ref = references[index];
        return AReference(
          ref: ref,
          collapse: true,
        );
      },
    );

    //largest item
    //use for alignment all over
    Widget largestItem = Visibility(
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      visible: false,
      child: Stack(
        children: items,
      ),
    );
    */

    return Container();
  }
}