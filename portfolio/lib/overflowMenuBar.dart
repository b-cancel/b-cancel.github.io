import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//NOTE: modified version of plugin

/// A widget that can take action buttons and dynamically drop them
/// into an overflow menu based on the available space.
class DynamicOverflowMenuBar extends StatefulWidget {
  final List<OverFlowMenuItem> actions;
  final Widget title;
  const DynamicOverflowMenuBar({
    Key key,
    @required this.actions,
    this.title,
  }) : super(key: key);

  @override
  _DynamicOverflowMenuBarState createState() => _DynamicOverflowMenuBarState();
}

class _DynamicOverflowMenuBarState extends State<DynamicOverflowMenuBar> {
  final overFlowMenuConstraints = BoxConstraints(minWidth: 48);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double titleRowConstraints =
            constraints.maxWidth - overFlowMenuConstraints.minWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (widget.title != null)
              LimitedBox(
                maxWidth: titleRowConstraints,
                child: widget.title,
              ),
            Expanded(
              child: ConstrainedBox(
                constraints: overFlowMenuConstraints,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    int availableSlots = (constraints.maxWidth / 48).floor();

                    if (availableSlots < 1) {
                      return ErrorWidget('The available space is too small '
                          'for this widget to be built on the screen.');
                    }
                    // subtracting 1 if there isn't enough space because the
                    // overflow button will count as one.
                    int numberOfActionsToShow;
                    if (availableSlots < widget.actions.length) {
                      numberOfActionsToShow = availableSlots - 1;
                    }
                    if (availableSlots == widget.actions.length) {
                      numberOfActionsToShow = availableSlots;
                    }
                    List<OverFlowMenuItem> visibleWidgets =
                        widget.actions.take(numberOfActionsToShow).toList();
                    Iterable<OverFlowMenuItem> remainingActions = [];
                    if (widget.actions.length > availableSlots) {
                      remainingActions = widget.actions
                          .getRange(
                              numberOfActionsToShow, widget.actions.length)
                          .toList();
                    }

                    return OverFlowMenu(
                      visibleWidgets: visibleWidgets,
                      remainingActions: remainingActions,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OverFlowMenu extends StatelessWidget {
  const OverFlowMenu({
    Key key,
    @required this.visibleWidgets,
    @required this.remainingActions,
  }) : super(key: key);

  final List<OverFlowMenuItem> visibleWidgets;
  final Iterable<OverFlowMenuItem> remainingActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...visibleWidgets,
        if (remainingActions.isNotEmpty)
          PopupMenuButton<OverFlowMenuItem>(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.more_vert),
            onSelected: (item) => item.onPressed(),
            itemBuilder: (BuildContext context) {
              return [
                for (OverFlowMenuItem button in remainingActions)
                  PopupMenuItem(
                    value: button,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            right: 6,
                          ),
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Icon(
                              button.icon,
                            ),
                          ),
                        ),
                        Text(
                          button.label,
                        ),
                      ],
                    ),
                  ),
              ];
            },
          )
      ],
    );
  }
}

class OverFlowMenuItem extends StatefulWidget {
  final Widget child;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  Future<Size> get size => _sizeCompleter.future;
  final Completer<Size> _sizeCompleter = Completer();

  OverFlowMenuItem({
    @required this.child,
    @required this.icon,
    @required this.label,
    @required this.onPressed,
  });

  @override
  _OverFlowMenuItemState createState() {
    var overFlowMenuItemState = _OverFlowMenuItemState();
    if (!_sizeCompleter.isCompleted) {
      overFlowMenuItemState.size.then((size) {
        _sizeCompleter.complete(size);
      });
    }
    return overFlowMenuItemState;
  }
}

class _OverFlowMenuItemState extends State<OverFlowMenuItem> {
  Completer<Size> sizeCompleter = Completer();
  final GlobalKey _key = GlobalKey();

  Future<Size> get size {
    return sizeCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      RenderBox _itemBox = _key.currentContext.findRenderObject();
      final Size size = _itemBox.size;
      sizeCompleter.complete(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
