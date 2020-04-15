//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

//widget
class SliverSection extends StatelessWidget {
  SliverSection({
    @required this.title,
    this.icon,
    @required this.body,
    this.initiallyOpened: false,
  });

  final String title;
  final Icon icon;
  final Widget body;
  final bool initiallyOpened;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 60.0,
        color: Colors.lightBlue,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          'Header #0',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            leading: CircleAvatar(
              child: Text('0'),
            ),
            title: Text('List tile #$i'),
          ),
          childCount: 4,
        ),
      ),
    );
  }
}
