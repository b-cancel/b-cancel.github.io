//flutter
import 'package:flutter/material.dart';

//widget
class TileBody extends StatelessWidget {
  const TileBody({
    @required this.child,
    @required this.theOnlyException,
    Key key,
  }) : super(key: key);

  final Widget child;
  final bool theOnlyException;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: theOnlyException ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              ),
            ),
          ],
        )
      ],
    );
  }
}