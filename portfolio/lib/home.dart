//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/html.dart';

//internal: other
import 'package:portfolio/main.dart';

//widgets
class Home extends StatefulWidget {
  //handles the menu
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<bool> isMenuOpen = new ValueNotifier<bool>(false);
  final GlobalKey menuKey = GlobalKey();
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);
  final ValueNotifier<bool> topScrolledAway = new ValueNotifier<bool>(false);

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    window.location.reload();
    //html.window.location.assign();
    /*
    html.window.location.replace(
      "http://b-cancel.github.io/",
    );
    */
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return 

    /*
    return AnimatedBuilder(
      animation: isMenuOpen,
      child: Stack(
        children: <Widget>[
          SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView(
              primary: false,
              //physics: BouncingScrollPhysics(),
              //so scrolling up and down with a finger keeps things in view
              //cacheExtent: MyApp.screenHeight,
              controller: scrollController,
              children: [
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
                Text("1\n\n\\n\n\\n\n\n\n\n\n\nn\n2"),
              ],
            ),
          ),
          /*
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ScrollBar(
                    scrollController: scrollController,
                    //here they are updated
                    topScrolledAway: topScrolledAway,
                    overScroll: overScroll,
                    onTop: onTop,
                  ),
                ),*/
        ],
      ),
      builder: (_, Widget reusableChild) {
        final keyContext = menuKey.currentContext;

        //grab the shift value from the menu size
        double shiftValue = 0;
        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          shiftValue = box.size.width;
        }

        //shift if needed
        return Scaffold(
          appBar: AppBar(
            title: Text("Bryan"),
            actions: <Widget>[
              AnimatedBuilder(
                animation: isMenuOpen,
                child: IconButton(
                  icon: Icon(
                    PortfolioIcons.menu,
                  ),
                  onPressed: () {
                    isMenuOpen.value = true;
                  },
                ),
                builder: (context, child) {
                  return Visibility(
                    visible: isMenuOpen.value == false,
                    child: child,
                  );
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(
                    (isMenuOpen.value) ? -shiftValue : 0,
                    0,
                  ),
                  child: reusableChild,
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: isMenuOpen.value,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                  child: SideMenu(
                    scrollController: scrollController,
                    menuKey: menuKey,
                    isMenuOpen: isMenuOpen,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    */
  }
}
