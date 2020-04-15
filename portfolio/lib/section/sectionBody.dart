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
    @required this.horizontalSpacing,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;
  final Widget child;
  final bool horizontalSpacing;

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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              color: MyApp.bodyColor,
              child: InkWell(
                onTap: (){
                  widget.sectionOpened.value = !widget.sectionOpened.value;
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 16.0 + 6,
                    right: widget.horizontalSpacing ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: MyApp.oldGrey,
                      ),
                    ),
                  ),
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 16,
                        ),
                        child: widget.child,
                      ),
                    ),
                    Material(
                      color: MyApp.bodyColor,
                      child: InkWell(
                        onTap: () {
                          widget.sectionOpened.value = !widget.sectionOpened.value;
                        },
                        child: Transform.translate(
                          offset: Offset(widget.horizontalSpacing ? -24 : 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 4,
                                width: 16,
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
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
