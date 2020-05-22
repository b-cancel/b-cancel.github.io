//once the picture is loaded, keep it loaded
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';

//plugin
import 'package:carousel_slider/carousel_slider.dart';

//widget
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
                normalFullScreenDialog(
                  context,
                  imageUrls: imageUrls,
                  initalIndex: index,
                );
              },
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }

  //smallest button size 36
  //mini FAB 40
  //text FAB 48
  //FAB 56
  normalFullScreenDialog(
    BuildContext context, {
      @required List<String> imageUrls,
      @required int initalIndex,
      double horizontalPadding: 36,
  }) {
    double maxWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: SizedBox.expand(
                child: MyImageSlider(
                  maxImageWidth: maxWidth - (horizontalPadding * 2),
                  imageUrls: imageUrls,
                  initialIndex: initalIndex,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyImageSlider extends StatefulWidget {
  const MyImageSlider({
    @required this.maxImageWidth,
    @required this.imageUrls,
    @required this.initialIndex,
    Key key,
  }) : super(key: key);

  final double maxImageWidth;
  final List<String> imageUrls;
  final int initialIndex;

  @override
  _MyImageSliderState createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.imageUrls.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/44665955/how-do-i-determine-the-width-and-height-of-an-image-in-flutter

    //build
    /*
    return Center(
      child: Container(
        width: maxImageWidth,
        height: MediaQuery.of(context).size.height,
        color: Colors.red,
      ),
    );
    */

    return CarouselSlider.builder(
      options: CarouselOptions(
        //pageViewKey: PageStorageKey('carousel_slider'),
        /*
        onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }
        */
      ),
      carouselController: controller,
      itemCount: widget.imageUrls.length,
      itemBuilder: (BuildContext context, int index){
        /*
        return Container(
              child: Center(
                child: Image.network(images[index], fit: BoxFit.cover, width: 1000)
              ),
            );
        */
        return Container(
          child: Center(
            child: Text(widget.imageUrls[index].toString())
          ),
          color: Colors.green,
        );
      },
    );

    /*
    Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.previousPage(),
                    child: Text('←'),
                  ),
                ),
                Flexible(
                  child: RaisedButton(
                    onPressed: () => _controller.nextPage(),
                    child: Text('→'),
                  ),
                ),
                ...Iterable<int>.generate(imgList.length).map(
                  (int pageIndex) => Flexible(
                    child: RaisedButton(
                      onPressed: () => _controller.animateToPage(pageIndex),
                      child: Text("$pageIndex"),
                    ),
                  ),
                ),
              ],
            )
    */
  }
}

/*
Container(
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
*/