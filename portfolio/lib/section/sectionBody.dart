//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';

//widget
class SectionBody extends StatefulWidget {
  const SectionBody({
    Key key,
    @required this.sectionType,
    @required this.sectionOpened,
    @required this.child,
    @required this.leftSpacing,
  }) : super(key: key);

  final SectionType sectionType;
  final ValueNotifier<bool> sectionOpened;
  final Widget child;
  final bool leftSpacing;

  @override
  _SectionBodyState createState() => _SectionBodyState();
}

class _SectionBodyState extends State<SectionBody> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.sectionOpened.addListener(updateState);
  }

  @override
  void dispose() {
    widget.sectionOpened.addListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.sectionOpened.value,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Material(
                    color: MyApp.bodyColor,
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        widget.sectionOpened.value =
                            !widget.sectionOpened.value;
                      },
                      child: Container(
                        color: sectionTypeToColor[widget.sectionType], 
                        margin: EdgeInsets.only(
                          right: widget.leftSpacing ? 22 : 0,
                        ),
                        width: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: widget.child,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            EndSectionCloseButton(
              sectionOpened: widget.sectionOpened,
              end: Text(
                sectionTypeToRight[widget.sectionType],
                style: TextStyle(
                  color: MyApp.oldGrey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndSectionCloseButton extends StatelessWidget {
  const EndSectionCloseButton({
    @required this.sectionOpened,
    @required this.end,
    Key key,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;
  final Widget end;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyApp.bodyColor,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          sectionOpened.value = !sectionOpened.value;
        },
        child: end,
      ),
    );
  }
}
