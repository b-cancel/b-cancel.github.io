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
      padding: EdgeInsets.only(
        right: 48,
      ),
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: animation,
            child: Transform(
              transform: Matrix4Transform().flipVertically().matrix4,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(
                  widget.items.length,
                  (index) {
                    SplitScreenItem theItem = widget.items[index];
                    return Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        widget.largestItem,
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: ASplitScreenItem(
                              splitScreenItem: theItem,
                              makeInvisible: true,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: List.generate(
              widget.items.length,
              (index) {
                SplitScreenItem theItem = widget.items[index];
                return Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    widget.largestItem,
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: ASplitScreenItem(
                          splitScreenItem: theItem,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          //cover up that last split that we don't want to see
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

//right icon
/*
IconWebLink(
                  url: "https://google.com",
                  label: "Recommendation Letter",
                  icon: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        //give red border
                        Icon(
                          FontAwesome5Solid.file_pdf,
                          color: Colors.red,
                          size: 36,
                        ),
                        //make center bit red
                        Padding(
                          //36 total
                          padding: EdgeInsets.only(
                            top: 14.0,
                            bottom: 4.0,
                          ),
                          child: Container(
                            color: Colors.red,
                            height: 18,
                            width: 24,
                          ),
                        ),
                        Icon(
                          FontAwesome5Solid.file_pdf,
                          color: Colors.white,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
*/
/*
[
                        Text(
                          "Ref (",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: ref.name != null,
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    (ref.name ?? "") + ",",
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: ref.title != null,
                                child: Text(
                                  (ref.title ?? "") + ",",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: ref.location != null,
                                child: Text(
                                  (ref.location ?? "") + ",",
                                ),
                              ),
                              Visibility(
                                visible: ref.email != null,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: TextEmailLink(
                                    url: ref.email,
                                    preferDirection: PreferDirection.rightCenter,
                                    text: Text(
                                      (ref.email ?? "") + ",",
                                      style: TextStyle(
                                        color: MyApp.highlightGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: ref.phone != null,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: TextPhoneLink(
                                    url: ref.phone,
                                    preferDirection: PreferDirection.rightCenter,
                                    text: Text(
                                      (ref.phone ?? "") + ",",
                                      style: TextStyle(
                                        color: MyApp.oldOrange,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "),",
                          style: TextStyle(
                            color: MyApp.oldGrey,
                          ),
                        ),
                      ],
*/

class SplitScreenItem{
  final List<Widget> widgetsToExpand;
  final Widget widgetOnRight;

  SplitScreenItem(
    this.widgetsToExpand,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: splitScreenItem.widgetsToExpand,
                    ),
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