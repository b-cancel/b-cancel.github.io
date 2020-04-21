//flutter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//internal
import 'package:portfolio/main.dart';

//widget
class RegionBody extends StatefulWidget {
  const RegionBody({
    Key key,
    @required this.regionOpened,
    @required this.child,
    @required this.leftSpacing,
  }) : super(key: key);

  final ValueNotifier<bool> regionOpened;
  final Widget child;
  final bool leftSpacing;

  @override
  _RegionBodyState createState() => _RegionBodyState();
}

class _RegionBodyState extends State<RegionBody> {
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
    return Visibility(
      visible: widget.regionOpened.value,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
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
              EndRegionCloseButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class EndRegionCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: GoogleFonts.robotoMono(
                color: MyApp.oldGrey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
