import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

class ScrollBar extends StatefulWidget {
  const ScrollBar({
    Key key,
    @required this.totalScrollArea,
    @required this.extraTopPadding,
    @required this.scrollController,
  }) : super(key: key);

  final ValueNotifier<double> totalScrollArea;
  final ValueNotifier<double> extraTopPadding;
  final ScrollController scrollController;

  @override
  _ScrollBarState createState() => _ScrollBarState();
}

class _ScrollBarState extends State<ScrollBar> {
  updateState(){
    if(mounted){
      setState((){});
    }
  }

  @override
  void initState() {
    widget.extraTopPadding.addListener(updateState);
    widget.totalScrollArea.addListener(updateState);
    super.initState();
  }

  @override
  void dispose() {
    widget.totalScrollArea.removeListener(updateState);
    widget.extraTopPadding.removeListener(updateState);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //orientation
    double totalScrollBarWidth = 48;

    //maths
    double totalHeight = MediaQuery.of(context).size.height;
    double topBitHeight = widget.extraTopPadding.value;
    double appBarHeight = 56;
    double usableHeight = totalHeight - topBitHeight - appBarHeight;
    double totalScrollArea = widget.totalScrollArea.value;

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