//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/toggler.dart';
import 'package:portfolio/main.dart';

//widget
class RegionHeader extends StatefulWidget {
  const RegionHeader({
    Key key,
    @required this.regionOpened,
    @required this.title,
    @required this.titleColor,
    this.fontSize: MyApp.h2,
  }) : super(key: key);

  final ValueNotifier<bool> regionOpened;
  final String title;
  final Color titleColor;
  final double fontSize;

  @override
  _RegionHeaderState createState() => _RegionHeaderState();
}

class _RegionHeaderState extends State<RegionHeader> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.regionOpened.addListener(updateState);
  }

  @override
  void dispose() {
    widget.regionOpened.addListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyApp.bodyColor,
      child: InkWell(
        onTap: () {
          widget.regionOpened.value = !widget.regionOpened.value;
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 8.0,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ToggleButton(
                  sectionOpened: widget.regionOpened,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 4,
                          color: widget.regionOpened.value
                              ? widget.titleColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      right: 16.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 28.0,
                        ),
                        child: Ternary(
                          condition: widget.regionOpened.value,
                          isTrue: TitlePortion(
                            title: widget.title,
                            titleColor: widget.titleColor,
                            fontSize: widget.fontSize,
                          ),
                          isFalse: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: widget.fontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
    @required this.title,
    @required this.titleColor,
    @required this.fontSize,
  }) : super(key: key);

  final String title;
  final Color titleColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    //widgets to be reused
    List<Widget> regionAndTitle = [
      Padding(
        padding: EdgeInsets.only(
          right: 8,
          bottom: 6,
        ),
        child: Text(
          "#region",
          style: TextStyle(
            color: MyApp.oldGrey,
          ),
        ),
      ),
      Text(
        "\"" + title + "\"",
        style: TextStyle(
          color: titleColor,
          fontSize: fontSize,
        ),
      ),
    ];

    //change slightly depending on mode
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: regionAndTitle,
    );
  }
}

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    @required this.sectionOpened,
    Key key,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Visibility(
              visible: sectionOpened.value,
              child: Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Expanded(
                      child: Container(
                        color: MyApp.oldGrey,
                        width: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Toggler(
              sectionOpened: sectionOpened,
              useIconButton: true,
            ),
          ],
        ),
        Expanded(
          child: Visibility(
            visible: sectionOpened.value,
            child: Container(
              margin: EdgeInsets.only(
                left: 22,
              ),
              width: 4,
              color: MyApp.oldGrey,
            ),
          ),
        ),
      ],
    );
  }
}