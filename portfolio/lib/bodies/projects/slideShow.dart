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
    double galleryWidth = MediaQuery.of(context).size.width; // + 16 + 16;
    print("images: " + imageUrls.length.toString());
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
                    child: ListView(
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(0),
                      children: List.generate(imageUrls.length, (index) {
                        //instead of the max of ...47 to avoid any overflow issues
                        int random = (rnd).nextInt(2147483646);
                        String imageURL =
                            "https://source.unsplash.com/random/" +
                                random.toString();
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: Icon(
                                                                Icons.close),
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
                      }),
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
