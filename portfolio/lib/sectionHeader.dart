//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/conditional.dart';
import 'package:portfolio/main.dart';

//widget
class SectionHeader extends StatefulWidget {
  const SectionHeader({
    Key key,
    @required this.sectionOpened,
    @required this.title,
    @required this.titleColor,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;
  final String title;
  final Color titleColor;

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
    return Container(
      color: MyApp.bodyColor,
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: [
              Visibility(
                visible: widget.sectionOpened.value,
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
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyApp.bodyColor,
                      border: Border.all(
                        width: 2,
                        color: MyApp.oldGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: widget.sectionOpened.value == false
                      ? Icon(
                          Icons.add,
                          color: MyApp.oldGrey,
                        )
                      : Icon(
                          FontAwesome.minus,
                          size: 14,
                          color: MyApp.oldGrey,
                        ),
                  onPressed: () {
                    widget.sectionOpened.value = !widget.sectionOpened.value;
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: widget.sectionOpened.value
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
                child: widget.sectionOpened.value ?
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        child: Text(
                          "#region",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                            height: 1,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: widget.titleColor,
                            fontSize: 36,
                            height: 1,
                          ),
                        )
                      ),
                    ],
                  ) : Row(
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
                            style: TextStyle(
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
        ],
      ),
    );
  }
}
