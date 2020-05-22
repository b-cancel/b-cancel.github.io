//once the picture is loaded, keep it loaded
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

class UndyingListItem extends StatefulWidget {
  const UndyingListItem({
    Key key,
    @required this.index,
    @required this.imageUrls,
    @required this.controller,
  }) : super(key: key);

  final int index;
  final List<String> imageUrls;
  final ScrollController controller;

  @override
  _UndyingListItemState createState() => _UndyingListItemState();
}

class _UndyingListItemState extends State<UndyingListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //fixing must call super problem
    //https://dart.dev/tools/diagnostic-messages#must_call_super
    super.build(context);

    //actual build
    return DyingListItem(
      index: widget.index,
      imageUrls: widget.imageUrls,
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DyingListItem extends StatelessWidget {
  const DyingListItem({
    Key key,
    @required this.index,
    @required this.imageUrls,
    @required this.controller,
  }) : super(key: key);

  final int index;
  final List<String> imageUrls;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                accentColor: MyApp.highlightGreen,
              ),
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.black,
              ),
            ),
          ),
        ),
        Image.network(
          imageUrls[index],
          fit: BoxFit.contain,
          /*
          filterQuality: FilterQuality.low,
          cacheHeight: galleryHeight.toInt(),
          height: galleryHeight,
          */
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierLabel: "Image Swiper",
                  barrierColor: Colors.black12.withOpacity(0.6),
                  barrierDismissible: true,
                  /*
                  Animation<double>, Animation<double>, Widget) transitionBuilder, 
                  bool useRootNavigator, 
                  RouteSettings routeSettings
                  */
                  transitionDuration: kTabScrollDuration,
                  pageBuilder: (
                    BuildContext context,
                    Animation<double> primaryAnimation,
                    Animation<double> secondaryAnimation,
                  ) {
                    // your widget implementation
                    return FadeTransition(
                      opacity: primaryAnimation,
                      child: ScaleTransition(
                        scale: primaryAnimation,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: SizedBox.expand(
                              child: Center(
                                child: Text("in center"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
                /*showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(0),
                      child: Material(
                        color: Colors.transparent,
                        child: InvisibleInkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.contain,
                                gaplessPlayback: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );*/
              },
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}
