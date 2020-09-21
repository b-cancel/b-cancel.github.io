//dart
import 'dart:math' as math;

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:animator/animator.dart';

class RotatingIcon extends StatelessWidget {
  RotatingIcon({
    @required this.color,
    @required this.isOpen,
  });

  //passed params
  final Color color;
  final ValueNotifier<bool> isOpen;

  //operating within
  final ValueNotifier<double> tweenBeginning = new ValueNotifier<double>(-1);
  final ValueNotifier<double> fractionOfDuration = new ValueNotifier<double>(1);

  //"constants"
  final double normalRotation = 0;
  final double otherRotation = (-math.pi / 4) * 4;

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      resetAnimationOnRebuild: true,
      tween: isOpen.value
          ? Tween<double>(
              begin: tweenBeginning.value == -1
                  ? normalRotation
                  : tweenBeginning.value,
              end: otherRotation,
            )
          : Tween<double>(
              begin: tweenBeginning.value == -1
                  ? otherRotation
                  : tweenBeginning.value,
              end: normalRotation,
            ),
      duration: Duration(
        milliseconds:
            ((kTabScrollDuration.inMilliseconds * fractionOfDuration.value)
                .toInt()),
      ),
      customListener: (animator) {
        tweenBeginning.value = animator.animation.value;
        fractionOfDuration.value = animator.controller.value;
      },
      builder: (context, anim, child) => Transform.rotate(
        angle: anim.value,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: color,
        ),
      ),
    );
  }
}
