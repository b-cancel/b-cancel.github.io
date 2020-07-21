import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

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
    return PointerOnHover(
      isHovering: isHovered,
      child: AnimatedBuilder(
        animation: isHovered,
        child: widget.child,
        builder: (context, resuable) {
          return DefaultTextStyle(
            style: TextStyle(
              decoration: isHovered.value
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            child: resuable,
          );
        },
      ),
    );
  }
}

class ColorizeLinkOnHover extends StatefulWidget {
  ColorizeLinkOnHover({
    @required this.icon,
    this.color,
    this.symbol,
    this.padding: const EdgeInsets.all(12),
  });

  final IconData icon;
  final Color color;
  final String symbol;
  final EdgeInsets padding;

  @override
  _ColorizeLinkOnHoverState createState() => _ColorizeLinkOnHoverState();
}

class _ColorizeLinkOnHoverState extends State<ColorizeLinkOnHover> {
  final ValueNotifier<bool> isHovered = new ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Theme.of(context).iconTheme.color;
    return PointerOnHover(
      isHovering: isHovered,
      child: AnimatedBuilder(
        animation: isHovered,
        builder: (context, resuable) {
          return Padding(
            padding: widget.padding,
            child: Stack(
              children: <Widget>[
                Icon(
                  widget.icon,
                  color: isHovered.value ? widget.color : defaultColor,
                  size: 36,
                ),
                Visibility(
                  visible: widget.symbol != null,
                  child: Positioned(
                    right: 2,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHovered.value ? widget.color : defaultColor,
                          shape: BoxShape.circle,
                        ),
                        height: 11,
                        width: 11,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.symbol ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeData.dark().primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OpaqueOnHover extends StatefulWidget {
  OpaqueOnHover({
    @required this.child,
    this.invert: false,
  });

  final Widget child;
  final bool invert;

  @override
  _OpaqueOnHoverState createState() => _OpaqueOnHoverState();
}

class _OpaqueOnHoverState extends State<OpaqueOnHover> {
  final ValueNotifier<bool> isHovered = new ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return PointerOnHover(
      isHovering: isHovered,
      child: AnimatedBuilder(
        animation: isHovered,
        child: widget.child,
        builder: (context, resuable) {
          return Opacity(
            opacity: widget.invert
                ? (isHovered.value ? .5 : 1)
                : (isHovered.value ? 1 : .5),
            child: resuable,
          );
        },
      ),
    );
  }
}

class PointerOnHover extends StatelessWidget {
  PointerOnHover({
    Key key,
    this.child,
    this.isHovering,
  }) : super(key: key);

  final Widget child;
  final ValueNotifier<bool> isHovering;

  // Get a regerence to the body of the view
  static final appContainer = window.document.getElementById(
    'app-container',
  );

  static bool isActive() {
    return appContainer.style.cursor == 'pointer';
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent e) {
        appContainer.style.cursor = 'pointer';
        if (isHovering != null) {
          isHovering.value = true;
        }
      },
      onHover: (PointerHoverEvent e) {},
      onExit: (PointerExitEvent e) {
        appContainer.style.cursor = 'default';
        if (isHovering != null) {
          isHovering.value = false;
        }
      },
      child: child,
    );
  }
}
