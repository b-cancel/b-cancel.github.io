//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';

//function
showSnackBar(BuildContext context, {
  String text, 
  IconData icon,
  Duration duration: const Duration(seconds: 7),
}) {
  Scaffold.of(context).removeCurrentSnackBar();
  
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
                  icon ?? PortfolioIcons.warning,
                  color : icon != null ? Colors.white : Colors.yellow,
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
      duration: duration,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
