import 'dart:math';

import 'package:copic/common/widgets/outlined_button.dart';
import 'package:copic/screens/colors/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorShapeTab extends HookWidget {
  final ColorShape colorShape;
  final List<ColorShape> colorsToTest;
  final void Function({ColorShape? color}) onAdvance;

  const ColorShapeTab({
    Key? key,
    required this.colorShape,
    required this.colorsToTest,
    required this.onAdvance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choices = useRef(_genColorChoices(colorShape));

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          width: 205,
          height: 205,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.black.withOpacity(0.25)),
            ),
          ),
          child: SvgPicture.asset(
            colorShape.svgUrl,
            color: colorShape.color,
          ),
        ),
        const SizedBox(height: 40),
        SingleChildScrollView(
          child: Wrap(
            runSpacing: 10.0,
            children: choices.value,
          ),
        ),
      ],
    );
  }

  List<Widget> _genColorChoices(ColorShape rightColor) {
    List<Widget> choices = [];

    for (var i = 0; i < 2; i++) {
      int generatedIdx = Random().nextInt(colorsToTest.length);
      ColorShape color = colorsToTest[generatedIdx];

      // while (color.name == rightColor.name) {
      //   generatedIdx = Random().nextInt(colorsToTest.length);
      //   color = colorsToTest[generatedIdx];

      //   debugPrint('Looping with: $generatedIdx $color');
      // }

      choices.add(CustomOutlinedButton(
          onPressed: () => onAdvance(color: color),
          label: color.name.toUpperCase()));
    }

    choices.insert(
      Random().nextInt(choices.length),
      CustomOutlinedButton(
          onPressed: () => onAdvance(color: rightColor),
          label: rightColor.name.toUpperCase()),
    );

    return choices;
  }
}
