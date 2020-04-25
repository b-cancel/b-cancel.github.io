//dart
import 'dart:math';

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:gesture_zoom_box/gesture_zoom_box.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';
import 'package:portfolio/main.dart';

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
    double galleryHeight = 320.0 - 56 - 56;
    return Stack(
      children: <Widget>[
        Transform.translate(
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
        ),
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GalleryHeader(
                  galleryBorder: galleryBorder,
                  github: github,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({
    Key key,
    @required this.imageUrls,
    @required this.rnd,
  }) : super(key: key);

  final List<String> imageUrls;
  final Random rnd;

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
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
            widget.imageUrls.length,
            (index) {
              //instead of the max of ...47 to avoid any overflow issues
              int random = (widget.rnd).nextInt(2147483646);
              String imageURL =
                  "https://source.unsplash.com/random/" + random.toString();
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
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.black,
                                      padding: EdgeInsets.all(
                                        12,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            GestureZoomBox(
                                              maxScale: 5.0,
                                              doubleTapScale: 2.0,
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              child: Image.network(
                                                imageURL,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.close),
                                                ),
                                              ),
                                            ),
                                          ],
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
            scrollController: scrollController,
            isLeft: true,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: PageScrollButton(
            scrollController: scrollController,
            isLeft: false,
          ),
        ),
      ],
    );
  }
}

class PageScrollButton extends StatelessWidget {
  PageScrollButton({
    @required this.scrollController,
    @required this.isLeft,
  });

  final ScrollController scrollController;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double halfScreenWidth = (screenWidth / 2);
    double leftPadding = 22.0 + 4 + 24 + 16 + 16;
    double rightPadding = 24;
    double slideShowSize = screenWidth - leftPadding - rightPadding;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          right: (isLeft == false) ? 24 : 0,
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
              scrollController.animateTo(
                scrollController.offset +
                    (slideShowSize * ((isLeft) ? -1 : 1)),
                duration: kTabScrollDuration,
                curve: Curves.easeInOut,
              );
            },
            icon: Icon(
              isLeft ? Icons.arrow_left : Icons.arrow_right,
              color: MyApp.highlightGreen,
            ),
          ),
        ),
      ),
    );
  }
}
