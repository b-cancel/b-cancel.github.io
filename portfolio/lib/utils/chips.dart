import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  Chips({
    @required this.chips,
    this.wrapped: true,
  });

  final List<String> chips;
  final bool wrapped;

  @override
  Widget build(BuildContext context) {
    List<Widget> theChips = List.generate(
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
    );

    if (wrapped) {
      return Wrap(
        children: theChips,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: theChips,
      );
    }
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
