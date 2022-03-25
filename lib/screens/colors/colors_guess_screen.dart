import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:copic/screens/colors/models.dart';
import 'package:copic/screens/colors/widgets.dart';
import 'package:copic/config/constants.dart';
import 'package:copic/common/functional.dart';

class ColorsGuessScreen extends StatefulHookWidget {
  const ColorsGuessScreen({Key? key}) : super(key: key);

  static const routeName = '/colors-guess';

  @override
  State<ColorsGuessScreen> createState() => _ColorsGuessScreenState();
}

class _ColorsGuessScreenState extends State<ColorsGuessScreen> {
  final Duration timePerColor = const Duration(seconds: 5);

  List<ColorShape> _colorsToTest = colors..shuffle();
  TabController? _tabController;
  AnimationController? _animationController;

  DateTime _lastColorAdvance = DateTime.now();

  int _correctGuesses = 0;
  bool _isEndGame = false;

  @override
  void initState() {
    super.initState();

    _colorsToTest = _colorsToTest.getRange(0, 5).toList();
    debugPrint('$_colorsToTest');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _tabController = useTabController(initialLength: _colorsToTest.length + 1);
    _animationController = useAnimationController(
      duration: timePerColor,
    )..addStatusListener((status) {
        // debugPrint('State Change: $status');
        if (status != AnimationStatus.completed) return;

        DateTime now = DateTime.now();
        Duration thresholdTime =
            timePerColor - const Duration(milliseconds: 50);
        if (now.difference(_lastColorAdvance) < thresholdTime) return;

        _advanceToNextColor();
        _lastColorAdvance = now;
      });

    double animationValue = useAnimation(_animationController!);
    if (!_isEndGame && !_animationController!.isAnimating) {
      _animationController!.forward();
    }

    return Scaffold(
      body: Stack(children: [
        ...buildScaffoldBackground(context),
        Center(
          child: Container(
            height: 540,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: kAppPaddingValue),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    !_isEndGame
                        ? LinearProgressIndicator(value: animationValue)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 40),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(
                            parent: ScrollPhysics()),
                        children: _buildTabs(),
                      ),
                    ),
                    !_isEndGame
                        ? Text(
                            '${_tabController!.index + 1} of ${_colorsToTest.length}',
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> _buildTabs() {
    List<Widget> tabs = [];

    for (var i = 0; i < _colorsToTest.length; i++) {
      ColorShape colorShape = _colorsToTest[i];

      tabs.add(ColorShapeTab(
          colorShape: colorShape,
          colorsToTest: _colorsToTest,
          onAdvance: (ColorShape guessedColor) {
            if (guessedColor.name == colorShape.name) {
              setState(() {
                _correctGuesses += 1;
              });
            }

            _animationController?.stop();
            Future.delayed(
              const Duration(milliseconds: 300),
              () => _advanceToNextColor(),
            );
          }));
    }

    tabs.add(CompletionTab(
      score: _correctGuesses,
      total: _colorsToTest.length,
    ));
    return tabs;
  }

  void _advanceToNextColor() {
    TabController tabController = _tabController!;
    AnimationController animationController = _animationController!;

    if (tabController.index == _colorsToTest.length - 1) {
      setState(() {
        _isEndGame = true;
      });
      debugPrint('The end: $_correctGuesses');
    }

    debugPrint("Current Index: ${tabController.index} $_isEndGame");

    tabController.index =
        min(_colorsToTest.length + 1, tabController.index + 1);

    if (_isEndGame) {
      animationController.stop();
    } else {
      animationController.reset();
    }
  }
}
