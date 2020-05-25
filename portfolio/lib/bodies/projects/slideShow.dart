//dart
import 'dart:math';

//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';
import 'package:portfolio/bodies/projects/slideShowItem.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/keepAliveMixin.dart';

//widget
class Slideshow extends StatelessWidget {
  const Slideshow({
    Key key,
    @required this.galleryBorder,
    @required this.isGithub,
    @required this.imageUrls,
    @required this.topLink,
  }) : super(key: key);

  final BorderSide galleryBorder;
  final bool isGithub;
  final List<String> imageUrls;
  final String topLink;

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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: topLink != null,
                    child: GalleryHeader(
                      galleryBorder: galleryBorder,
                      isGithub: isGithub,
                      topLink: topLink ?? "",
                    ),
                  ),
                  //MUST be wrapped in an expanded
                  //to give the list view a proper height
                  Container(
                    height: galleryHeight,
                    child: PhotoGallery(
                      galleryHeight: galleryHeight,
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
    @required this.galleryHeight,
  }) : super(key: key);

  final List<String> imageUrls;
  final Random rnd;
  final double galleryHeight;

  //scroll controller used throughout
  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.separated(
          //used to show buttons
          controller: scrollController,
          //you see the best of each project even when you resume is viewable
          scrollDirection: Axis.horizontal,
          //most important items on the left
          reverse: false,
          //the mobile looking scrim shouldn't viewable
          //it should work like a website
          //different scroll physics to choose from
          //-----*-----*-----*-----*-----
          //has visible scrim
          //ClampingScrollPhysics() ANDROID
          //bounce physics like IOS
          //BouncingScrollPhysics() IOS
          //obvi not what we want
          //NeverScrollableScrollPhysics()
          //basically the same as above
          //FixedExtentScrollPhysics()
          //same as android
          //PageScrollPhysics()
          //physics: BouncingScrollPhysics(),
          //When this is true, the scroll view is scrollable
          //even if it does not have sufficient content to actually scroll
          primary: false,
          //shrink wrapping is more expensive and provides no benefit in this use case
          shrinkWrap: false,

          //wrap values in keep alives
          addAutomaticKeepAlives: true,

          //If the children are easy to repaint 
          //it might be more efficient to not add a repaint boundary 
          //and simply repaint the children during scrolling
          //BUT our children are most gifs and not simple
          addRepaintBoundaries: true,

          //Typically, children in a scrolling container 
          //must be annotated with a semantic index in order to generate 
          //the correct accessibility announcements
          //addSemanticIndexes: true,

          //automatic dismisskeyboard on drag
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          //only on the outside
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          //create all image links in one hit
          itemCount: imageUrls.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(width: 8);
          },
          itemBuilder: (context, index) {
            //add addAutomaticKeepAlives should wrap this in an keep alive
            //the mixing combines with the above
            return KeepAliveMixin(
              child: SlideShowItem(
                index: index,
                imageUrls: imageUrls,
                controller: scrollController,
              ),
            );
          },
          //so scrolling left and right with a finger keeps things in view
          //cacheExtent: MyApp.screenWidth,
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
                widget.isLeft ? PortfolioIcons.left_dir : PortfolioIcons.right_dir,
                color: MyApp.highlightGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
