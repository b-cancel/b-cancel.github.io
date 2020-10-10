import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu/changingText.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

class ExpandMyWorkOnHover extends StatefulWidget {
  const ExpandMyWorkOnHover({
    Key key,
    @required this.minWidth,
    @required this.maxWidth,
  }) : super(key: key);

  final double minWidth;
  final double maxWidth;

  @override
  _ExpandMyWorkOnHoverState createState() => _ExpandMyWorkOnHoverState();
}

class _ExpandMyWorkOnHoverState extends State<ExpandMyWorkOnHover> {
  final ValueNotifier<bool> isHovering = new ValueNotifier<bool>(false);
  ValueNotifier<bool> isSpreaded;

  bool shouldBeSpreaded() {
    return (isHovering.value);
  }

  updateSpreaded() {
    isSpreaded.value = shouldBeSpreaded();
  }

  @override
  void initState() {
    super.initState();

    //init
    isSpreaded = new ValueNotifier(shouldBeSpreaded());

    //listeners
    isHovering.addListener(updateSpreaded);
  }

  @override
  void dispose() {
    isHovering.removeListener(updateSpreaded);

    //super dipose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
      ),
      child: PointerOnHover(
        isHovering: isHovering,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: Colors.transparent,
            //toggle
            onTap: () {},
            child: Material(
              color: Colors.black,
              child: InkWell(
                onTap: () {
                  //my work in resume can close the menu
                  if (Home.openMenu.value) {
                    Home.openMenu.value = false;
                  }
                },
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: widget.minWidth,
                    maxWidth: widget.maxWidth,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  height: 56,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        child: SpreadingTitle(
                          title: "My Work",
                          spreaded: isSpreaded,
                          isWork: true,
                        ),
                      ),
                      Center(
                        child: AnimatedBuilder(
                          animation: isSpreaded,
                          builder: (context, child) {
                            return AnimatedContainer(
                              duration: kTabScrollDuration,
                              padding: EdgeInsets.symmetric(
                                horizontal: isSpreaded.value ? 8 : 0,
                              ),
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: MyApp.h2,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
