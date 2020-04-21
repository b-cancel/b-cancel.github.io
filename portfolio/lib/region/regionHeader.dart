//flutter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  }) : super(key: key);

  final ValueNotifier<bool> regionOpened;
  final String title;
  final Color titleColor;

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
                      child: Ternary(
                        condition: widget.regionOpened.value,
                        isTrue: TitlePortion(
                          title: widget.title,
                          titleColor: widget.titleColor,
                        ),
                        isFalse: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Container(
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
                                  style: GoogleFonts.robotoMono(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
  }) : super(key: key);

  final String title;
  final Color titleColor;

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
          style: GoogleFonts.robotoMono(
            color: MyApp.oldGrey,
          ),
        ),
      ),
      Flexible(
        child: Text(
          "\"" + title + "\"",
          style: GoogleFonts.robotoMono(
            color: titleColor,
            fontSize: MyApp.h1,
          ),
        ),
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