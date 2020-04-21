import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:portfolio/main.dart';

class SplitScreenView extends StatefulWidget {
  SplitScreenView({
    @required this.items,
    @required this.largestItem,
  });

  final List<SplitScreenItem> items;
  final Widget largestItem;

  @override
  _SplitScreenViewState createState() => _SplitScreenViewState();
}

//NOTE: this is a very disgusting way of acheiving the desire effect
//all I want to do is to get the items fliped vertically and under the actually clickable elements
//but using flipvertial had a side effect and this fixed it
//it does the job for now
class _SplitScreenViewState extends State<SplitScreenView>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();  

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    Future<void>.delayed(Duration(seconds: 1), () {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    // Don't forget to dispose the animation controller on class destruction
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      //since the other bit of right spacing is applied to the item individually
      padding: EdgeInsets.only(
        right: 24,
      ),
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: animation,
            child: Transform(
              transform: Matrix4Transform().flipVertically().matrix4,
              child: SplitScreenItems(
                items: widget.items,
                largestItem: widget.largestItem,
                makeInvisible: true,
              ),
            ),
          ),
          SplitScreenItems(
            items: widget.items,
            largestItem: widget.largestItem,
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
    return Wrap(
      alignment: WrapAlignment.start,
      children: List.generate(
        items.length,
        (index) {
          SplitScreenItem theItem = items[index];
          return Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              largestItem,
              Positioned.fill(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: ASplitScreenItem(
                    splitScreenItem: theItem,
                    makeInvisible: makeInvisible,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SplitScreenItem{
  final Widget expandingWidget;
  final Widget widgetOnRight;

  SplitScreenItem(
    this.expandingWidget,
    {this.widgetOnRight}
  );
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