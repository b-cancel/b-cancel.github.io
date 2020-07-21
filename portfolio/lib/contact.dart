//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:dynamic_overflow_menu_bar/dynamic_overflow_menu_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bot_toast/bot_toast.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';

//utils
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';

//TODO: scrolling the main view should dismiss the little pop ups
//TODO: tapping any item in the menu should dismiss the menu

//widget
class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({
    Key key,
    @required this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

  //generate these items here to avoid clutter
  OverFlowMenuItem overFlowMenuItem(
    BuildContext context, {
    @required String label,
    @required IconData icon,
    bool isIrregular: false,
    Function quickAction,
    List<Widget> menuItems,
  }) {
    Function showMenu = () {
      print("showing menu now");

      BotToast.showAttachedWidget(
        targetContext: context,
        //for all the icons that use it on top
        preferDirection: PreferDirection.bottomRight,
        //show forever until another shows or you dismiss it
        duration: Duration(days: 1),
        enableSafeArea: true,
        onlyOne: true,
        //regular old builder
        attachedBuilder: (_) {
          return Padding(
            padding: EdgeInsets.only(
              right: 16,
            ),
            child: Material(
              color: Colors.white,
              elevation: 6,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    menuItems.length,
                    (index) {
                      return menuItems[index];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    };

    //the actual overflow item
    return OverFlowMenuItem(
      onPressed: () => showMenu(),
      label: label,
      child: OpaqueOnHover(
        invert: false,
        child: Material(
          borderRadius: BorderRadius.circular(56),
          color: Colors.transparent,
          child: InkWell(
            //tapping on mobile
            //clicking on web
            //both expect a quickAction
            onTap: () => quickAction(),
            //on web
            //used to replace right clicking before they realize its not available
            //TODO: wut
            onHover: (boolean) => showMenu(),
            //on mobile
            //used to replace the context menu
            onLongPress: () => showMenu(),
            child: Ternary(
              condition: isIrregular,
              isTrue: Container(
                width: 22.0 + 8 * 2,
                height: 22.0 + 8 * 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 1,
                  ),
                  child: Icon(
                    icon,
                    size: 17,
                  ),
                ),
              ),
              isFalse: IconLinkIcon(
                icon: icon,
                mini: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 8,
      ),
      child: DynamicOverflowMenuBar(
        title: MyName(
          openMenu: openMenu,
        ),
        actions: [
          //NOTE: the item in the front will always be in the front... GITHUB
          //VCard should show up for downloading
          //a shortcut to the QR Code should also show up

          /*
                openWithHtml(
          context,
          url,
          openHere: true,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          lightMode: lightMode,
          children: [
            OptionButton(
    label: label,
    addBorder: true,
            ),
            OptionButton(
    icon: PortfolioIcons.open_in_new,
    label: "New Tab",
    onTap: () {
      openWithHtml(
        context,
        url,
        openHere: false,
      );
    },
            ),
            OptionButton(
    icon: PortfolioIcons.content_copy,
    label: "Copy",
    onTap: () {
      copyToClipboard(
        context,
        url,
      );
    },
            ),
          ],
        );
                */

          //TODO: in all cases tapping the label should copy it
          //TODO: repair the pop up that isnt showing text for some odd reason
          //TODO: if the width is larger than 430 -> use action sheet when pressing contact link
          //TODO: the above is particularly important so the behavior is consitent when things start to wrap

          //github link (with specific part highlighted) [also copies link]
          //---
          //open link (?? icon)***on mobile on tap assume this
          //open in new tab (tab icon)
          //copy link (copy icon)
          overFlowMenuItem(
            context,
            label: "Github Profile",
            icon: PortfolioIcons.github,
            quickAction: () => openWithHtml(
              context,
              generalGithub + myGithub,
              openHere: true,
            ),
            menuItems: [
              //assumed copy
              OptionButton(
                isTitle: true,
                icon: PortfolioIcons.github,
                label: Text(
                  "Github Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //TODO: make sure this works
                onTap: () => copyToClipboard(
                  context,
                  generalGithub + myGithub,
                ),
              ),

              //TODO: open link

              //TODO: open in new tab

              //actual copy
              OptionButton(
                icon: Icons.content_copy,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(generalGithub),
                    Text(
                      myGithub,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                //TODO: make sure this works
                onTap: () => copyToClipboard(
                  context,
                  generalGithub + myGithub,
                ),
              ),
            ],
          ),
          //linked in link (with specific part highlighted) [also copies link]
          //---
          //open link (?? icon)***on mobile on tap assume this
          //open in new tab (tab icon)
          //copy link (copy icon)
          overFlowMenuItem(
            context,
            label: "Linked In Profile",
            icon: PortfolioIcons.linkedin,
          ),
          //phone number (with specifics highlighted) [also copies number]
          //---
          //call number
          //text number
          //copy number ***on mobile on tap assume this
          //---
          //save V-Card
          overFlowMenuItem(
            context,
            label: myNumber,
            icon: PortfolioIcons.phone,
          ),
          //email (with specifics higlighted) [also copies email]
          //---
          //send email
          //copy email ***on mobile on tap assume this
          //---
          //save V-Card
          overFlowMenuItem(
            context,
            label: myEmail,
            icon: PortfolioIcons.email,
          ),
          //TODO: actually get this to do stuff
          overFlowMenuItem(
            context,
            label: "Contact Card",
            icon: PortfolioIcons.address_card,
            //icon is irregularly big and improperly centered
            isIrregular: true,
          ),
          //TODO: actually get this to do stuff
          overFlowMenuItem(
            context,
            label: "Scannable Contact Card",
            icon: FontAwesomeIcons.qrcode, //TODO: optimize
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  OptionButton({
    @required this.icon,
    @required this.label,
    @required this.onTap,
    this.isTitle: false,
  });

  final IconData icon;
  final Widget label;
  final Function onTap;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    Widget button = Material(
      color: Colors.transparent,
      child: InkWell(
        //dont show the title is hoverable
        hoverColor: isTitle ? Colors.transparent : null,
        onTap: onTap, //might be null
        child: Container(
          height: MyApp.smallestButtonSize,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: icon != null,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 6.0,
                  ),
                  child: Icon(
                    icon,
                  ),
                ),
              ),
              label,
            ],
          ),
        ),
      ),
    );

    //the title isn't intended to be clicked
    if (isTitle) {
      return Column(
        children: [
          button,
          Divider(
            thickness: 1,
            height: 1,
            color: Colors.black,
          ),
        ],
      );
    } else {
      return OpaqueOnHover(
        child: button,
      );
    }
  }
}
