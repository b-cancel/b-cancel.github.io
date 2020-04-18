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

/*
class DrawerScaffold extends StatefulWidget{
  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> menuIsExpanded = new ValueNotifier(false);
  AnimationController buttonController;

  //init
  @override
  void initState() {
    //super init
    super.initState();
    
    //Scaffold.of(context).openDrawer();

    //animated icon
    buttonController = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
      reverseDuration: kTabScrollDuration,
    );
  }

  //dipose
  @override
  void dispose() {
    //animated icon
    buttonController.dispose();

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );

    IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: buttonController,
              semanticLabel: 'show menu',
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();

              //toggleMenu();
              setState(() {
                menuIsExpanded ? buttonController.forward() : buttonController.reverse();
                menuIsExpanded = !menuIsExpanded;
              });
            },
          ),
  }
}
*/

//widgets
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
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

    //show or hide the to top button
    scrollController.addListener(updateOnTopValue);
  }

  //dipose
  @override
  void dispose() {
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

    //create the stack
    Stack theStack = Stack(
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
    );

    //build
    return Scaffold(
        backgroundColor: MyApp.bodyColor,
        //dont let the drawer open with sliding
        //it will mess with the beutiful animated icons
        drawerEdgeDragWidth: 0,
        //drawer on the right
        endDrawer: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: List.generate(
            regions.length, 
            (index){
              Region thisRegion = regions[index];
              return ListTile(
                onTap: (){
                  //close
                  Navigator.of(context).pop();
                },
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
        body: theStack,
      );

    /*
    Material(
                color: Colors.transparent,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: List.generate(
                    regions.length, 
                    (index){
                      Region thisRegion = regions[index];
                      return ListTile(
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
    */

    
  }
}
