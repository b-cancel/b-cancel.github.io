import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:portfolio/icons/extra_brand_icons_icons.dart';

class Tool {
  Color color;
  IconData icon;
  String iconSymbol;
  List<Tool> usedWith;

  Tool({
    @required this.color,
    @required this.icon,
    this.iconSymbol,
    this.usedWith,
  });
}

List<Color> dartFlutterBlues = [
  Color(0xFF045597), //dark blue
  Color(0xFF2AB2EE), //light blue
];

List<Color> cBlues = [
  Color(0xFF004283), //dark
  Color(0xFF00589D), //mid
  Color(0xFF659BD3), //light
];

Map<String, List<Tool>> experienceToTools = {
  "a lot": [
    Tool( //dart
      color: dartFlutterBlues[0],
      icon: ExtraBrandIcons.dart,
    ),
    Tool(
      color: dartFlutterBlues[1],
      icon: BrandIcons.flutter,
    ),
    Tool( //C#
      color: [
        Color(0xFF68217A), //dark
        Color(0xFF822C98), //mid
        Color(0xFF953DAC), //light
      ][0],
      icon: BrandIcons.cplusplus,
      iconSymbol: "#",
    ),
    Tool(
      icon: BrandIcons.unity,
      color: [
        Colors.black,
        Color(0xFF4A5766),
      ][1],
    ),
    Tool(
      color: [
        //yellows
        Color(0xFFE8A32B),
        Color(0xFFE6C71D),
        Color(0xFFF0D91D),
        //green for new shield
        Color(0xFF63A814),
        Color(0xFF8ACF17),
      ][2],
      icon: BrandIcons.javascript,
    ),
    Tool(
      color: [
        Color(0xFFE44D26),
        Color(0xFFF16529),
      ][0],
      icon: BrandIcons.html5,
    ),
    Tool(
      color: [
        Color(0xFF0070BA),
        Color(0xFF29A8E0),
      ][0],
      icon: BrandIcons.css3,
    ),
    Tool(
      color: [
        Color(0xFFE11C1F),
        Color(0xFF096EB6),
      ][0],
      icon: BrandIcons.java,
    ),
    Tool(
      color: [
        Color(0xFF002732),
        Color(0xFF00D4FD),
      ][1],
      icon: ExtraBrandIcons.adobephotoshop,
    ),
    Tool(
      color: [
        Color(0xFF380842),
        Color(0xFFE788FE),
      ][1],
      icon: ExtraBrandIcons.adobepremiere,
    ),
  ],
  "competent": [
    Tool(
      color: Colors.red,
      icon: BrandIcons.ruby,
    ),
    Tool(
      color: Colors.red,
      icon: BrandIcons.rails,
    ),
    Tool(
      color: Colors.black,
      icon: BrandIcons.github,
    ),
    Tool(
      icon: BrandIcons.visualstudiocode,
      color: [
        Color(0xFF1476B3),
        Color(0xFF1489D2),
        Color(0xFF45B0F3),
      ][1],
    ),
  ],
  "familiar": [
    Tool( 
      icon: ExtraBrandIcons.visualstudio, 
      color: [
        Color(0xFF5E259B),
        Color(0xFF803DBD),
        Color(0xFF9556CE),
        Color(0xFFBA89F2),
      ][1],
    ),
    Tool(
      color: [
        Color(0xFF6280B6),
        Color(0xFF8B9ACB),
        Color(0xFF4563C6),
      ][2],
      icon: BrandIcons.php,
    ),
    Tool(
      color: cBlues[0],
      icon: BrandIcons.cplusplus,
    ),
    Tool( //actually C
      color: cBlues[2],
      icon: BrandIcons.cplusplus,
      iconSymbol: "",
    ),
    Tool(
      color: Colors.grey,
      icon: BrandIcons.python,
    ),
    Tool(
      color: Color(0xFF2580F8),
      icon: BrandIcons.bitbucket,
    ),
  ],
};