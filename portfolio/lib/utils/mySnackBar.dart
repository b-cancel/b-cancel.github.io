//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//function
showSnackBar(
  BuildContext context, {
  @required Color backgroundColor,
  @required Color textColor,
  String prefix: "",
  String message: "",
  String suffix: "",
  @required IconData icon,
  Duration duration: const Duration(seconds: 5),
}) {
  Scaffold.of(context).removeCurrentSnackBar();

  //PortfolioIcons.warning
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.all(0),
      content: InkWell(
        onTap: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 8.0,
              ),
              child: Icon(
                icon,
                color: textColor,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    prefix,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    suffix,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: duration,
    ),
  );
}
