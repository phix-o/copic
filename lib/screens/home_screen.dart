import 'package:copic/common/functional.dart';
import 'package:copic/common/storage/storage.dart';
import 'package:copic/common/widgets/widgets.dart';
import 'package:copic/config/constants.dart';
import 'package:copic/screens/colors/colors_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          ...buildScaffoldBackground(context),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome To',
                    style: textTheme.headline4?.copyWith(color: Colors.white)),
                Text('Copic',
                    style: textTheme.headline1?.copyWith(color: Colors.white)),
                const SizedBox(height: 30),
                Button(
                  onPressed: () => _startGame(context),
                  label: 'Start Game',
                )
              ],
            ),
          ),
          BottomNav(
              onPressed: () async => await _showDialog(context),
              icon: Icons.settings_outlined),
        ],
      ),
    );
  }

  void _startGame(BuildContext context) {
    Navigator.of(context).pushNamed(ColorsViewScreen.routeName);
  }

  Future<void> _showDialog(BuildContext context) async {
    TextTheme textTheme = Theme.of(context).textTheme;
    String difficulty = await LocalStorage.read('difficulty');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          height: 300,
          child: Column(
            children: [
              Text('Choose your difficulty', style: textTheme.headline5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildDifficultyChoices(context, difficulty),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDifficultyChoices(
      BuildContext context, String difficulty) {
    List<String> difficulties = ['Easy', 'Medium', 'Hard'];

    List<Widget> diffWidgets = [];
    for (var d in difficulties) {
      bool isSelected = d.toLowerCase() == difficulty.toLowerCase();
      diffWidgets.add(GestureDetector(
        onTap: () {
          LocalStorage.save('difficulty', d);
          Navigator.of(context).pop();
        },
        child: Chip(
          label: Text(d),
          backgroundColor: isSelected ? kPrimaryColor : Colors.grey.shade100,
        ),
      ));
    }

    return diffWidgets;
  }
}
