//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/menu/changingText.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//widget
class SwappingSection extends StatefulWidget {
  SwappingSection({
    @required this.title,
    this.startOpen: true,
    this.content,
  });

  final String title;
  final bool startOpen;
  final Widget content;

  @override
  _SwappingSectionState createState() => _SwappingSectionState();
}

class _SwappingSectionState extends State<SwappingSection> {
  ValueNotifier<bool> isOpen;

  @override
  void initState() {
    super.initState();
    if (widget.startOpen == false) {
      isOpen = new ValueNotifier(widget.startOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startOpen) {
      return Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: 0,
              child: Icon(
                Icons.keyboard_arrow_down,
              ),
            ),
            widget.content,
          ],
        ),
      );
    } else {
      return SpreadTitleOnHover(
        title: widget.title,
        content: widget.content,
        isOpen: isOpen,
      );
    }
  }
}

class SpreadTitleOnHover extends StatefulWidget {
  SpreadTitleOnHover({
    @required this.title,
    @required this.isOpen,
    this.content,
  });

  final ValueNotifier isOpen;
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

    //swaps title and content title
    return AnimatedBuilder(
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
              ? PointerOnHover(
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
                          top: 8,
                          bottom: 8.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            rotatingArrow,
                            widget.content,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SpecialTitle(
                  isOpen: widget.isOpen,
                  useSpreadingTitle: false,
                  title: widget.title,
                  isHovering: isHovering,
                  rotatingArrow: rotatingArrow,
                  isSpreaded: isSpreaded,
                ),
        );
      },
    );
  }
}
