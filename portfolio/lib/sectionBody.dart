//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/main.dart';

//widget
class SectionBody extends StatefulWidget {
  const SectionBody({
    Key key,
    @required this.sectionOpened,
    @required this.child,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;
  final Widget child;

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
        margin: EdgeInsets.only(
          left: 16.0 + 6,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 4,
              color: MyApp.oldGrey,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                //NOTE: horizontal applied manually for the slideshows sake
              ),
              child: widget.child,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 4,
                  width: 8,
                  color: MyApp.oldGrey,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                  ),
                  child: Text(
                    "#endregion",
                    style: TextStyle(
                      color: MyApp.oldGrey,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}