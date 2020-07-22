//flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//plugins
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bot_toast/bot_toast.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/overflowMenuBar.dart';
import 'package:portfolio/qrCode.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';

//utils
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/utils/mySnackBar.dart';

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
        //TODO: eventually get to a point where our site loads fast enough to make this the default
        openHere: false,
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

        //allways try to get them to save my contact
        VCardDownload(),
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
                child: MenuOptions(
                  menuItems: menuItems,
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
            onTap: () {
              BotToast.cleanAll();
              Navigator.maybePop(context);
              quickAction();
            },
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

  OverFlowMenuItem contactOverFlowMenuItem(
    BuildContext context, {
    @required String label,
    @required IconData icon,
  }) {
    String generalLabel = " My Contact Details";
    Widget labelWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(generalLabel),
      ],
    );

    Function showTooltip = () => BotToast.showAttachedWidget(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: labelWidget,
                ),
              ),
            );
          },
        );

    Function onTap = () {
      //close the tooltip
      BotToast.cleanAll();

      //open the little virutal card
      openVCardPopUp(context);
    };

    return OverFlowMenuItem(
      onPressed: () => onTap(),
      icon: icon,
      label: label + generalLabel,
      child: OpaqueOnHover(
        invert: false,
        child: Material(
          borderRadius: BorderRadius.circular(56),
          color: Colors.transparent,
          child: InkWell(
            //tapping on mobile
            //clicking on web
            //both expect a quickAction
            onTap: () => onTap(),
            //on web
            //used to replace right clicking before they realize its not available
            onHover: (boolean) {
              //NOTE: we don't allow hover if pointer doesn't exists... because this shouldn't be possible
              if (PointerOnHover.isActive()) {
                showTooltip();
              }
            },
            //on mobile
            //used to replace the context menu
            onLongPress: () {
              //NOTE: we don't allow long press if a pointer exists to avoid weird formatting issues
              if (PointerOnHover.isActive() == false) {
                showTooltip();
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

          //Github
          webOverFlowMenuItem(
            context,
            title: "Github Profile",
            icon: PortfolioIcons.github,
            generalUrl: generalGithub,
            specificUrl: myGithub,
          ),

          //LinkedIn
          webOverFlowMenuItem(
            context,
            title: "Linked In Profile",
            icon: PortfolioIcons.linkedin,
            generalUrl: generalLinkedIn,
            specificUrl: myLinkedIn,
          ),

          //phone number
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
              OptionButton(
                icon: Icons.phone,
                label: Text(
                  "Call Me",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => callNumber(
                  context,
                  myNumber,
                ),
              ),

              //text number
              OptionButton(
                icon: Icons.message,
                label: Text(
                  "Message Me",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => textNumber(
                  context,
                  myNumber,
                ),
              ),

              //copy number ***on mobile on tap assume this
              OptionButton(
                icon: Icons.content_copy,
                label: Text(
                  myNumber,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => copyToClipboard(
                  context,
                  myNumber,
                ),
              ),

              //allways try to get them to save my contact
              VCardDownload(),
            ],
          ),

          //email
          overFlowMenuItem(
            context,
            label: myEmail,
            icon: PortfolioIcons.email,
            quickAction: () => copyToClipboard(
              context,
              myEmail,
            ),
            menuItems: [
              //tapping the title copies always
              OptionButton(
                isTitle: true,
                icon: Icons.contact_phone,
                label: Text(
                  "Email Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () => copyToClipboard(
                  context,
                  myEmail,
                ),
              ),

              //email number
              OptionButton(
                icon: Icons.phone,
                label: Text(
                  "Email Me",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => sendEmail(
                  context,
                  myEmail,
                ),
              ),

              //copy number ***on mobile on tap assume this
              OptionButton(
                icon: Icons.content_copy,
                label: Text(
                  myEmail,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => copyToClipboard(
                  context,
                  myEmail,
                ),
              ),

              //allways try to get them to save my contact
              VCardDownload(),
            ],
          ),

          //these are repeated just in case
          contactOverFlowMenuItem(
            context,
            label: "Save",
            icon: PortfolioIcons.address_card,
          ),

          //these are repeated just in case
          contactOverFlowMenuItem(
            context,
            label: "Scan",
            icon: FontAwesomeIcons.qrcode,
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
    return IntrinsicWidth(
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
    );
  }
}

openVCardPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: QRWidget(
          isDialog: true,
        ),
      );
    },
  );
}

class QRWidget extends StatelessWidget {
  const QRWidget({
    Key key,
    this.isDialog: false,
  }) : super(key: key);

  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    return OpaqueOnHover(
      invert: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (isDialog) {
              //NOTE: this only works in the web but that's where I need it to work
              String fileName = "Bryan_Cancel.vcf";
              String url = "vcards/" + fileName;
              //TODO: remember to switch this to false when ready to build
              bool testing = false;
              if (testing == false) {
                //true if NOT TESTING
                url = ("assets/" + url);
              }
              if (await downloadFile(url)) {
                showSnackBar(
                  context,
                  text: "Contact Card Downloaded",
                  icon: PortfolioIcons.check,
                );
              } else {
                showSnackBar(
                  context,
                  text: 'Contact Card Download Not Supported',
                );
              }
            } else {
              openVCardPopUp(context);
            }
          },
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Save My Contact Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isDialog == false,
                          child: Container(
                            height: 48,
                          ),
                        ),
                        Visibility(
                          visible: isDialog,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.maybePop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MyApp.h4,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(PointerOnHover.isActive()
                                    ? "Click"
                                    : "Tap"),
                                Text(
                                  " || ",
                                ),
                                Text("Scan"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 250,
                      maxWidth: 250,
                    ),
                    child: Container(
                      width: 250,
                      height: 250,
                      child: AdjustableQrCode(
                        squaresColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VCardDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 0.5,
          height: 0.5,
          color: Colors.black,
        ),
        OptionButton(
          icon: PortfolioIcons.address_card,
          label: Text(
            "Save My Contact Details",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            openVCardPopUp(context);
          },
        ),
      ],
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
        onTap: () {
          //close the context menu(if we use one)
          BotToast.cleanAll();

          //close the context menu(in pop up form)
          if (Navigator.canPop(context)) {
            Navigator.of(context).maybePop();
          }

          //perform the action
          onTap();
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
