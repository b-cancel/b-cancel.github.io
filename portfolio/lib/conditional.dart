import 'package:flutter/material.dart';

class Ternary extends StatelessWidget {
  Ternary({
    @required this.condition,
    @required this.isTrue,
    @required this.isFalse,
  });

  final bool condition;
  final Widget isTrue;
  final Widget isFalse;

  @override
  Widget build(BuildContext context) {
    if(condition){
      return isTrue;
    }
    else{
      return isFalse;
    }
  }
}