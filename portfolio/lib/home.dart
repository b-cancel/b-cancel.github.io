//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

//internal: sections
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/hardSkills.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/softSkills.dart';
import 'package:portfolio/bodies/work.dart';
import 'package:portfolio/region/regions.dart';

//internal: other
import 'package:portfolio/region/sliverRegion.dart';
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/utils/scrollToTop.dart';
import 'package:portfolio/main.dart';

//widgets
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool menuIsExpanded = true;
  AnimationController buttonController;
  final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggleMenu() {
    innerDrawerKey.currentState.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
      direction: InnerDrawerDirection.end,
    );
  }

  //scroll to top function
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);

  //If we scroll down have the scroll up button come up
  updateOnTopValue() {
    ScrollPosition position = scrollController.position;
    //double currentOffset = scrollController.offset;

    //update overscroll to cover pill bottle if possible
    double curr = position.pixels;
    double max = position.maxScrollExtent;
    overScroll.value = (curr < max) ? 0 : curr - max;
    print("max: " + max.toString());

    //Determine whether we are on the top of the scroll area
    if (curr <= position.minScrollExtent) {
      onTop.value = true;
    } else {
      onTop.value = false;
    }

    //remove toast when pop up
    BotToast.cleanAll();
  }

  //init
  @override
  void initState() {
    //super init
    super.initState();

    //animated icon
    buttonController = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
      reverseDuration: kTabScrollDuration,
    );

    //show or hide the to top button
    scrollController.addListener(updateOnTopValue);
  }

  //dipose
  @override
  void dispose() {
    //animated icon
    buttonController.dispose();

    //remove listener
    scrollController.removeListener(updateOnTopValue);

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sliverSections = [
      TopIntro(),
      SliverAppBar(
        pinned: true,
        backgroundColor: MyApp.inactiveTabColor,
        title: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: MyApp.h1,
          ),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(3, 0),
                child: Text(
                  "Bryan_Cancel",
                  style: TextStyle(
                    color: MyApp.highlightPink,
                  ),
                ),
              ),
              Text(
                "Bryan_Cancel",
                style: TextStyle(
                  color: MyApp.highlightGreen,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: buttonController,
              semanticLabel: 'show menu',
            ),
            onPressed: () {
              toggleMenu();
              setState(() {
                menuIsExpanded ? buttonController.forward() : buttonController.reverse();
                menuIsExpanded = !menuIsExpanded;
              });
            },
          ),
        ],
      ),
      BottomIntro(),
    ];

    //add all the regions
    sliverSections.addAll(
      List.generate(
        regions.length, 
        (index){
          Region thisRegion = regions[index];
          return SliverRegion(
            title: thisRegion.title, 
            body: thisRegion.body,
            initiallyOpened: thisRegion.initiallyOpened,
          );
        }
      ),
    );

    //add last 2 bottom bits
    sliverSections.addAll([
      RightBottom(),
      FillRemaining(),
    ].toList());

    //build
    return InnerDrawer(
      key: innerDrawerKey,

      //drawer itself
      rightChild: Material(
        color: Colors.transparent,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: List.generate(
            regions.length, 
            (index){
              Region thisRegion = regions[index];
              return ListTile(
                
                dense: true,
                title: Text(
                      thisRegion.title,
                    ),
                trailing: Icon(
                  thisRegion.icon,
                ),
              );
            }
          ),
        ),
      ),

      //same duration as icon button
      duration: kTabScrollDuration,

      //we will have horizontal swiping stuff 
      //avoid confusion and complication
      swipe: false,

      //TODO: what does this do?
      onTapClose: true,

      //NOTE: keep the flat look of IDEs
      //boxShadow: new List<BoxShadow>(),

      //adjust to the size of the passed menu
      proportionalChildArea: true,
      
      colorTransition: Colors.black.withOpacity(0.5), // default Color.black54
      //When setting the vertical offset, be sure to use only top or bottom
      offset: IDOffset.horizontal(.1),

      //set the offset in both directions
      //scale: IDOffset.horizontal(1),

      //other
       // default true
      borderRadius: 0, // default 0
      
      backgroundColor: MyApp.headerColor, // default  Theme.of(context).backgroundColor
      //right drawer setting
      rightAnimationType: InnerDrawerAnimation.quadratic,
      
      //when a pointer that is in contact with the screen and moves to the right or left
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        // return values between 1 and 0
        print(val);
        // check if the swipe is to the right or to the left
        print(direction == InnerDrawerDirection.start);
      },
      //TODO: match switch location with animated icon
      innerDrawerCallback: (a) => print(a), 
      //-------------------------*-------------------------
      scaffold: Scaffold(
        backgroundColor: MyApp.bodyColor,
        body: Stack(
          children: <Widget>[
            //section sliver padding
            //22 + 4 + 24
            SafeArea(
              //NOTE: Flutter has 2 options
              //1. ScrollBar (but you cant drag it)
              //2. CupertinoScrollBar (but you cant click to travel)
              child: DraggableScrollbar(
                alwaysVisibleScrollThumb: true,
                backgroundColor: Colors.red,
                heightScrollThumb: 48,
                scrollThumbBuilder: (
                  Color backgroundColor,
                  Animation<double> thumbAnimation,
                  Animation<double> labelAnimation,
                  double height, {
                  BoxConstraints labelConstraints,
                  Text labelText,
                }) {
                  return Container(
                    height: height,
                    width: 20.0,
                    color: backgroundColor,
                  );
                },
                controller: scrollController,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: sliverSections,
                ),
              ),
            ),
            ScrollToTopButton(
              onTop: onTop,
              overScroll: overScroll,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
