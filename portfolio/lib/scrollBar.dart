import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';
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
  final ValueNotifier<double> currentScrollPosition = new ValueNotifier<double>(0);
  //must be updated after the run of build
  final ValueNotifier<double> heightToScroll = new ValueNotifier<double>(0);
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

    //cover null cases (which do happen at the start)
    double curr = position.pixels ?? 0;
    double min = position.minScrollExtent ?? 0;
    double max = position.maxScrollExtent ?? 0;

    //for the scroll basr
    currentScrollPosition.value = curr;

    //calculate overscroll
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
    heightToScroll.value = max + widget.overScroll.value;
  }

  //TODO: fix the super rare hard to fix problem... scrolling isnt needed but the user is still using the page
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

  handleSectionToggled(){
    if(aSectionToggled.value){
      //handle it
      WidgetsBinding.instance.addPostFrameCallback((_){
        updateAfterScroll(
          triggeredByScrolling: false,
        );

        //required since closing the region may make the scroll bar no longer needed
        WidgetsBinding.instance.addPostFrameCallback((_){
          if(mounted){
            setState(() {});
          }
        });
      });

      //indicate process complete
      aSectionToggled.value = false;
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
    aSectionToggled.addListener(handleSectionToggled);
  }

  @override
  void dispose() {
    //remove listeners
    aSectionToggled.removeListener(handleSectionToggled);
    widget.scrollController.removeListener(updateAfterScroll);

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //assume you don't need the scroll bar initially
    if(widget.scrollController != null){
      if(widget.scrollController.hasClients){
        //NOTE: BOTH of the variables used by
        //the atual scroll bar widet below
        //are updated here
        updateAfterScroll(
          triggeredByScrolling: false,
        );
      }
    }

    //build
    return Visibility(
      //if max is 0
      //the scroll view detected that scrolling isnt needed
      //so don't show the scroll bar
      visible: heightToScroll.value > 0.0,
      child: ActualScrollBar(
        scrollController: widget.scrollController,
        currentScrollPosition: currentScrollPosition,
        extraTopPadding: extraTopPadding, 
        heightToScroll: heightToScroll,
      ),
    );
  }
}

class ActualScrollBar extends StatefulWidget {
  const ActualScrollBar({
    @required this.scrollController,
    @required this.currentScrollPosition,
    @required this.extraTopPadding,
    @required this.heightToScroll,
  });

  final ScrollController scrollController;
  final ValueNotifier<double> currentScrollPosition;
  final ValueNotifier<double> extraTopPadding;
  final ValueNotifier<double> heightToScroll;

  @override
  _ActualScrollBarState createState() => _ActualScrollBarState();
}

class _ActualScrollBarState extends State<ActualScrollBar> {
  //might want to change value given orientation
  double totalScrollBarWidth = 48;

  updateState(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.currentScrollPosition.addListener(updateState);
    widget.heightToScroll.addListener(updateState);
    widget.extraTopPadding.addListener(updateState);
  }

  @override
  void dispose() {
    widget.extraTopPadding.removeListener(updateState);
    widget.heightToScroll.removeListener(updateState);
    widget.currentScrollPosition.removeListener(updateState);
    super.dispose();
  }

  regionBox(GlobalKey key, double ratio, {isHeader: false}){
    final RenderBox renderBox = key.currentContext.findRenderObject();
    double boxHeight = renderBox.size.height * ratio;
    return Container(
      decoration: BoxDecoration(
        color: MyApp.oldPurple,
        border: Border(
          //more accurate pretty much the same look
          top: BorderSide(
            color: MyApp.bodyColor,
            width: 4,
          ),
        ),
      ),
      height: boxHeight,
      width: isHeader ? 24 : 0,
    );
  }

  final ValueNotifier<double> sliderValue = new ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;

    //heights to calculate visual scroll bar
    double topBitVisualHeight = widget.extraTopPadding.value;
    double appBarVisualHeight = 56;
    double usableVisualHeight = totalHeight - topBitVisualHeight - appBarVisualHeight;

    //height to calculate programatic scroll bar
    double heightToScroll = widget.heightToScroll.value;
    double totalScrollHeight = heightToScroll + totalHeight;

    //NOTE: inside of [usableHeight] should be shown all the scroll area
    //the scroll area is as large as [totalScrollArea]
    //we are trying to get the size of the scroll bar
    //based on the fact that we are at all times seeing [totalHeight] of everything

    //ratio
    //totalHeight             ???
    //-----------       =     ------------
    //totalScrollHeight       usableHeight

    double ratio;
    if(totalScrollHeight <= 0){
      ratio = 0;
    }
    else{
      ratio = totalHeight / totalScrollHeight;;
    }
    double scrollBarHeight = ratio * usableVisualHeight;

    //now based on the above calc scroll padding
    //our widget.currentScrollPosition.value
    //can go between 0 AND heightToScroll
    //that maps between 0 AND maxPadding so...
    double maxPadding = usableVisualHeight - scrollBarHeight;

    //current / heightToScroll = padding / maxPadding
    double currentHeightScrolled = widget.currentScrollPosition.value;
    double scrollBarPadding;
    if(heightToScroll <= 0){
      scrollBarPadding = 0;
    }
    else{
      scrollBarPadding = currentHeightScrolled / heightToScroll;
    }
    scrollBarPadding *= maxPadding;

    //create section bars
    List<Widget> regionBars = new List<Widget>();
    for(int i = 0; i < regions.length; i++){
      Region thisRegion = regions[i];
      //header
      regionBars.add(
        regionBox(
          thisRegion.headerKey, 
          ratio,
          isHeader: true,
        ),
      );
      //body
      regionBars.add(
        regionBox(
          thisRegion.bodyKey,
          ratio,
        ),
      );
    }

    //return
    return Container(
        width: totalScrollBarWidth,
        height: totalHeight,
        padding: EdgeInsets.only(
          top: topBitVisualHeight + appBarVisualHeight,
        ),
        child: Material(
          color: Colors.transparent,
          child: InvisibleInkWell(
            onTap: (){},
            //material is 48 by 48 atleast
            //we can fake it and make it 
            //24 and 24 of space that actually also scrolls
            //but for now
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Container(
                  width: totalScrollBarWidth/2,
                  height: usableVisualHeight,
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
                ),
                Container(
                  width: totalScrollBarWidth/2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      //NOTE: we don't use the appBar height 
                      //since its never scrolled away
                      top: topIntroHeight * ratio,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: regionBars,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: scrollBarPadding ?? 0,
                  ),
                  height: scrollBarHeight,
                  width: totalScrollBarWidth/2,
                  color: Colors.white.withOpacity(0.25),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: usableVisualHeight,
                    height: totalScrollBarWidth,
                    child: Opacity(
                      opacity: 0,
                      child: Slider(
                        onChanged: (newValue) {
                          sliderValue.value = newValue;
                          widget.scrollController.jumpTo(newValue);
                        },
                        value: sliderValue.value,
                        min: 0,
                        max: heightToScroll,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}