import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';

showSnackBar(BuildContext context, {String text, IconData icon}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: MyApp.inactiveTabColor,
      content: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Scaffold.of(context).hideCurrentSnackBar();
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: Icon(
                  Icons.warning,
                  color: Colors.yellow,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      duration: Duration(seconds: 7),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
