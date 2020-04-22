//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/utils/link/ui/textLink.dart';
import 'package:portfolio/utils/splitScreenView.dart';

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
    //bits that expand reusable multiple times
    List<Widget> getExpandingReferences = new List<Widget>(references.length);
    for (int i = 0; i < references.length; i++) {
      Reference ref = references[i];
      getExpandingReferences[i] = ExpandingReference(
        ref: ref,
      );
    }

    //right bits reusable multiple times
    List<Widget> getReferenceIcons = new List<Widget>(references.length);
    for (int i = 0; i < references.length; i++) {
      Reference ref = references[i];
      getReferenceIcons[i] = ReferenceIcon(
        ref: ref,
      );
    }

    //all the collapsed references
    List<Widget> stackedRefs = new List<Widget>(references.length);
    for (int i = 0; i < references.length; i++) {
      stackedRefs[i] = ASplitScreenItem(
        splitScreenItem: SplitScreenItem(
          getExpandingReferences[i],
          widgetOnRight: getReferenceIcons[i],
        ),
        collapse: true,
      );
    }

    //largest item
    //use for alignment all over
    Widget largestItem = Visibility(
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      visible: false,
      child: Stack(
        children: stackedRefs,
      ),
    );

    List<SplitScreenItem> splitScreenItems =
        new List<SplitScreenItem>(references.length);
    for (int i = 0; i < references.length; i++) {
      splitScreenItems[i] = SplitScreenItem(
        getExpandingReferences[i],
        widgetOnRight: getReferenceIcons[i],
      );
    }

    return SplitScreenView(
      items: splitScreenItems,
      largestItem: largestItem,
    );
  }
}

class ExpandingReference extends StatelessWidget {
  ExpandingReference({
    @required this.ref,
  });

  final Reference ref;

  @override
  Widget build(BuildContext context) {
    Widget referenceBody = Column(
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
    );

    //build
    return CollapsibleSection(
      label: "Ref",
      separator: "",
      sectionType: SectionType.Parenthesis,
      allowCollapsing: false,
      child: referenceBody,
    );
  }
}

class ReferenceIcon extends StatelessWidget {
  ReferenceIcon({
    @required this.ref,
  });

  final Reference ref;

  @override
  Widget build(BuildContext context) {
    if (ref.letterUrl != null) {
      return IconWebLink(
        url: ref.letterUrl,
        label: "Recommendation Letter",
        icon: Padding(
          padding: EdgeInsets.all(12.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //give red border
              Icon(
                FontAwesome5Solid.file_pdf,
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
                FontAwesome5Solid.file_pdf,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
