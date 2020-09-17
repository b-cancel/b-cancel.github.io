import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/contact.dart';
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

Widget webLinkWidget(
  BuildContext context, {
  @required String title,
  @required IconData icon,
  @required String generalUrl,
  @required String specificUrl,
}) {
  String url = generalUrl + specificUrl;
  return linkWidget(
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
Widget linkWidget(
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
        preferDirection: PreferDirection.topLeft,
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
  return OpaqueOnHover(
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
  );
}
