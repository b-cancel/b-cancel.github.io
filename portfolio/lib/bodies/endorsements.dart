//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/hover.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';
import 'package:portfolio/utils/link/linkOptions.dart';

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
        return AReference(
          ref: ref,
          collapse: true,
        );
      },
    );

    //build
    return Padding(
      padding: EdgeInsets.only(
        right: 48,
      ),
      child: Stack(
        children: <Widget>[
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
              references.length,
              (index) {
                Reference ref = references[index];
                return Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Visibility(
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      visible: false,
                      child: Stack(
                        children: items,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: AReference(
                          ref: ref,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        color: MyApp.oldGrey,
                        width: 2,
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
  }) : super(key: key);

  final Reference ref;
  final bool collapse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        bottom: 12,
        right: ref.letterUrl == null ? 24 : 8,
      ),
      child: Row(
        mainAxisSize: collapse ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment:
            collapse ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
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
                            padding: EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                              (ref.email ?? "") + ",",
                              style: TextStyle(
                                color: MyApp.highlightGreen,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: ref.phone != null,
                          child: InvisibleInkWell(
                            /*
                            onHover: (){
                              showOptions(
                                context, 
                                ref.phone,
                                text: "phone",
                              );
                            },
                            */
                            /*
                            onDoubleTap: (){
                              showOptions(
                                context, 
                                ref.phone,
                                label: "phone",
                              );
                            },
                            onLongPress: (){
                              print("long press");
                              showOptions(
                                context, 
                                ref.phone,
                                label: "phone",
                              );
                            },
                            */
                            onTap: () {
                              print("tap");
                              BotToast.showSimpleNotification(title: "hi");
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                              ),
                              child: Text(
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
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
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
            ),
          ),
        ],
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

/*
IntrinsicHeight(
              child: Row(
                children: [
                  items[0],
                  LineBetween(),
                  items[1],
                  LineBetween(),
                  items[2],
                  LineBetween(),
                  items[3],
                  LineBetween(),
                  items[4],
                  LineBetween(),
                  items[5],
                ],
              ),
            )
*/

//formatting per column is
//item -> expanded -> spacer stick
//item -> expanded -> spacer stick
//etc
//and all those spacer sticks become one
//so you dont have any weird breakages
class SplitScreenLayout extends StatelessWidget {
  SplitScreenLayout({
    @required this.items,
    @required this.columns,
  });

  final List<Widget> items;
  final int columns;

  //for 6 items
  //for full screen we have [1,1,1,1,1,1] -1 column           1 row
  //for after we have       [2,1,1,1,1] -1 column             2 rows (4 columns with fillers)
  //for after we have       [2,2,1,1] -1 column               2 rows (2 columns with fillers)
  //for after we have       [2,2,2] -1 column                 2 rows
  //for after we have       [3,3] -1 column                   3 rows
  //for after we have       [6] - 1 column (no separator bars)6 rows
  @override
  Widget build(BuildContext context) {
    //NOTE: all the items in every row have right borders except the last one

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        TableRow(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Colors.green, // MyApp.oldGrey,
                    ),
                  )),
              height: 150,
              width: 200,
            ),
            Container(
              color: Colors.yellow,
              height: 100,
              width: 200,
            ),
          ],
        ),
        TableRow(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Colors.green, // MyApp.oldGrey,
                    ),
                  )),
              height: 75,
              width: 250,
            ),
            Container(
              color: Colors.orange,
              height: 50,
              width: 250,
            ),
          ],
        )
      ],
    );
  }
}
