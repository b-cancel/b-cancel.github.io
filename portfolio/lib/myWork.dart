import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';

class IframeSection extends StatefulWidget {
  @override
  _IframeSectionState createState() => _IframeSectionState();
}

class _IframeSectionState extends State<IframeSection> {
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    //when the menu is automatically opened
    //to avoid snapping into place
    //once the menu width is read in
    //you wait until you can shift
    //and after you shift you progressively fade in
    waitingForMenuWidth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  waitingForMenuWidth() {
    double shiftValue = getMenuWidth();
    if (shiftValue == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        waitingForMenuWidth();
      });
    } else {
      print("Menu size: " + shiftValue.toString());
      //the menu size has been read
      //now we can insta close the page
      Home.openMenu.value = false;

      //wait one from for that to happen before opening the page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Home.openMenu.value = true;
        Home.startUpComplete.value = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //vars used to determine grid scaling
    double requiredPhonesOnScreen =
        2; //NOT 2 to avoid alot of gifs showing in phone portrait modes
    double screenHeight = MediaQuery.of(context).size.height;
    double deviceHeight = screenHeight / requiredPhonesOnScreen;

    //most everything will be phone sized gifs
    //but we don't want monitor sized gifs to look terrible either
    double phoneAspectRatio = (9 / 16);
    double monitorAspectRatio = (16 / 9);
    double squareAspectRatio = 1;
    double phonePrimary = (phoneAspectRatio + squareAspectRatio) / 2;
    double monitorPrimary = (monitorAspectRatio + squareAspectRatio) / 2;

    //grid column calcs
    double deviceWidth = deviceHeight * phonePrimary;
    double screenWidth = MediaQuery.of(context).size.width;
    double phonesThatFit = screenWidth / deviceWidth;

    int columnCount = phonesThatFit.ceil();

    int colWidth = (columnCount * 250);
    int gutterWidth = ((columnCount + 1) * 16);
    int iframeWidth = colWidth + gutterWidth;

    //calcing height
    double iframeHeight =
        iframeWidth * ((screenHeight - Home.appBarSize) / screenWidth);

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: AnimatedBuilder(
        animation: Home.openMenu,
        //the main page doesn't need to be rebuilt to be shifted
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: iframeWidth.toDouble(),
            height: iframeHeight,
            child: HtmlView(),
          ),
        ),
        //only handle shifting on isMenuOpened Toggle
        builder: (BuildContext context, Widget nonChangingChild) {
          return AnimatedContainer(
            duration:
                Home.startUpComplete.value ? kTabScrollDuration : Duration.zero,
            transform: Matrix4.translationValues(
              (Home.openMenu.value) ? getMenuWidth() : 0,
              0,
              0,
            ),
            child: nonChangingChild,
          );
        },
      ),
    );
  }
}

class HtmlView extends StatelessWidget {
  const HtmlView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }
}
