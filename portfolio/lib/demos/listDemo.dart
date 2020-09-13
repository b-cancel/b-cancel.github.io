import 'package:flutter/material.dart';
import 'package:portfolio/utils/sheet.dart';

enum _MaterialListType { oneLine, oneLineWithAvatar, twoLine, threeLine }

class ListDemo extends StatefulWidget {
  const ListDemo({Key key}) : super(key: key);

  @override
  _ListDemoState createState() => new _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  _MaterialListType _itemType = _MaterialListType.threeLine;
  bool _dense = false;
  bool _showAvatars = true;
  bool _showIcons = false;
  bool _showDividers = false;
  bool _reverseSort = false;
  List<String> items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

  IconData _backIcon() {
    return Icons.arrow_back;
  }

  //-------------------------Helper Functions
  //NOTE: these are required if you want buttons that will be opening or closing the sheet

  Sheet matSheet;
  toggleInstant() => matSheet.functions.toggleInstantaneous();
  toggleAnim() => matSheet.functions.toggleAnimated();
  openInstant() => matSheet.functions.openInstantaneous();
  closeInstant() => matSheet.functions.closeInstantaneous();
  openAnim() => matSheet.functions.openAnimated();
  closeAnim() => matSheet.functions.closeAnimated();

  bool testBool = true;

  @override
  Widget build(BuildContext context) {
    const scaffColor = Color(
        0xfffafafa); //manually read in from Theme.of(context).scaffoldBackgroundColor

    final String layoutText = _dense ? ' \u2013 Dense' : '';
    String itemTypeText;
    switch (_itemType) {
      case _MaterialListType.oneLine:
      case _MaterialListType.oneLineWithAvatar:
        itemTypeText = 'Single-line';
        break;
      case _MaterialListType.twoLine:
        itemTypeText = 'Two-line';
        break;
      case _MaterialListType.threeLine:
        itemTypeText = 'Three-line';
        break;
    }

    Iterable<Widget> listTiles =
        items.map((String item) => buildListTile(context, item));
    if (_showDividers)
      listTiles = ListTile.divideTiles(context: context, tiles: listTiles);

    matSheet = new Sheet(
      parameters: new Parameters(
        app: new MaterialApp(
          home: new Scaffold(
            key: scaffoldKey,
            appBar: new AppBar(
              leading: new IconButton(
                icon: new Icon(_backIcon()),
                alignment: Alignment.centerLeft,
                tooltip: 'Back',
                onPressed: () => print("there is nothing to Pop"),
              ),
              title: new Text('Scrolling list\n$itemTypeText$layoutText'),
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(Icons.sort_by_alpha),
                  tooltip: 'Sort',
                  onPressed: () {
                    setState(() {
                      _reverseSort = !_reverseSort;
                      items.sort((String a, String b) =>
                          _reverseSort ? b.compareTo(a) : a.compareTo(b));
                    });
                  },
                ),
                new IconButton(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Show menu',
                  onPressed: () => toggleAnim(),
                ),
              ],
            ),
            body: new Scrollbar(
              child: new ListView(
                padding: new EdgeInsets.symmetric(vertical: _dense ? 4.0 : 8.0),
                children: listTiles.toList(),
              ),
            ),
          ),
        ),
        sheet: new Container(
          decoration: const BoxDecoration(
            border: const Border(top: const BorderSide(color: Colors.black26)),
            color: scaffColor,
          ),
          child: new ListView(
            shrinkWrap: true,
            primary:
                false, //NOTE: if this is commented out behavior of scrolling will supercede that of closing the sheet
            children: <Widget>[
              new MergeSemantics(
                child: new ListTile(
                    dense: true,
                    title: const Text('One-line'),
                    trailing: new Radio<_MaterialListType>(
                      value: _showAvatars
                          ? _MaterialListType.oneLineWithAvatar
                          : _MaterialListType.oneLine,
                      groupValue: _itemType,
                      onChanged: changeItemType,
                    )),
              ),
              new MergeSemantics(
                child: new ListTile(
                    dense: true,
                    title: const Text('Two-line'),
                    trailing: new Radio<_MaterialListType>(
                      value: _MaterialListType.twoLine,
                      groupValue: _itemType,
                      onChanged: changeItemType,
                    )),
              ),
              new MergeSemantics(
                child: new ListTile(
                  dense: true,
                  title: const Text('Three-line'),
                  trailing: new Radio<_MaterialListType>(
                    value: _MaterialListType.threeLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  ),
                ),
              ),
              new MergeSemantics(
                child: new ListTile(
                  dense: true,
                  title: const Text('Show avatar'),
                  trailing: new Checkbox(
                    value: _showAvatars,
                    onChanged: (bool value) {
                      setState(() {
                        _showAvatars = value;
                      });
                    },
                  ),
                ),
              ),
              new MergeSemantics(
                child: new ListTile(
                  dense: true,
                  title: const Text('Show icon'),
                  trailing: new Checkbox(
                    value: _showIcons,
                    onChanged: (bool value) {
                      setState(() {
                        _showIcons = value;
                      });
                    },
                  ),
                ),
              ),
              new MergeSemantics(
                child: new ListTile(
                  dense: true,
                  title: const Text('Show dividers'),
                  trailing: new Checkbox(
                    value: _showDividers,
                    onChanged: (bool value) {
                      setState(() {
                        _showDividers = value;
                      });
                    },
                  ),
                ),
              ),
              new MergeSemantics(
                child: new ListTile(
                  dense: true,
                  title: const Text('Dense layout'),
                  trailing: new Checkbox(
                    value: _dense,
                    onChanged: (bool value) {
                      setState(() {
                        _dense = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return new Material(child: matSheet);
  }

  //--------------------------------------------------

  void changeItemType(_MaterialListType type) {
    setState(() {
      _itemType = type;
    });
  }

  Widget buildListTile(BuildContext context, String item) {
    Widget secondary;
    if (_itemType == _MaterialListType.twoLine) {
      secondary = const Text('Additional item information.');
    } else if (_itemType == _MaterialListType.threeLine) {
      secondary = const Text(
        'Even more additional list item information appears on line three.',
      );
    }
    return new MergeSemantics(
      child: new ListTile(
        isThreeLine: _itemType == _MaterialListType.threeLine,
        dense: _dense,
        leading: _showAvatars
            ? new ExcludeSemantics(
                child: new CircleAvatar(child: new Text(item)))
            : null,
        title: new Text('This item represents $item.'),
        subtitle: secondary,
        trailing: _showIcons
            ? new Icon(Icons.info, color: Theme.of(context).disabledColor)
            : null,
      ),
    );
  }
}
