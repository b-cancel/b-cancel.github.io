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
  String url,
  {
    String text,
    //bool copy: true,
    bool call: false,
    bool message: false,
    //bool email: false,
    //bool download: false,
  }){
  List<Option> options = new List<Option>();

  //add all the stuff we want
  if(call){

  }

  //show tool bar
  BotToast.showAttachedWidget(
    targetContext: context,
    preferDirection: PreferDirection.topCenter,
    duration: Duration(seconds: 5),
    onlyOne: true,
    attachedBuilder: (_){
      return Card(
        color: MyApp.headerColor,
        child: Text("hi"), /*Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: text != null,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(text ?? ""),
                ),
              ),
            ),
          ],
        ),*/
      );
    },
  );
}