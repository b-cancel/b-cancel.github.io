import 'package:flutter/material.dart';

//for some reason on flutter web just using a gesture detector instead
//doesn't work the same so I was having to repeat this bit of code often
class InvisibleInkWell extends StatelessWidget {
  InvisibleInkWell({
    @required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
  });

  final Widget child;
  final Function onTap;
  final Function onDoubleTap;
  final Function onLongPress;
  final Function onHover;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //make invisible
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      //functions
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHover: onHover,
      //widget
      child: child,
    );
  }
}