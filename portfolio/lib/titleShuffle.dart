import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:portfolio/main.dart';

class Logo extends StatelessWidget {
  Logo({
    Key key,
  }) : super(key: key);

  getLongestString(List<String> strings) {
    String longestFirst = "";
    for (int i = 0; i < strings.length; i++) {
      if (strings[i].length > longestFirst.length) {
        longestFirst = strings[i];
      }
    }
    return longestFirst;
  }

  final ValueNotifier<int> firstVN = new ValueNotifier<int>(0);
  final ValueNotifier<int> secondVN = new ValueNotifier<int>(0);

  final Duration delay = Duration(milliseconds: 1700);
  final Duration animation = Duration(milliseconds: 300);
  startShuffle() async {
    await Future.delayed(delay);
    secondVN.value++;
    await Future.delayed(delay);
    firstVN.value++;
    await Future.delayed(delay);
    firstVN.value++;
    await Future.delayed(delay);
    secondVN.value++;
    await Future.delayed(delay);
    firstVN.value++;
    secondVN.value--;
    await Future.delayed(delay);
    secondVN.value++;
    await Future.delayed(delay);
    firstVN.value++;
    await Future.delayed(delay);
    firstVN.value = 0;
    secondVN.value = 0;
    startShuffle();
  }

  @override
  Widget build(BuildContext context) {
    startShuffle();

    //items to shuffle through
    List<String> first = ["Software", "App", "Web", "Game", "UX"];
    String longestFirst = getLongestString(first);
    List<String> second = ["Engineer", "Developer", "Designer"];
    String longestSecond = getLongestString(second);

    //return
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: MyApp.h3,
        ),
        child: ClipRRect(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 320,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "I'm a ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  //Software, App, Web, Game, UX
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Opacity(
                          opacity: 0,
                          child: Text(longestFirst),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: List.generate(
                            first.length,
                            (index) {
                              return AnimatedTitle(
                                vn: firstVN,
                                text: first[index],
                                index: index,
                                fontSize: MyApp.h3,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Engineer, Developer, Designer
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Opacity(
                          opacity: 0,
                          child: Text(longestSecond),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: List.generate(
                            second.length,
                            (index) {
                              return AnimatedTitle(
                                vn: secondVN,
                                text: second[index],
                                index: index,
                                fontSize: MyApp.h3,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  AnimatedTitle({
    @required this.vn,
    @required this.text,
    @required this.index,
    @required this.fontSize,
  });

  final ValueNotifier<int> vn;
  final String text;
  final int index;
  final double fontSize;

  double valueToPosition(ValueNotifier<int> vn) {
    if (vn.value == index) {
      return 0;
    } else {
      if (vn.value > index) {
        return -1;
      } else {
        return 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //set whatever end was to begin
      //set new end
      //so trigger animation on end
      animation: vn,
      builder: (context, child) {
        return AnimatedContainer(
          duration: kTabScrollDuration,
          transform: Matrix4Transform()
              .translate(
                y: valueToPosition(vn) * (fontSize * 2),
              )
              .matrix4,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        );
      },
    );
  }
}