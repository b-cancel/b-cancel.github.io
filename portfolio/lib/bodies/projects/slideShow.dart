//dart
import 'dart:math';

//flutter
import 'package:flutter/material.dart';

//plugin
//import 'package:photo_view/photo_view.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

//widget
class Slideshow extends StatelessWidget {
  const Slideshow({
    Key key,
    @required this.galleryBorder,
    @required this.imageUrls,
    @required this.github,
  }) : super(key: key);

  final BorderSide galleryBorder;
  final List<String> imageUrls;
  final String github;

  @override
  Widget build(BuildContext context) {
    Random rnd = new Random();
    //minus app bar and the sticky header
    double galleryHeight = 320.0; // - 56 - 56;
    return Stack(
      children: <Widget>[
        /*Transform.translate(
          offset: Offset(
            -16.0 - 16 - 16 - 24,
            0,
          ),
          child: Container(
            height: galleryHeight,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                top: galleryBorder,
                //left: galleryBorder,
                bottom: galleryBorder,
              ),
              //color: MyApp.galleryBackground,
            ),
            child: Column(
              children: <Widget>[
                GalleryHeader(
                  galleryBorder: galleryBorder,
                  github: github,
                  invisible: true,
                ),
                Spacer(),
              ],
            ),
          ),
        ),*/
        Container(
          height: galleryHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              top: galleryBorder,
              //left: galleryBorder,
              bottom: galleryBorder,
            ),
            //color: MyApp.galleryBackground,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                //must not stretch
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GalleryHeader(
                    galleryBorder: galleryBorder,
                    github: github,
                  ),
                  //MUST be wrapped in an expanded
                  //to give the list view a proper height
                  Expanded(
                    child: PhotoGallery(
                      imageUrls: imageUrls,
                      rnd: rnd,
                    ),
                  ),
                ],
              ),
              /*
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GalleryHeader(
                  galleryBorder: galleryBorder,
                  github: github,
                ),
              ),
              */
            ],
          ),
        ),
      ],
    );
  }
}

class PhotoGallery extends StatelessWidget {
  PhotoGallery({
    Key key,
    @required this.imageUrls,
    @required this.rnd,
  }) : super(key: key);

  final List<String> imageUrls;
  final Random rnd;

  //scroll controller used throughout
  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          controller: scrollController,
          //shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(0),
          children: List.generate(
            imageUrls.length,
            (index) {
              //instead of the max of ...47 to avoid any overflow issues
              /*
              int random = (rnd).nextInt(2147483646);
              String imageURL =
                  "https://source.unsplash.com/random/" + random.toString();
                */
              String imageURL = imageUrls[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 12.0,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Stack(
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
                        imageURL,
                        fit: BoxFit.contain,
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialog(
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
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Image.network(
                                              imageURL,
                                              fit: BoxFit.contain,
                                              gaplessPlayback: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: PageScrollButton(
            initiallyShown: false,
            scrollController: scrollController,
            isLeft: true,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: PageScrollButton(
            initiallyShown: false,
            scrollController: scrollController,
            isLeft: false,
          ),
        ),
      ],
    );
  }
}

class PageScrollButton extends StatefulWidget {
  PageScrollButton({
    @required this.scrollController,
    @required this.isLeft,
    this.initiallyShown: true,
  });

  final ScrollController scrollController;
  final bool isLeft;
  final bool initiallyShown;

  @override
  _PageScrollButtonState createState() => _PageScrollButtonState();
}

class _PageScrollButtonState extends State<PageScrollButton> {
  final ValueNotifier<bool> buttonShown = new ValueNotifier(false);

  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  updateButtonShown() {
    //grab scroll data
    ScrollPosition position = widget.scrollController.position;

    //cover null cases (which do happen at the start)
    double curr = position.pixels ?? 0;
    double min = position.minScrollExtent ?? 0;
    double max = position.maxScrollExtent ?? 0;
    double overScroll = (curr < max) ? 0 : curr - max;

    //Determine whether we are on the top of the scroll area
    if ((max + overScroll) == 0) {
      buttonShown.value = false;
    } else {
      if (widget.isLeft) {
        buttonShown.value = (curr > min);
      } else {
        buttonShown.value = (curr < max);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    buttonShown.value = widget.initiallyShown;
    widget.scrollController.addListener(updateButtonShown);
    buttonShown.addListener(updateState);
  }

  @override
  void dispose() {
    buttonShown.removeListener(updateState);
    widget.scrollController.removeListener(updateButtonShown);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double halfScreenWidth = (screenWidth / 2);
    double leftPadding = 22.0 + 4; // + 24 + 16 + 16;
    double rightPadding = 24;
    double slideShowSize = screenWidth - leftPadding - rightPadding;

    return Visibility(
      visible: buttonShown.value,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      maintainInteractivity: false,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: (widget.isLeft) ? 24 : 0,
            right: (widget.isLeft == false) ? 24 : 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(
                0.25,
              ),
            ),
            child: IconButton(
              onPressed: () {
                widget.scrollController.animateTo(
                  widget.scrollController.offset +
                      (slideShowSize * ((widget.isLeft) ? -1 : 1)),
                  duration: kTabScrollDuration,
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(
                widget.isLeft ? Icons.arrow_left : Icons.arrow_right,
                color: MyApp.highlightGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
