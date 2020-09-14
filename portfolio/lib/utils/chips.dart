import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  Chips({
    @required this.chips,
  });

  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        chips.length,
        (index) {
          return AChip(
            child: Text(
              chips[index],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AChip extends StatelessWidget {
  const AChip({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Card(
        color: Colors.black.withOpacity(0.90),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            24,
          ),
        ),
        margin: EdgeInsets.only(
          right: 8,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: child,
        ),
      ),
    );
  }
}
