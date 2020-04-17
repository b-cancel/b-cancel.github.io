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
    @required this.leftSpacing,
  }) : super(key: key);

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
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Material(
              color: MyApp.bodyColor,
              child: GestureDetector(
                onTap: (){
                  widget.sectionOpened.value = !widget.sectionOpened.value;
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 16.0 + 6,
                    right: widget.leftSpacing ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 26.0 + (widget.leftSpacing ? 24 : 0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: widget.child,
                ),
              ),
              EndRegionCloseButton(
                sectionOpened: widget.sectionOpened,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EndRegionCloseButton extends StatelessWidget {
  const EndRegionCloseButton({
    @required this.sectionOpened,
    Key key,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyApp.bodyColor,
      child: GestureDetector(
        onTap: () {
          sectionOpened.value = !sectionOpened.value;
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0 + 6,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: MyApp.oldGrey,
                      width: 4,
                    ),
                    left: BorderSide(
                      color: MyApp.oldGrey,
                      width: 4,
                    ),
                  ),
                ),
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
    );
  }
}
