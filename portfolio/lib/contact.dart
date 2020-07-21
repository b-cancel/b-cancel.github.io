//flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//plugins
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bot_toast/bot_toast.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/overflowMenuBar.dart';

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

  //title = "Github Profile"
  //icon = PortfolioIcons.github
  //url = generalGithub + myGithub
  OverFlowMenuItem webOverFlowMenuItem(
    BuildContext context, {
    @required String title,
    @required IconData icon,
    @required String generalUrl,
    @required String specificUrl,
  }) {
    String url = generalUrl + specificUrl;
    return overFlowMenuItem(
      context,
      icon: icon,
      label: title,
      quickAction: () => openWithHtml(
        context,
        url,
        openHere: true,
      ),
      menuItems: [
        //assumed copy
        OptionButton(
          isTitle: true,
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onTap: () => copyToClipboard(
            context,
            url,
          ),
        ),

        //open link
        OptionButton(
          icon: Icons.link,
          label: Text(
            "Open Link",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onTap: () => openWithHtml(
            context,
            url,
            openHere: true,
          ),
        ),

        //open in new tab
        OptionButton(
          icon: Icons.tab,
          label: Text(
            "Open Link In New Tab",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onTap: () => openWithHtml(
            context,
            url,
            openHere: false,
          ),
        ),

        //actual copy
        OptionButton(
          icon: Icons.content_copy,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                generalUrl,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                specificUrl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          onTap: () => copyToClipboard(
            context,
            url,
          ),
        ),
      ],
    );
  }

  //generate these items here to avoid clutter
  OverFlowMenuItem overFlowMenuItem(
    BuildContext context, {
    @required String label,
    @required IconData icon,
    Function quickAction,
    List<Widget> menuItems,
  }) {
    //what options come up when tapping things

    //2 different ways the menu can show up
    Function showContextMenu = () => BotToast.showAttachedWidget(
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
              //only right since we are pushing it towards the right
              padding: EdgeInsets.only(
                right: 16,
              ),
              child: Material(
                color: Colors.white,
                elevation: 6,
                child: IntrinsicWidth(
                  child: MenuOptions(
                    menuItems: menuItems,
                  ),
                ),
              ),
            );
          },
        );

    Function showPopUpMenu = () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: MenuOptions(
                menuItems: menuItems,
              ),
            );
          },
        );

    //the actual overflow item
    return OverFlowMenuItem(
      //this should not happen on desktop
      //since usually desktop is large enough to avoid overflow
      //and IF it does -> we dont want two open context menus
      //so in both cases
      onPressed: () => showPopUpMenu(),
      icon: icon,
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
            onHover: (boolean) {
              //NOTE: we don't allow hover if pointer doesn't exists... because this shouldn't be possible
              if (PointerOnHover.isActive()) {
                showContextMenu();
              }
            },
            //on mobile
            //used to replace the context menu
            onLongPress: () {
              //NOTE: we don't allow long press if a pointer exists to avoid weird formatting issues
              if (PointerOnHover.isActive() == false) {
                showPopUpMenu();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 4,
              ),
              height: 30,
              width: 30,
              child: Icon(
                icon,
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

          webOverFlowMenuItem(
            context,
            title: "Github Profile",
            icon: PortfolioIcons.github,
            generalUrl: generalGithub,
            specificUrl: myGithub,
          ),
          webOverFlowMenuItem(
            context,
            title: "Linked In Profile",
            icon: PortfolioIcons.linkedin,
            generalUrl: generalLinkedIn,
            specificUrl: myLinkedIn,
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
            //assume they want to copy the number
            quickAction: () => copyToClipboard(
              context,
              myNumber,
            ),
            menuItems: [
              //tapping the title copies always
              OptionButton(
                isTitle: true,
                icon: Icons.contact_phone,
                label: Text(
                  "Phone Number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () => copyToClipboard(
                  context,
                  myNumber,
                ),
              ),

              //call number
              //text number
              //copy number ***on mobile on tap assume this
            ],
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

class MenuOptions extends StatelessWidget {
  const MenuOptions({
    @required this.menuItems,
    Key key,
  }) : super(key: key);

  final List<Widget> menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        menuItems.length,
        (index) {
          return menuItems[index];
        },
      ),
    );
  }
}

/*
class VirtualCardDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.black,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 6,
                ),
                child: Container(
                  width: 30,
                  height: 30,
                  child: Icon(
                    icon,
                  ),
                ),
              ),
              label,
            ],
          ),
        ),
        OptionButton(
          icon: PortfolioIcons.address_card,
          label: Text("Download My Virutal Contact Card"),
          onTap: () {
            print("download contact card here");
          },
        ),
        OptionButton(
          icon: PortfolioIcons.address_card,
          label: Text("Scan My Virutal Contact Card"),
          onTap: () {
            print("scannable QR Code used in multiple areas");
          },
        ),
      ],
    );
  }
}
*/

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
        onTap: () {
          onTap();
          BotToast.cleanAll();
        },
        child: IgnorePointer(
          child: PopupMenuItem(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 6,
                  ),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Icon(
                      icon,
                      color: Colors.black,
                    ),
                  ),
                ),
                label,
              ],
            ),
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
