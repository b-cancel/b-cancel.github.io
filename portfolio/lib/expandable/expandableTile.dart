//flutter
import 'package:flutter/material.dart';

//widget
/*
class ExpandableTile extends StatefulWidget {
  const ExpandableTile({
    Key key,
    @required this.isOpen,
    @required this.headerIcon,
    @required this.headerText,
    @required this.expandedChild,
    this.theOnlyException: true,
    this.size,
  }) : super(key: key);

  final ValueNotifier<bool> isOpen;
  final Widget header
  final IconData headerIcon;
  final String headerText;
  final Widget expandedChild;
  final double size;
  final bool theOnlyException;

  @override
  _ExpandableTileState createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  @override
  Widget build(BuildContext context) {
    Widget header = AnimatedBuilder(
      animation: widget.isOpen,
      builder: (context, child){
        return TileHeader(
          headerIcon: widget.headerIcon,
          headerText: widget.headerText,
          size: widget.size,
          openOrClose: (){
            widget.isOpen.value = !widget.isOpen.value;
            setState(() {});
          },
          isOpen: widget.isOpen,
        );
      },
    );

    Widget body = AnimatedBuilder(
      animation: widget.isOpen,
      builder: (context, child){
        return AnimatedSwitcher(
          duration: ExercisePage.transitionDuration,
          transitionBuilder: (widget, animation){
            return SizeTransition(
              child: widget,
              sizeFactor: Tween<double>(
                begin: 0, 
                end: 1,
              ).animate(animation),
            );
          },
          child: (widget.isOpen.value) 
          ? TileBody(
            child: widget.expandedChild,
            theOnlyException: widget.theOnlyException,
          )
          : Container(
            height: 0,
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
    );

    return Column(
      children: <Widget>[
        header,
        body,
      ],
    );
  }
}
*/