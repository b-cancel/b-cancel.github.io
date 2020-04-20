//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/utils/invisibleInkWell.dart';

//widget
class TextLink extends StatelessWidget {
  TextLink({
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return InvisibleInkWell(
      onHover: (event){
        
      },
      child: Text(text),
    );
  }
}