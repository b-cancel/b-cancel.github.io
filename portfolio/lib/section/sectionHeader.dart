//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_icons/flutter_icons.dart';
import 'package:portfolio/section/section.dart';

//internal
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/toggler.dart';

//widget
class SectionHeader extends StatefulWidget {
  const SectionHeader({
    Key key,
    @required this.sectionType,
    @required this.sectionOpened,
    @required this.label,
    @required this.title,
  }) : super(key: key);

  final SectionType sectionType;
  final ValueNotifier<bool> sectionOpened;
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
    return Material(
      color: MyApp.bodyColor,
      child: InkWell(
        onTap: () {
          widget.sectionOpened.value = !widget.sectionOpened.value;
        },
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(
            top: 8.0,
          ),
          child: TitlePortion(
            sectionOpened: widget.sectionOpened,
            label: widget.label, 
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: <Widget>[
                Text(
                  widget.title + " ",
                  style: TextStyle(
                    fontSize: 24,
                    color: sectionTypeToColor[widget.sectionType],
                    fontWeight: FontWeight.bold,
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
                            "..." + 
                            sectionTypeToRight[widget.sectionType]
                          )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitlePortion extends StatelessWidget {
  const TitlePortion({
    Key key,
    @required this.label,
    @required this.title,
    @required this.sectionOpened,
  }) : super(key: key);

  final String label;
  final Widget title;
  final ValueNotifier<bool> sectionOpened;

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
            Container(
              width: 24,
              height: 24,
              child: Toggler(
                sectionOpened: sectionOpened,
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
      Flexible(
        child: title,
      ),
    ];

    //change slightly depending on mode
    Size size = MediaQuery.of(context).size;
    bool isPortrait = size.height > size.width;
    if (isPortrait) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: regionAndTitle,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: regionAndTitle,
      );
    }
  }
}