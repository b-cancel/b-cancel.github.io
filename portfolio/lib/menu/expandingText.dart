//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/menu/changingText.dart';

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
    //if its open stay open
    if (widget.startOpen == false) {
      isOpen = new ValueNotifier(widget.startOpen);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startOpen) {
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
              SpecialTitle(
                useSpreadingTitle: widget.useSpreadingTitle,
                title: widget.title,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.useSpreadingTitle ? 0 : 16,
                ),
                child: (widget.content ?? Text("content here eventually")),
              ),
            ],
          ),
        ),
      );
    } else {
      return SpreadTitleOnHover(
        title: widget.title,
        content: widget.content,
        useSpreadingTitle: widget.useSpreadingTitle,
        isOpen: isOpen,
      );
    }
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
            SpecialTitle(
              isOpen: widget.isOpen,
              useSpreadingTitle: widget.useSpreadingTitle,
              title: widget.title,
              isHovering: isHovering,
              rotatingArrow: rotatingArrow,
              isSpreaded: isSpreaded,
            ),
            AnimatedBuilder(
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
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: widget.useSpreadingTitle ? 0 : 16,
                          ),
                          child: (widget.content ??
                              Text("content here eventually")),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
