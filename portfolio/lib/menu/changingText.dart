import 'package:flutter/material.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

class SpecialTitle extends StatelessWidget {
  const SpecialTitle({
    Key key,
    @required this.isOpen,
    @required this.useSpreadingTitle,
    @required this.title,
    @required this.isHovering,
    @required this.rotatingArrow,
    @required this.isSpreaded,
  }) : super(key: key);

  final ValueNotifier<bool> isOpen;
  final bool useSpreadingTitle;
  final String title;
  final ValueNotifier<bool> isHovering;
  final Widget rotatingArrow;
  final ValueNotifier<bool> isSpreaded;

  @override
  Widget build(BuildContext context) {
    return PointerOnHover(
      isHovering: isHovering,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.transparent,
          //toggle
          onTap: () {
            isOpen.value = !isOpen.value;
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: useSpreadingTitle ? 16 : 8,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Visibility(
                  visible: useSpreadingTitle == false,
                  child: rotatingArrow,
                ),
                Ternary(
                  condition: useSpreadingTitle,
                  isTrue: SpreadingTitle(
                    title: title,
                    spreaded: isSpreaded,
                  ),
                  isFalse: BoldingTitle(
                    title: title,
                    bolded: isSpreaded,
                  ),
                ),
                Visibility(
                  visible: useSpreadingTitle,
                  child: rotatingArrow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpreadingTitle extends StatelessWidget {
  const SpreadingTitle({
    Key key,
    @required this.title,
    @required this.spreaded,
    this.isWork: false,
  }) : super(key: key);

  final String title;
  final ValueNotifier<bool> spreaded;
  final bool isWork;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: spreaded,
      builder: (context, child) {
        return AnimatedDefaultTextStyle(
          child: Text(
            title,
          ),
          style: TextStyle(
            fontSize: MyApp.h4,
            fontWeight: FontWeight.w900,
            color: isWork ? Colors.white : Colors.black,
            letterSpacing:
                spreaded.value ? (isWork ? 16 : 8) : (isWork ? 8 : 0),
          ),
          duration: kTabScrollDuration,
        );
      },
    );
  }
}

class BoldingTitle extends StatelessWidget {
  const BoldingTitle({
    Key key,
    @required this.title,
    @required this.bolded,
    this.isWork: false,
  }) : super(key: key);

  final String title;
  final ValueNotifier<bool> bolded;
  final bool isWork;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bolded,
      builder: (context, child) {
        return AnimatedDefaultTextStyle(
          child: Text(
            title,
          ),
          style: TextStyle(
            fontSize: MyApp.h5,
            fontWeight: bolded.value ? FontWeight.bold : FontWeight.normal,
            color: isWork ? Colors.white : Colors.black,
          ),
          duration: kTabScrollDuration,
        );
      },
    );
  }
}

class RotatingIconThatHides extends StatefulWidget {
  RotatingIconThatHides({
    @required this.isOpen,
    @required this.isHovering,
  });

  final ValueNotifier<bool> isOpen;
  final ValueNotifier<bool> isHovering;

  @override
  _RotatingIconThatHidesState createState() => _RotatingIconThatHidesState();
}

class _RotatingIconThatHidesState extends State<RotatingIconThatHides> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.isOpen.addListener(updateState);
    widget.isHovering.addListener(updateState);
  }

  @override
  void dispose() {
    widget.isOpen.removeListener(updateState);
    widget.isHovering.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isOpen = widget.isOpen.value;
    bool isHovering = widget.isHovering.value;
    return AnimatedOpacity(
      duration: kTabScrollDuration,
      opacity: (isOpen && isHovering == false) ? 0 : 1,
      child: RotatingIcon(
        isOpen: widget.isOpen,
      ),
    );
  }
}

class RotatingIcon extends StatelessWidget {
  RotatingIcon({
    this.color: Colors.black,
    @required this.isOpen,
  });

  //passed params
  final Color color;
  final ValueNotifier<bool> isOpen;

  static IconData isOpenedIcon = PortfolioIcons.keyboard_arrow_up;
  static IconData isClosedIcon = PortfolioIcons.keyboard_arrow_down;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: isOpen,
      builder: (BuildContext context, Widget child) {
        return Icon(
          isOpen.value ? isOpenedIcon : isClosedIcon,
        );
      },
    );
  }
}
