import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:portfolio/main.dart';

class SplitScreenView extends StatelessWidget {
  SplitScreenView({
    @required this.items,
    @required this.largestItem,
  });

  final List<SplitScreenItem> items;
  final Widget largestItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //since the other bit of right spacing is applied to the item individually
      padding: EdgeInsets.only(
        right: 24,
      ),
      child: Stack(
        children: <Widget>[
          /*
          Transform(
            transform: Matrix4Transform().flipVertically().matrix4,
            child: SplitScreenItems(
              items: items,
              largestItem: largestItem,
              makeInvisible: true,
            ),
          ),
          */
          SplitScreenItems(
            items: items,
            largestItem: largestItem,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: MyApp.bodyColor,
              width: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class SplitScreenItems extends StatelessWidget {
  SplitScreenItems({
    @required this.items,
    @required this.largestItem,
    this.makeInvisible: false,
  });

  final List<SplitScreenItem> items;
  final Widget largestItem;
  final bool makeInvisible;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = new List<Widget>(items.length);
    for (int i = 0; i < items.length; i++) {
      widgets[i] = Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          largestItem,
          Positioned.fill(
            child: Container(
              alignment: Alignment.topLeft,
              child: ASplitScreenItem(
                splitScreenItem: items[i],
                makeInvisible: makeInvisible,
              ),
            ),
          ),
        ],
      );
    }

    return Wrap(
      alignment: WrapAlignment.start,
      children: widgets,
    );
  }
}

class SplitScreenItem {
  final Widget expandingWidget;
  final Widget widgetOnRight;

  SplitScreenItem(this.expandingWidget, {this.widgetOnRight});
}

class ASplitScreenItem extends StatelessWidget {
  const ASplitScreenItem({
    Key key,
    this.collapse: false,
    this.makeInvisible: false,
    @required this.splitScreenItem,
  }) : super(key: key);

  final bool collapse;
  final bool makeInvisible;
  final SplitScreenItem splitScreenItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: Opacity(
        opacity: makeInvisible ? 0 : 1,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            bottom: 12,
            right: splitScreenItem.widgetOnRight == null ? 16 : 0,
          ),
          child: Row(
            mainAxisSize: collapse ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: collapse
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: DefaultTextStyle(
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                    ),
                    child: splitScreenItem.expandingWidget,
                  ),
                ),
              ),
              Visibility(
                visible: splitScreenItem.widgetOnRight != null,
                child: splitScreenItem.widgetOnRight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
