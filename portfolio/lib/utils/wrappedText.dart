//flutter
import 'package:flutter/material.dart';

//widget
class WrappedText extends StatelessWidget {
  WrappedText(
    this.text, {
    this.style,
    this.pattern: " ",
  });

  final String text;
  final String pattern;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: toWrappableText(
        text,
        pattern: pattern,
        style: style,
      ),
    );
  }
}

//function
List<Widget> toWrappableText(String text,
    {TextStyle style, String pattern: " "}) {
  List<String> bits = text.split(pattern);
  List<Widget> widgets = new List<Widget>();
  for (int i = 0; i < bits.length; i++) {
    bool isLast = (i == bits.length - 1);
    widgets.add(
      Text(
        bits[i] + (isLast ? "" : pattern),
        style: style,
      ),
    );
  }
  return widgets;
}
