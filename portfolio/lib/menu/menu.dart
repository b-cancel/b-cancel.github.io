//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/menu/shifting.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';

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
    //1. start the implicit animations
    updateState();

    //2. animate the modal
    animateModal();

    //If the menu is being opened
    //we match the users intent by
    //making everything visible IMMEDIATELY
    if (widget.openMenu.value) {
      isFullyInvisible.value = false;
    }
    //ELSE
    //we first need to wait for the animation to finish
    //and then when the animation finishes
    //the invisibility will be applied
  }

  isFullyInvisibleToggled() {
    //we only reload if we have become invisible
    //otherwise the toggleMenu function will handle reloading for us
    if (isFullyInvisible.value) {
      //the menu has finished animating

      //so just make thing invisible
      updateState();
    }
  }

  //modal scrim colors
  Color modal = Colors.black.withOpacity(0.5);

  @override
  void initState() {
    super.initState();

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

    //NOTE: this listener is might be added and removed in within itself
    //for reasons specified at the top of the file
    widget.openMenu.addListener(
      menuToggled,
    );

    //when the modal controller below
    //completes that will trigger a rebuild
    //so we can taps items below the menu
    isFullyInvisible.addListener(
      isFullyInvisibleToggled,
    );

    //after the animation completes what to do?
    modalController.addListener(
      makeInvisibleOnComplete,
    );
  }

  @override
  void dispose() {
    //remove all the listeners
    modalController.removeListener(
      makeInvisibleOnComplete,
    );

    isFullyInvisible.removeListener(
      isFullyInvisibleToggled,
    );

    widget.openMenu.removeListener(
      menuToggled,
    );

    //dispose of all stuff
    isFullyInvisible.dispose();
    modalController.dispose();

    //super dispose
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

    Color baseColor = Colors.black;

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
          Positioned.fill(
            child: SizedBox.expand(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (widget.openMenu.value) {
                      widget.openMenu.value = false;
                    }
                  },
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            height: screenHeight,
            width: screenWidth,
            duration: kTabScrollDuration,
            top: 0,
            left: (widget.openMenu.value) ? 0 : -getMenuWidth(),
            child: Row(
              children: <Widget>[
                ShiftingMenu(
                  openMenu: widget.openMenu,
                  minWidth: minWidth,
                  maxWidth: maxWidth,
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: AnimatedOpacity(
                          duration: kTabScrollDuration,
                          opacity: widget.openMenu.value ? 1 : 0,
                          child: Container(
                            //minimum size of close menu button
                            width: 56 / 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [baseColor, baseColor.withOpacity(0)],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: SizedBox.expand(
                              child: Container(),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: SizedBox.expand(
                            child: Center(
                              child: AnimatedContainer(
                                duration: kTabScrollDuration,
                                transform: Matrix4.translationValues(
                                  (widget.openMenu.value) ? 0 : getMenuWidth(),
                                  0,
                                  0,
                                ),
                                child: AnimatedOpacity(
                                  duration: kTabScrollDuration,
                                  opacity: widget.openMenu.value ? 1 : 0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      "M\nY\n\nW\nO\nR\nK",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: MyApp.h4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
