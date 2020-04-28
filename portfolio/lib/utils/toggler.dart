//flutter
import 'package:flutter/material.dart';

//plugins
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/conditional.dart';

//widget
class Toggler extends StatelessWidget {
  const Toggler({
    Key key,
    @required this.sectionOpened,
    this.useIconButton: false,
  }) : super(key: key);

  final ValueNotifier<bool> sectionOpened;
  final bool useIconButton;

  @override
  Widget build(BuildContext context) {
    Icon icon;
    if(useIconButton){
      if (sectionOpened.value) {
        icon = Icon(
          //TODO
          Icons.close,// FontAwesomeIcons.minus,
          //size: 14,
          color: MyApp.oldGrey,
        );
      } else {
        icon = Icon(
          Icons.add,
          color: MyApp.oldGrey,
        );
      }
    }
    else{
      icon = Icon(
        (sectionOpened.value) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: MyApp.oldGrey,
      );
    }

    //build
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(useIconButton ? 12 : 0),
                decoration: BoxDecoration(
                  color: MyApp.bodyColor,
                  border: Border.all(
                    width: 2,
                    color: MyApp.oldGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Ternary(
            condition: useIconButton,
            isTrue: IconButton(
              icon: icon,
              onPressed: () {
                sectionOpened.value = !sectionOpened.value;
              },
            ),
            isFalse: icon,
          ),
        )
      ],
    );
  }
}
