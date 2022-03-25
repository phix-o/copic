import 'package:copic/common/widgets/outlined_button.dart';
import 'package:copic/screens/colors/models.dart';
import 'package:flutter/material.dart';

import 'package:copic/config/constants.dart';
import 'package:copic/common/functional.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorsGuessScreen extends StatefulHookWidget {
  const ColorsGuessScreen({Key? key}) : super(key: key);

  static const routeName = '/colors-guess';

  @override
  State<ColorsGuessScreen> createState() => _ColorsGuessScreenState();
}

class _ColorsGuessScreenState extends State<ColorsGuessScreen> {
  final List<ColorShape> _colorsToTest = colors.toList()..shuffle();
  final Duration timePerColor = const Duration(seconds: 5);

  TabController? _tabController;
  AnimationController? _animationController;

  DateTime _lastColorAdvance = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _tabController = useTabController(initialLength: _colorsToTest.length);
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
    if (_animationController != null && !_animationController!.isAnimating) {
      _animationController!.forward();
    }

    return Scaffold(
      body: Stack(children: [
        ...buildScaffoldBackground(context),
        Center(
          child: Container(
            height: 520,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: kAppPaddingValue),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(value: animationValue),
                    const SizedBox(height: 30),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        // physics: const NeverScrollableScrollPhysics(
                        //     parent: ScrollPhysics()),
                        children: _buildTabs(),
                      ),
                    ),
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

      tabs.add(
        Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlinedButton(
                    onPressed: () => _advanceToNextColor(color: colorShape),
                    label: 'Orange'),
                CustomOutlinedButton(
                    onPressed: () => _advanceToNextColor(color: colorShape),
                    label: 'Red'),
              ],
            ),
          ],
        ),
      );
    }

    return tabs;
  }

  void _advanceToNextColor({ColorShape? color}) {
    TabController tabController = _tabController!;
    AnimationController animationController = _animationController!;

    if (tabController.index == _colorsToTest.length - 1) {
      return debugPrint('The end');
    }

    debugPrint("Current Index: ${tabController.index}");

    tabController.index += 1;
    animationController.reset();
  }
}
