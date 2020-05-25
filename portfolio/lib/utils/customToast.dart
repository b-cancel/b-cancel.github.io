import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CustomToast extends StatelessWidget {
  CustomToast({
    @required this.child,
    @required this.padding,
  });

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: padding > 0 ? padding : 0,
        top: padding < 0 ? -padding : 0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                BotToast.cleanAll();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}