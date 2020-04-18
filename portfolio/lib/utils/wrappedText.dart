//flutter
import 'package:flutter/material.dart';

//widget
class WrappedText extends StatelessWidget {
  WrappedText(this.text, {
    
    this.pattern: " ",
  });

  final String text;
  final String pattern;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: toWrappableText(
        text, 
        pattern: pattern,
      ),
    );
  }
}

//function
List<Widget> toWrappableText(String text, {String pattern: " "}) {
  List<String> bits = text.split(pattern);
  List<Widget> widgets = new List<Widget>();
  for (int i = 0; i < bits.length; i++) {
    bool isLast = (i == bits.length - 1);
    widgets.add(
      Text(
        bits[i] + (isLast ? "" : pattern),
      ),
    );
  }
  return widgets;
}