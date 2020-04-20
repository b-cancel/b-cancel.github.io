//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugin
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';
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

class ReferencesBody extends StatefulWidget {
  @override
  _ReferencesBodyState createState() => _ReferencesBodyState();
}

//NOTE: this is a very disgusting way of acheiving the desire effect
//all I want to do is to get the items fliped vertically and under the actually clickable elements
//but using flipvertial had a side effect and this fixed it
//it does the job for now
class _ReferencesBodyState extends State<ReferencesBody>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    Future<void>.delayed(Duration(seconds: 1), () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    // Don't forget to dispose the animation controller on class destruction
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    //build
    return Padding(
      padding: EdgeInsets.only(
        right: 48,
      ),
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: animation,
            child: Transform(
              transform: Matrix4Transform().flipVertically().matrix4,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(
                  references.length,
                  (index) {
                    Reference ref = references[index];
                    return Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        largestItem,
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: AReference(
                              ref: ref,
                              makeInvisible: true,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: List.generate(
              references.length,
              (index) {
                Reference ref = references[index];
                return Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    largestItem,
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: AReference(
                          ref: ref,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: MyApp.bodyColor,
              width: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class AReference extends StatelessWidget {
  const AReference({
    Key key,
    @required this.ref,
    this.collapse: false,
    this.makeInvisible: false,
  }) : super(key: key);

  final Reference ref;
  final bool collapse;
  final bool makeInvisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: Opacity(
        opacity: makeInvisible ? 0 : 1,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            bottom: 12,
            right: ref.letterUrl == null ? 16 : 0,
          ),
          child: Row(
            mainAxisSize: collapse ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: collapse
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Ref (",
                        style: TextStyle(
                          color: MyApp.oldGrey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.0,
                        ),
                        child: Column(
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
                      ),
                      Text(
                        "),",
                        style: TextStyle(
                          color: MyApp.oldGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: ref.letterUrl != null,
                child: IconWebLink(
                  url: "https://google.com",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineBetween extends StatelessWidget {
  const LineBetween({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 2,
          color: MyApp.oldGrey,
        ),
      ),
    );
  }
}
