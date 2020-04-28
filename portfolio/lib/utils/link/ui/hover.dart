import 'package:flutter/material.dart';
import 'dart:html' as html;

class UnderlineOnHover extends StatefulWidget {
  UnderlineOnHover({
    @required this.child,
  });

  final Widget child;

  @override
  _UnderlineOnHoverState createState() => _UnderlineOnHoverState();
}

class _UnderlineOnHoverState extends State<UnderlineOnHover> {
  final ValueNotifier<bool> isHovered = new ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return OnHover(
      isHovering: isHovered,
      child: AnimatedBuilder(
        animation: isHovered, 
        child: widget.child,
        builder: (context, resuable){
          return DefaultTextStyle(
            style: TextStyle(
              decoration: isHovered.value ? TextDecoration.underline : TextDecoration.none,
            ),
            child: resuable,
          );
        },
      ),
    );
  }
}

class OpaqueOnHover extends StatefulWidget {
  OpaqueOnHover({
    @required this.child,
  });

  final Widget child;

  @override
  _OpaqueOnHoverState createState() => _OpaqueOnHoverState();
}

class _OpaqueOnHoverState extends State<OpaqueOnHover> {
  final ValueNotifier<bool> isHovered = new ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return OnHover(
      isHovering: isHovered,
      child: AnimatedBuilder(
        animation: isHovered, 
        child: widget.child,
        builder: (context, resuable){
          return Opacity(
            opacity: isHovered.value ? 1 : .50,
            child: resuable,
          );
        },
      ),
    );
  }
}

class OnHover extends StatelessWidget {
  OnHover({
    Key key, 
    this.child,
    this.isHovering,
  }) : super(key: key);

  final Widget child;
  final ValueNotifier<bool> isHovering;

  // Get a regerence to the body of the view
  static final appContainer = html.window.document.getElementById(
    'app-container',
  );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e){
        appContainer.style.cursor = 'pointer';
        if(isHovering != null){
          isHovering.value = true;
        }
      },
      onExit: (e){
        appContainer.style.cursor = 'default';
        if(isHovering != null){
          isHovering.value = false;
        }
      },
      child: child,
    );
  }
}