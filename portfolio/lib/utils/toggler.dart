//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:portfolio/icons/portfolio_icons_icons.dart';

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
          PortfolioIcons.minus,
          size: 14,
          color: MyApp.oldGrey,
        );
      } else {
        icon = Icon(
          PortfolioIcons.add,
          color: MyApp.oldGrey,
        );
      }
    }
    else{
      icon = Icon(
        (sectionOpened.value) ? PortfolioIcons.keyboard_arrow_up : PortfolioIcons.keyboard_arrow_down,
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
