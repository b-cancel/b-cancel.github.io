import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
    @required this.menuKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> menuKey;

  @override
  Widget build(BuildContext context) {
    //for the sake of making everything equal
    //and not using instrincWidth
    String longestMenuString = "";
    for(int i = 0; i < regions.length; i++){
      String title = regions[i].title;
      if(longestMenuString.length < title.length){
        longestMenuString = title;
      }
    }

    //build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.topRight,
      child: Container(
        key: menuKey,
        child: Stack(
          children: <Widget>[
            //sets up the size of all the others
            Opacity(
              opacity: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: MenuTile(
                  useMax: false, 
                  title: longestMenuString + "\t", 
                  icon: Icons.high_quality,
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                children: List.generate(
                  regions.length,
                  (index) {
                    Region thisRegion = regions[index];
                    return MenuTileButton(
                      title: thisRegion.title,
                      icon: thisRegion.icon,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTileButton extends StatelessWidget {
  const MenuTileButton({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  //final ValueNotifier<bool> hovering

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){

        },
        child: MenuTile(
          title: title, 
          icon: icon,
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
    this.useMax: true,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final bool useMax;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: useMax ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              //size of text in list tile
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0,
                  child: Icon(
                    Icons.menu,
                    //size of icon button
                    size: 24,
                  ),
                ),
                Icon(
                  icon,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}