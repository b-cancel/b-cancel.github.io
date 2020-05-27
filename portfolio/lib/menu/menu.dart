//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/menu/helper.dart';
import 'package:portfolio/menu/shifting.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/home.dart';

//widget
class ResumeInMenu extends StatefulWidget {
  const ResumeInMenu({
    Key key,
    @required this.menuKey,
    @required this.openMenu,
  }) : super(key: key);

  final GlobalKey menuKey;
  final ValueNotifier<bool> openMenu;

  @override
  _ResumeInMenuState createState() => _ResumeInMenuState();
}

//THE ANALYSIS BELOW is to explain why I am remove and adding the openMenuListener
//when the user opens the menu
//since that inital open is just to indicate that the opening should start
//but it order for things to work well
//we need to use that to make the menu not invisible but keep the menu closed
//the let the build into a frame
//and then have the menu animate in
//there are probably better ways to do this
//but this works well enough for now

//CASE 1: menu is open (values don't match)
//menuOpen = true && fullyInvisible = false

//USER-ACTION: user closes menu (values match)
//menuOpen = FALSE && fullyInvisible = false

//OUR-ACTION:
//we eventually set fullyInvisible to true

//RESULT
//menuOpen = false && fullInvisible = TRUE

//-----*-----*-----*-----*-----

//CASE 2: menu is closed (values don't match)
//menuOpen = false && fullInvisible = true

//ACTION: user opens menu (Values match)
//menuOpen = TRUE && fullyInvisible = true

//OUR-ACTION:
//we eventually set fullyInvisible to false

//RESULT
//menuOpen = true && fullInvisible = FALSE

class _ResumeInMenuState extends State<ResumeInMenu>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isFullyInvisible;
  bool startedOpen;
  AnimationController modalController;
  Animation<Color> modalAnimation;

  makeInvisibleOnComplete() {
    //the menu just finished closing
    //so we make the interactibles above it fully invisible
    if (widget.openMenu.value == false) {
      //status checking
      AnimationStatus status = modalController.status;
      bool animationComplete = (status == AnimationStatus.completed);
      if (animationComplete) {
        isFullyInvisible.value = true;
      }
    }
  }

  animateModal() {
    if (startedOpen) {
      if (widget.openMenu.value) {
        modalController.reverse();
      } else {
        modalController.forward();
      }
    } else {
      if (widget.openMenu.value) {
        modalController.forward();
      } else {
        modalController.reverse();
      }
    }
  }

  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  menuToggled() {
    //we want to open the menu
    //so we must first make thing visible
    if (widget.openMenu.value) {
      print("*************************opening menu");

      //the user wants the menu to be opened
      //but it must be visible first
      //NOTE: the listener to this variable 
      //is the one that does alot of code gymnastics to work properly
      isFullyInvisible.value = false;
    } else {
      print("*************************closing menu");
      //NOTES: its assumed that isFullyInvisible.value
      //is equal to true here
      //since first things will close
      //and THEN become fully inivisible
      //as explained by 2 below

      //1. start the implicit animations
      updateState();

      //2. animate the modal that will eventually
      //  make everything fully invisible
      animateModal();
    }
  }

  isFullyInvisibleToggled(){
    if(isFullyInvisible.value){
      //the menu has finished animating

      //so just make thing invisible
      updateState();
    }
    else{
      //menuOpen = true
      //AND isFullyInvisible = false

      //1. start the implicit animations
      updateState();

      //2. animate the modal
      animateModal();

      /*
      //this was triggered because the user want to open the menu
      //and indicated that by setting openMenu to true

      //BUT in order for the implicit animations to work properly
      //when we make things visible 
      //they must be out of the screen
      //or in other words openMenu needs to be false
      
      //since setting it to false will start the process of 
      //closing the menu due to the listener attached to it
      //we must first remove the listener
      print("removing listener");
      widget.openMenu.removeListener(menuToggled);

      //now because we removed the listener
      //this won't close the menu when we are trying to open it
      print("Setting openMenu to closed");
      widget.openMenu.value = false;

      //this first updateState will cause 
      //everything to appear but outside of the screen
      updateState();

      //now we wait 1 frame so that we can begin the animations
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print("a frame passed and we set openMenu to true");
        //0. set the openMenu variable 
        //so the things that are now visible also animate in
        widget.openMenu.value = true;

        //1. start the implicit animations
        updateState();

        //2. animate the modal
        animateModal();

        //3. add the listener so if the user closes the menu
        //  the menu behaves as expected
        widget.openMenu.addListener(menuToggled);
      });*/
    }
  }

  //modal scrim colors
  Color modal = Colors.red; //Colors.black.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    //NOTE: this listener is might be added and removed in within itself
    //for reasons specified at the top of the file
    widget.openMenu.addListener(menuToggled);

    //save how we started
    //so we know the initial setup of our modalAnimation
    //and be able to go forward and reverse accordingly
    startedOpen = widget.openMenu.value;

    //init controller
    modalController = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
    );

    //the animation the controller plays with
    modalAnimation = ColorTween(
      begin: widget.openMenu.value ? modal : null,
      end: widget.openMenu.value ? null : modal,
    ).animate(modalController);

    //after the close menu animations
    //the menu has to fully dispear
    //and right before
    //the menu has to be fully visible
    isFullyInvisible = new ValueNotifier<bool>(
      widget.openMenu.value == false,
    );

    //when the modal controller below
    //completes that will trigger a rebuild 
    //so we can taps items below the menu
    isFullyInvisible.addListener(isFullyInvisibleToggled);

    //after the animation completes what to do?
    modalController.addListener(
      makeInvisibleOnComplete,
    );
  }

  @override
  void dispose() {
    //TODO: close everything in init
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //keep it nice and satisfying at all times
    double minWidth = toGoldenRatioSmall(
      screenWidth,
    );

    //compromise golden ratio when small for cool transition effect
    double maxWidth = screenWidth - 56;

    print("menu open? " + widget.openMenu.value.toString());
    return Visibility(
      //lets us avoid to all the code gymnastics we did initially
      maintainState: true,
      //maintainInteractivity: false,
      //maintainSemantics: false,
      //maintainAnimation: false,
      //maintainSize: false,
      visible: isFullyInvisible.value == false,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedModalBarrier(
              dismissible: false,
              color: modalAnimation,
            ),
          ),
          AnimatedPositioned(
            height: MediaQuery.of(context).size.height,
            duration: kTabScrollDuration,
            top: 0,
            left: (widget.openMenu.value) ? 0 : -getMenuWidth(),
            child: ShiftingMenu(
              openMenu: widget.openMenu,
              minWidth: minWidth,
              maxWidth: maxWidth,
            ),
          ),
          /*
          Positioned.fill(
            child: null,
          ),
          */
        ],
      ),
    );

    //build
    /*
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ScrimBehindMovingMenu(
                openMenu: widget.openMenu,
              ),
              
            ],
          ),
          Expanded(
            child: MyWorkMenuCloseButton(
              openMenu: widget.openMenu,
            ),
          ),
        ],
      ),
    );*/
  }
}
