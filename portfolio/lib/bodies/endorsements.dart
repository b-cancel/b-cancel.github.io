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
        return Container(
          color: index%2==0 ? Colors.red : Colors.blue,
          height: 100,
          width: 250,
        );

        /*
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
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){},
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12.0,
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
                              ref.name,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: ref.title != null,
                          child: Text(
                            ref.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                            onTap: (){
                              print("tap");
                              BotToast.showSimpleNotification(title: "hi");
                            },
                            child: Text(
                              ref.phone ?? "",
                              style: TextStyle(
                                color: MyApp.oldOrange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        */
      },
    );

    //build
    return Padding(
      padding: EdgeInsets.only(
        right: 48,
      ), //1935
      child: SplitScreenLayout(
        items: items,
      ),
      
      
      
      /*LayoutBuilder(
        builder: (context, constraints){
          print("const: " + constraints.maxWidth.toString());
          if(constraints.maxWidth > 1835){
            return IntrinsicHeight(
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
            );
          }
          else{
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(
                references.length,
                (index) {
                  return items[index];
                },
              ),
            );
          }
        },
      ),*/
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
            )
          ),
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
            )
          ),
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
