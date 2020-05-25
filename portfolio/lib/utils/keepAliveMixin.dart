//flutter
import 'package:flutter/material.dart';

//widget
class KeepAliveMixin extends StatefulWidget {
  const KeepAliveMixin({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAliveMixinState createState() => _KeepAliveMixinState();
}

class _KeepAliveMixinState extends State<KeepAliveMixin>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //fixing must call super problem
    //https://dart.dev/tools/diagnostic-messages#must_call_super
    super.build(context);

    //actual build
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}