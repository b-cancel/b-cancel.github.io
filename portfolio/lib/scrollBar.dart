import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

class ScrollBar extends StatefulWidget {
  const ScrollBar({
    Key key,
    @required this.scrollController,
    @required this.topScrolledAway,
    @required this.overScroll,
    @required this.onTop,
  }) : super(key: key);

  final ScrollController scrollController;
  final ValueNotifier<bool> topScrolledAway;
  final ValueNotifier<double> overScroll;
  final ValueNotifier<bool> onTop;
  

  @override
  _ScrollBarState createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  //must be updated after the run of build
  final ValueNotifier<double> totalScrollArea = new ValueNotifier<double>(0);
  //with all the extra top padding
  final ValueNotifier<double> extraTopPadding = new ValueNotifier<double>(topIntroHeight);
  

  /*
  //If we scroll down have the scroll up button come up
  updateAfterScroll() {
    haveScrolled = true;
    ScrollPosition position = scrollController.position;

    //update overscroll to cover pill bottle if possible
    double curr = position.pixels;
    double max = position.maxScrollExtent;
    overScroll.value = (curr < max) ? 0 : curr - max;

    //Determine whether we are on the top of the scroll area
    if (curr <= position.minScrollExtent) {
      onTop.value = true;
    } else {
      onTop.value = false;
    }

    //Determine whether how much the top peice is scrolled away
    extraTopPadding.value = (topIntroHeight - curr).clamp(0, topIntroHeight);

    //ease of use variable
    topScrolledAway.value = (extraTopPadding.value.round() == 0);

    //update this (that includes overscroll to set the height scrollbar)
    totalScrollArea.value = max + overScroll.value;

    //remove toast when pop up
    BotToast.cleanAll();
  }

  updateWithoutScroll(){
    ScrollPosition position = scrollController.position;
    double max = position.maxScrollExtent;
    totalScrollArea.value = max;
  }
  */

  /*
  //wait till the scroll controller is attached to make the first update of the scroll bar
  initScrollAfterAttach(){
    if(scrollController.hasClients){
      updateScrollUntilStablize();
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_){
        initScrollAfterAttach();
      });
    }
  }

  //set to true once the user scroll the first time
  bool haveScrolled = false;

  //because of sticky headers not everything rebuilds immediately
  //I need to continue updating the variables until the user scrolls
  updateScrollUntilStablize(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      updateWithoutScroll();
      if(haveScrolled == false){
        print("repeat");
        updateScrollUntilStablize();
      }
      else{
        print("no repeat");
      }
    });
  }
  */

  /*
  //set initial size of scroll bar
    initScrollAfterAttach();
  */

  updateState(){
    if(mounted){
      setState((){});
    }
  }

  /*
  @override
  void initState() {
    //super init
    super.initState();
    //add listeners
    scrollController.addListener(updateAfterScroll);
    widget.totalScrollArea.addListener(updateState);
    widget.extraTopPadding.addListener(updateState);
  }

  @override
  void dispose() {
    //remove listeners
    scrollController.removeListener(updateAfterScroll);
    widget.totalScrollArea.removeListener(updateState);
    widget.extraTopPadding.removeListener(updateState);
    //super dispose
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    //orientation
    double totalScrollBarWidth = 48;

    //maths
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

    //build
    return Visibility(
      visible: totalHeight < totalScrollArea,
      child: Container(
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
    );
  }
}