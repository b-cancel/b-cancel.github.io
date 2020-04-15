//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/conditional.dart';

//internal
import 'main.dart';

//widget
class SliverSection extends StatefulWidget {
  SliverSection({
    @required this.title,
    this.icon,
    @required this.body,
    this.initiallyOpened: false,
  });

  final String title;
  final Icon icon;
  final Widget body;
  final bool initiallyOpened;

  @override
  _SliverSectionState createState() => _SliverSectionState();
}

class _SliverSectionState extends State<SliverSection> {
  ValueNotifier<bool> sectionOpened;

  @override
  void initState() {
    //super init
    super.initState();

    sectionOpened = new ValueNotifier<bool>(widget.initiallyOpened);
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: AnimatedBuilder(
        animation: sectionOpened,
        builder: (context, child) {
          return Container(
            color: MyApp.bodyColor,
            padding: EdgeInsets.only(
              top: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: [
                    Visibility(
                      visible: sectionOpened.value,
                      child: Positioned.fill(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            Expanded(
                              child: Container(
                                color: MyApp.oldGrey,
                                width: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.all(
                          12.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyApp.bodyColor,
                            border: Border.all(
                              width: 2,
                              color: MyApp.oldGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: sectionOpened.value == false
                            ? Icon(
                                Icons.add,
                                color: MyApp.oldGrey,
                              )
                            : Icon(
                                FontAwesome.minus,
                                size: 14,
                                color: MyApp.oldGrey,
                              ),
                        onPressed: () {
                          sectionOpened.value = !sectionOpened.value;
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 4,
                          color: sectionOpened.value ? MyApp.oldPurple : Colors.transparent,
                        )
                      )
                    ),
                    padding: EdgeInsets.only(
                      right: 16.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Ternary(
                        condition: sectionOpened.value,
                        isTrue: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Text(
                                "#region",
                                style: TextStyle(
                                  color: MyApp.oldGrey,
                                  height: 0,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: MyApp.oldPurple,
                                  fontSize: 36,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        isFalse: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            AnimatedBuilder(
              animation: sectionOpened,
              child: Container(
                margin: EdgeInsets.only(
                  left: 16.0 + 6,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: MyApp.oldGrey,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(
                        16,
                      ),
                      child: widget.body,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 4,
                          width: 8,
                          color: MyApp.oldGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                          ),
                          child: Text(
                            "#endregion",
                            style: TextStyle(
                              color: MyApp.oldGrey,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              builder: (context, child){
                if(sectionOpened.value){
                  return child;
                }
                else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
