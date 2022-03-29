import 'dart:math';

import 'package:copic/common/widgets/button.dart';
import 'package:copic/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:copic/common/widgets/outlined_button.dart';
import 'package:copic/screens/colors/models.dart';

class ColorShapeTab extends StatefulHookWidget {
  final ColorShape colorShape;
  final List<ColorShape> colorsToTest;
  final void Function(ColorShape color) onAdvance;

  const ColorShapeTab({
    Key? key,
    required this.colorShape,
    required this.colorsToTest,
    required this.onAdvance,
  }) : super(key: key);

  @override
  State<ColorShapeTab> createState() => _ColorShapeTabState();
}

class _ColorShapeTabState extends State<ColorShapeTab> {
  ColorShape? _chosenColor;

  get _isChosenColorCorrect {
    return _chosenColor?.name == widget.colorShape.name;
  }

  @override
  Widget build(BuildContext context) {
    final choices = useRef(_genColorChoices(widget.colorShape));

    Color? bgColor = Colors.transparent;
    Color borderColor = Colors.black.withOpacity(0.25);
    if (_chosenColor != null && _isChosenColorCorrect) {
      bgColor = Colors.green[100];
      borderColor = Colors.green.shade400;
    } else if (_chosenColor != null && !_isChosenColorCorrect) {
      bgColor = Colors.red[100];
      borderColor = Colors.red.shade400;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          width: 205,
          height: 205,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.fromBorderSide(
              BorderSide(color: borderColor),
            ),
          ),
          child: SvgPicture.asset(
            widget.colorShape.svgUrl,
            color: widget.colorShape.color,
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 100 / 40,
            children: choices.value,
          ),
        ),
      ],
    );
  }

  List<Widget> _genColorChoices(ColorShape rightColor) {
    List<Widget> choices = [];

    Map<String, ColorShape> chosenColors = {
      rightColor.name: rightColor,
    };
    for (var i = 0; i < 2; i++) {
      int generatedIdx = Random().nextInt(widget.colorsToTest.length);
      ColorShape color = widget.colorsToTest[generatedIdx];

      while (chosenColors[color.name] != null) {
        generatedIdx = Random().nextInt(widget.colorsToTest.length);
        color = widget.colorsToTest[generatedIdx];
      }

      chosenColors[color.name] = color;
      choices.add(CustomOutlinedButton(
        padding: const EdgeInsets.all(20),
        onPressed: () => _onColorChosen(color),
        label: color.name.toUpperCase(),
      ));
    }

    choices.insert(
      Random().nextInt(choices.length),
      CustomOutlinedButton(
        onPressed: () => _onColorChosen(rightColor),
        label: rightColor.name.toUpperCase(),
      ),
    );

    return choices;
  }

  void _onColorChosen(ColorShape color) {
    setState(() {
      _chosenColor = color;
    });

    debugPrint('Chosen color: ${_chosenColor?.name} ${color.name}');
    widget.onAdvance(color);
  }
}

class CompletionTab extends StatelessWidget {
  final int score;
  final int total;
  const CompletionTab({Key? key, required this.score, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    int percentage = ((score / total) * 100).toInt();

    return Column(
      children: [
        Text('Game complete 🎉', style: textTheme.headline5),
        const SizedBox(height: 20),
        Text('Your score was', style: textTheme.headline4),
        const SizedBox(height: 10),
        Text(
          '$percentage%',
          style: textTheme.headline1?.copyWith(fontSize: 80),
        ),
        Text('$score out of $total'),
        const SizedBox(height: 30),
        Button(onPressed: () => _goHome(context), label: 'Go Home'),
      ],
    );
  }

  _goHome(BuildContext context) {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}
