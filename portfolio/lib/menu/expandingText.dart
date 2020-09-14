//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/utils/conditional.dart';

//internal
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/main.dart';

//widget
class ExpandingSection extends StatefulWidget {
  ExpandingSection({
    @required this.title,
    this.useSpreadingTitle: false,
    this.content,
    this.startOpen: true,
  });

  final String title;
  final Widget content;
  final bool startOpen;
  final bool useSpreadingTitle;

  @override
  _ExpandingSectionState createState() => _ExpandingSectionState();
}

class _ExpandingSectionState extends State<ExpandingSection> {
  ValueNotifier<bool> isOpen;

  @override
  void initState() {
    super.initState();
    isOpen = new ValueNotifier(widget.startOpen);
  }

  @override
  Widget build(BuildContext context) {
    return SpreadTitleOnHover(
      title: widget.title,
      content: widget.content,
      useSpreadingTitle: widget.useSpreadingTitle,
      isOpen: isOpen,
    );
  }
}

class SpreadTitleOnHover extends StatefulWidget {
  SpreadTitleOnHover({
    @required this.title,
    @required this.isOpen,
    @required this.useSpreadingTitle,
    this.content,
  });

  final ValueNotifier isOpen;
  final bool useSpreadingTitle;
  final String title;
  final Widget content;

  @override
  _SpreadTitleOnHoverState createState() => _SpreadTitleOnHoverState();
}

class _SpreadTitleOnHoverState extends State<SpreadTitleOnHover> {
  final ValueNotifier<bool> isHovering = new ValueNotifier<bool>(false);
  ValueNotifier<bool> isSpreaded;

  bool shouldBeSpreaded() {
    if (widget.isOpen.value) {
      return (isHovering.value == false);
    } else {
      return (isHovering.value);
    }
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
    widget.isOpen.addListener(updateSpreaded);
    isHovering.addListener(updateSpreaded);
  }

  @override
  void dispose() {
    widget.isOpen.removeListener(updateSpreaded);
    isHovering.removeListener(updateSpreaded);

    //super dipose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget rotatingArrow = RotatingIconThatHides(
      isOpen: widget.isOpen,
      isHovering: isHovering,
    );
    return Container(
      padding: EdgeInsets.only(
        right: widget.useSpreadingTitle ? 16 : 0,
        left: widget.useSpreadingTitle ? 16 : 0,
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PointerOnHover(
              isHovering: isHovering,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  hoverColor: Colors.transparent,
                  //toggle
                  onTap: () {
                    widget.isOpen.value = !widget.isOpen.value;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: widget.useSpreadingTitle ? 16 : 8,
                      bottom: 8.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Visibility(
                          visible: widget.useSpreadingTitle == false,
                          child: rotatingArrow,
                        ),
                        Ternary(
                          condition: widget.useSpreadingTitle,
                          isTrue: SpreadingTitle(
                            title: widget.title,
                            spreaded: isSpreaded,
                          ),
                          isFalse: BoldingTitle(
                            title: widget.title,
                            bolded: isSpreaded,
                          ),
                        ),
                        Visibility(
                          visible: widget.useSpreadingTitle,
                          child: rotatingArrow,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: widget.useSpreadingTitle ? 0 : 16,
              ),
              child: AnimatedBuilder(
                animation: widget.isOpen,
                builder: (context, child) {
                  return AnimatedSwitcher(
                    duration: kTabScrollDuration,
                    transitionBuilder: (widget, animation) {
                      return SizeTransition(
                        child: widget,
                        sizeFactor: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                      );
                    },
                    child: (widget.isOpen.value)
                        ? (widget.content ?? Text("content here eventually"))
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                  );
                },
              ),
            ),
          ],
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
