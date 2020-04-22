//flutter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//plugin
import 'package:portfolio/section/section.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/toggler.dart';

//widget
class SectionHeader extends StatefulWidget {
  const SectionHeader({
    Key key,
    @required this.sectionType,
    @required this.sectionOpened,
    @required this.collapsible,
    @required this.label,
    @required this.title,
  }) : super(key: key);

  final SectionType sectionType;
  final ValueNotifier<bool> sectionOpened;
  final bool collapsible;
  final String label;
  final String title;

  @override
  _SectionHeaderState createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
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
    Widget header = Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: TitlePortion(
        collapsible: widget.collapsible,
        sectionOpened: widget.sectionOpened,
        label: widget.label,
        title: DefaultTextStyle(
          style: GoogleFonts.robotoMono(),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: <Widget>[
              Visibility(
                visible: widget.title != null && widget.title != "",
                child: Text(
                  widget.title + " ",
                  style: TextStyle(
                    fontSize: 24,
                    color: sectionTypeToColor[widget.sectionType],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 4,
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: MyApp.oldGrey,
                    fontSize: 18,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "= " + sectionTypeToLeft[widget.sectionType],
                      ),
                      Visibility(
                        visible: widget.sectionOpened.value == false,
                        child: Text(
                          "..." + sectionTypeToRight[widget.sectionType],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    //make a button or not
    if (widget.collapsible) {
      return Material(
        color: MyApp.bodyColor,
        child: InkWell(
          onTap: () {
            print("printed");
            widget.sectionOpened.value = !widget.sectionOpened.value;
          },
          child: header,
        ),
      );
    } else {
      return header;
    }
  }
}

class TitlePortion extends StatelessWidget {
  const TitlePortion({
    Key key,
    @required this.label,
    @required this.title,
    @required this.sectionOpened,
    @required this.collapsible,
  }) : super(key: key);

  final String label;
  final Widget title;
  final ValueNotifier<bool> sectionOpened;
  final bool collapsible;

  @override
  Widget build(BuildContext context) {
    //widgets to be reused
    List<Widget> regionAndTitle = [
      Padding(
        padding: EdgeInsets.only(
          bottom: 4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Visibility(
              visible: collapsible,
              child: Container(
                width: 24,
                height: 24,
                child: Toggler(
                  sectionOpened: sectionOpened,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: MyApp.oldGrey,
                ),
              ),
            ),
          ],
        ),
      ),
      title,
    ];

    //change slightly depending on mode
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: regionAndTitle,
    );
  }
}
