import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/nonWebLink.dart';

//this works on the pricible that
//if it works, they wont see this
justInCaseShowQuickWarning(BuildContext context){
  showSnackBar(
    context,
    text: "Something Went Wrong :(",
    duration: Duration(seconds: 2),
  );
}

//basic struct
class Option{
  String name;
  Function function;
  Option(
    this.name,
    this.function,
  );
}

//handle both number cases
Option numberOption({bool callNumber}){
  //grab different stuff
  String action = callNumber ? "Call" : "Message";
  Function function = callNumber ? dialNumber : messageNumber;

  //return same stuff with proper params
  return Option(
    action,
    (BuildContext context, String number)async{
      justInCaseShowQuickWarning(context);
      /*
      if (await function(number) == false) {
        if(await copyToClipboard(number)){
          showSnackBar(
            context,
            text: "Unable to " + action + " Number\n"
            + number + " was copied instead",
          );
        }
        else{
          showSnackBar(
            context,
            text: "Unable to " + action + " Number",
          );
        }
      } else { //if they are taken to the dialer they wont notice this
        justInCaseShowQuickWarning(context);
      }
      */
    }
  );
}

//pass it context AND number
Option call = numberOption(callNumber: true);
Option message = numberOption(callNumber: false);

//options tool bar for links
//should be used for text link and icons links
showOptions(
  BuildContext context,
  {List<Widget> children,
  }){
  BotToast.showAttachedWidget(
    targetContext: context,
    preferDirection: PreferDirection.topCenter,
    enableSafeArea: true,
    allowClick: true,
    //virtually forever
    duration: Duration(days: 1),
    onlyOne: true,
    attachedBuilder: (_){
      return Card(
        color: MyApp.headerColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      );
    },
  );
}

class OptionButton extends StatelessWidget {
  OptionButton({
    this.icon,
    this.label,
    this.onTap,
    this.addBorder: false,
  });

  final IconData icon;
  final String label;
  final Function onTap;
  final bool addBorder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, //might be null
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.white,
                width: addBorder ? 2 : 0,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                ),
                Text(
                  label ?? "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}