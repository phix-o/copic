import 'package:flutter/material.dart';

import 'package:copic/common/extensions.dart';

class ColorShape {
  final String name;
  final Color color;
  final String svgUrl;
  final Color shadowColor;

  ColorShape({
    required this.name,
    required this.color,
    required this.svgUrl,
    required this.shadowColor,
  });

  static ColorShape fromJson(Map<String, String> json) {
    Color color = HexColor.fromHex(json['color']!);
    Color shadowColor = json['shadowColor'] != null
        ? HexColor.fromHex(json['shadowColor']!)
        : color;

    return ColorShape(
      name: json['name']!,
      color: color,
      svgUrl: json['svgUrl']!,
      shadowColor: shadowColor,
    );
  }
}

List<ColorShape> colors = [
  {'name': 'red', 'color': '#FFFF0000', 'svgUrl': 'assets/shapes/rect.svg'},
  {'name': 'green', 'color': '#FF00FF00', 'svgUrl': 'assets/shapes/circle.svg'},
  {
    'name': 'blue',
    'color': '#FF0000FF',
    'svgUrl': 'assets/shapes/triangle.svg'
  },
  {'name': 'pink', 'color': '#FFFF00FF', 'svgUrl': 'assets/shapes/star.svg'},
  {
    'name': 'black',
    'color': '#FFF000000',
    'svgUrl': 'assets/shapes/poly-5.svg'
  },
  {
    'name': 'white',
    'color': '#FFFFFFFF',
    'shadowColor': '#FF000000',
    'svgUrl': 'assets/shapes/poly-3.svg'
  },
  {
    'name': 'orange',
    'color': '#FFFF7700',
    'svgUrl': 'assets/shapes/poly-8.svg'
  },
].map((color) => ColorShape.fromJson(color)).toList();
