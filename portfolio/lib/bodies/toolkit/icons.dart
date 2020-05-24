import 'package:flutter/material.dart';
import 'package:portfolio/bodies/toolkit/tools.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

class Tool {
  Color color;
  IconData icon;
  String label;
  String iconSymbol;

  Tool({
    @required this.color,
    @required this.icon,
    @required this.label,
    this.iconSymbol,
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
  highXP : [
    Tool( //dart
      color: dartFlutterBlues[0],
      icon: PortfolioIcons.dart,
      label: "Dart",
    ),
    Tool(
      color: dartFlutterBlues[1],
      icon: PortfolioIcons.flutter,
      label: "Flutter"
    ),
    Tool( //C#
      color: [
        Color(0xFF68217A), //dark
        Color(0xFF822C98), //mid
        Color(0xFF953DAC), //light
      ][0],
      icon: PortfolioIcons.cplusplus,
      iconSymbol: "#",
      label: "C#",
    ),
    Tool(
      icon: PortfolioIcons.unity,
      color: [
        Colors.black,
        Color(0xFF4A5766),
      ][1],
      label: "Unity 3D",
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
      icon: PortfolioIcons.js_square,
      label: "Javascript",
    ),
    Tool(
      color: [
        Color(0xFFE44D26),
        Color(0xFFF16529),
      ][0],
      icon: PortfolioIcons.html5,
      label: "HTML",
    ),
    Tool(
      color: [
        Color(0xFF0070BA),
        Color(0xFF29A8E0),
      ][0],
      icon: PortfolioIcons.css3_alt,
      label: "CSS",
    ),
    Tool(
      color: [
        Color(0xFFE11C1F),
        Color(0xFF096EB6),
      ][0],
      icon: PortfolioIcons.java,
      label: "Java",
    ),
    Tool(
      color: [
        Color(0xFF002732),
        Color(0xFF00D4FD),
      ][1],
      icon: PortfolioIcons.adobephotoshop,
      label: "Adobe\nPhotoshop",
    ),
    Tool(
      color: [
        Color(0xFF380842),
        Color(0xFFE788FE),
      ][1],
      icon: PortfolioIcons.adobepremiere,
      label: "Adobe\nPremiere",
    ),
  ],
  normalXP : [
    Tool(
      color: Colors.red,
      icon: PortfolioIcons.ruby,
      label: "Ruby",
    ),
    Tool(
      color: Colors.red,
      icon: PortfolioIcons.rails,
      label: "Ruby On Rails",
    ),
    Tool(
      color: Colors.black,
      icon: PortfolioIcons.github,
      label: "Github",
    ),
    Tool(
      icon: PortfolioIcons.visualstudiocode,
      color: [
        Color(0xFF1476B3),
        Color(0xFF1489D2),
        Color(0xFF45B0F3),
      ][1],
      label: "VS Code",
    ),
  ],
  lowXP : [
    Tool( 
      icon: PortfolioIcons.visualstudio, 
      color: [
        Color(0xFF5E259B),
        Color(0xFF803DBD),
        Color(0xFF9556CE),
        Color(0xFFBA89F2),
      ][1],
      label: "Visual Studios",
    ),
    Tool(
      color: [
        Color(0xFF6280B6),
        Color(0xFF8B9ACB),
        Color(0xFF4563C6),
      ][2],
      icon: PortfolioIcons.php,
      label: "PHP",
    ),
    Tool(
      color: cBlues[0],
      icon: PortfolioIcons.cplusplus,
      label: "C++",
    ),
    Tool( //actually C
      color: cBlues[2],
      icon: PortfolioIcons.cplusplus,
      iconSymbol: "",
      label: "C",
    ),
    Tool(
      color: Colors.grey,
      icon: PortfolioIcons.python,
      label: "Python",
    ),
    Tool(
      color: Color(0xFF2580F8),
      icon: PortfolioIcons.bitbucket,
      label: "Bitbucket"
    ),
  ],
};