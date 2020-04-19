import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

//automatically rebuilds when scaling the screen
//which is all I really need it to do
class ScrollBar extends StatefulWidget {
  const ScrollBar({
    Key key,
    @required this.scrollController,
    //updated to handle the position of the scroll to top button on ios
    @required this.overScroll,
    //updated to show and hide the joke
    @required this.topScrolledAway,
    //updated to show or hide the scroll to top button
    @required this.onTop,
  }) : super(key: key);

  final ScrollController scrollController;
  //but the time you change the screen size the overscroll has been solved
  //and even if it isn't this is so rare it not worth the time to repair it
  final ValueNotifier<double> overScroll;
  //none of these are affected by changing screen size
  //since in all cases if the screen size changes it does so from the top
  final ValueNotifier<bool> topScrolledAway;
  final ValueNotifier<bool> onTop;

  @override
  _ScrollBarState createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  //must be updated after the run of build
  final ValueNotifier<double> totalScrollArea = new ValueNotifier<double>(0);
  //with all the extra top padding
  final ValueNotifier<double> extraTopPadding = new ValueNotifier<double>(topIntroHeight);

  //If we scroll down have the scroll up button come up
  updateAfterScroll({bool triggeredByScrolling: true}) {
    if(triggeredByScrolling){
      stopUpdateLoop = true;
    }

    //remove toast when pop up
    //user are scrolling away they aren't interested
    BotToast.cleanAll();

    //grab scroll data
    ScrollPosition position = widget.scrollController.position;

    //update overscroll to have nice animation with the scroll top top button on ios
    double curr = position.pixels ?? 0;
    double min = position.minScrollExtent ?? 0;
    double max = position.maxScrollExtent ?? 0;
    print("?max: " + max.toString());
    widget.overScroll.value = (curr < max) ? 0 : curr - max;

    //Determine whether we are on the top of the scroll area
    if (curr <= min) {
      widget.onTop.value = true;
    } else {
      widget.onTop.value = false;
    }

    //Determine whether how much the top peice is scrolled away
    extraTopPadding.value = (topIntroHeight - curr).clamp(0, topIntroHeight);

    //ease of use variable
    widget.topScrolledAway.value = (extraTopPadding.value.round() == 0);

    //update this (that includes overscroll to set the height scrollbar)
    totalScrollArea.value = max + widget.overScroll.value;
  }

  //Note: we need to wait until the scroll controller is attached to something
  //but even after that the value will change until finally it stablizes
  //I have no idea how to reliable determine this stablization
  //so we will instead simply set state UNTIL the user scrolls
  //no noticible lag (atleast not any that I can avoid given the above)
  //and after they scroll ONCE any potential lag from this loop will go away
  bool stopUpdateLoop = false; //set to true above
  initAfterAttachment(){
    //if the value is usable, use it
    //even if its just until we get the actual value
    if(widget.scrollController.hasClients){
      if(mounted){
        setState(() {});
      }
    }

    //MAYBE the value is usable
    //but we keep looping until the user scrolls
    if(stopUpdateLoop == false){
      WidgetsBinding.instance.addPostFrameCallback((_){
        initAfterAttachment();
      });
    }
  }
  
  @override
  void initState() {
    //super init
    super.initState();

    //init show or hide the scrollbar
    //NOTHING ELSE... we don't care about how big it should be
    initAfterAttachment();

    //add listeners
    widget.scrollController.addListener(updateAfterScroll);
  }

  @override
  void dispose() {
    //remove listeners
    widget.scrollController.removeListener(updateAfterScroll);

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //assume you don't need the scroll bar initially
    double max = 0;
    if(widget.scrollController != null){
      if(widget.scrollController.hasClients){
        print("usable but maybe still not right");
        updateAfterScroll(
          triggeredByScrolling: false,
        );
      }
    }
    print("max: " + totalScrollArea.value.toString());

    //build
    return Visibility(
      //if max is 0
      //the scroll view detected that scrolling isnt needed
      //so don't show the scroll bar
      visible: totalScrollArea.value > 0.0,
      child: RaisedButton(
        onPressed: (){
          
        },
        child: Text("scroll bar here"),
      )
    );
  }
}

/*  
totalScrollArea.removeListener(updateState);
extraTopPadding.removeListener(updateState);
*/

/*
    double totalHeight = MediaQuery.of(context).size.height;
    
    double topBitHeight = 0; //widget.extraTopPadding.value;
    double appBarHeight = 56;
    double usableHeight = totalHeight - topBitHeight - appBarHeight;
    double totalScrollArea = 0; //widget.totalScrollArea.value;

    //NOTE: inside of [usableHeight] should be shown all the scroll area
    //the scroll area is as large as [totalScrollArea]
    //we are trying to get the size of the scroll bar
    //based on the fact that we are at all times seeing [totalHeight] of everything

    //ratio
    //totalHeight             ???
    //-----------       =     ------------
    //totalScrollArea         usableHeight

    double scrollBarHeight = totalHeight/totalScrollArea;
    print("Screen height: " + totalHeight.toString());
    print("Scroll area needed: " + totalScrollArea.toString());
    //print("??? / " + usableHeight.toString());
    //scrollBarHeight = scrollBarHeight * usableHeight;
    */

    /*
    ScrollPosition position = scrollController?.position;
    double max = (position == null) ? 0 : position.maxScrollExtent;
    
    */
class ScrollBarBackground extends StatelessWidget {
  //build
  @override
  Widget build(BuildContext context) {
    /*
    //orientation
    double totalScrollBarWidth = 48;
    */
    return Container(
      
    );

    /*
    Container(
        width: totalScrollBarWidth,
        height: totalHeight,
        padding: EdgeInsets.only(
          top: topBitHeight + appBarHeight,
        ),
        child: Material(
          color: Colors.transparent,
          child: InvisibleInkWell(
            onTap: (){},
            //material is 48 by 48 atleast
            //we can fake it and make it 
            //24 and 24 of space that actually also scrolls
            //but for now
            child: Container(
              width: totalScrollBarWidth/2,
              height: usableHeight,
              margin: EdgeInsets.only(
                left: totalScrollBarWidth/2,
              ),
              decoration: BoxDecoration(
                color: MyApp.bodyColor,
                border: Border(
                  left: BorderSide(
                    color: MyApp.oldGrey,
                    width: 2,
                  ),
                ),
              ),
              alignment: Alignment.topCenter,
              child: Container(
                height: scrollBarHeight,
                width: totalScrollBarWidth/2,
                color: Colors.red, //MyApp.scrollBarColor,
              ),
            ),
          ),
        ),
      ),
    */
  }
}