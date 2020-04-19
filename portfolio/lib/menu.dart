import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';
import 'package:portfolio/utils/hover.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
    @required this.scrollController,
    @required this.menuKey,
    @required this.isMenuOpen,
  }) : super(key: key);

  final ScrollController scrollController;
  final GlobalKey<State<StatefulWidget>> menuKey;
  final ValueNotifier<bool> isMenuOpen;

  getHeightFromKey(GlobalKey key){
    RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  //since we know all the height of every single region
  //we can calculate how much we need to scroll
  scrollToRegion(int index){
    double jumpPosition = topIntroHeight; //dont forget top bit
    for(int i = 0 ; i < index; i++){
      Region thisRegion = regions[i];
      jumpPosition += getHeightFromKey(thisRegion.headerKey);
      jumpPosition += getHeightFromKey(thisRegion.bodyKey);
    }

    //don't over scroll cuz overscrolling is gross
    ScrollPosition position = scrollController.position;
    double max = position.maxScrollExtent ?? 0;
    jumpPosition.clamp(0, max);

    //jump to the position
    //cuz animations are meh when ur trying to be functional
    scrollController.jumpTo(
      jumpPosition,
    );
  }

  //build
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
              child: ListView(
                children: List.generate(
                  regions.length,
                  (index) {
                    Region thisRegion = regions[index];
                    return MenuTileButton(
                      onTap: (){
                        scrollToRegion(index);
                        isMenuOpen.value = false;
                      },
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
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(),
        child: OpaqueOnHover(
          child: MenuTile(
            title: title, 
            icon: icon,
          ),
        )
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
                FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    icon,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}