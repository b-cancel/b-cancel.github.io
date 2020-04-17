import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/utils/iconLink.dart';

class Reference {
  String name;
  String title;
  String location;
  String email;
  String letterUrl;
  Reference({
    this.name,
    this.title,
    this.location,
    this.email,
    this.letterUrl,
  });
}

List<Reference> references = [
  Reference(
    name: "Dr. Constantine M. Tarawneh",
    title: "Director of the Center for Railway Safety",
    location: "UTRGV – Edinburg, TX",
    email: "constantine.tarawneh@utrgv.edu",
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
    name: "Dr. Constantine M. Tarawneh",
    title: "Director of the Center for Railway Safety",
    location: "UTRGV – Edinburg, TX",
    email: "constantine.tarawneh@utrgv.edu",
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
    name: "Dr. Constantine M. Tarawneh",
    title: "Director of the Center for Railway Safety",
    location: "UTRGV – Edinburg, TX",
    email: "constantine.tarawneh@utrgv.edu",
    letterUrl: "https://www.google.com",
  ),
  Reference(
    name: "Dr. Constantine M. Tarawneh",
    title: "Director of the Center for Railway Safety",
    location: "UTRGV – Edinburg, TX",
    email: "constantine.tarawneh@utrgv.edu",
    letterUrl: "https://www.google.com",
  ),
];

class ReferencesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.spaceBetween,
      children: List.generate(
        references.length,
        (index) {
          Reference ref = references[index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconWebLink(
                url: ref.letterUrl,
                icon: FontAwesome5.file_pdf,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ref.name),
                    Text(ref.title),
                    Text(ref.location),
                    Text(ref.email),
                  ]
                ),
              )
            ],
          );
        },
      ),
    );  
  }
}
