import 'package:copic/common/functional.dart';
import 'package:copic/common/widgets/widgets.dart';
import 'package:copic/screens/colors/colors_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
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
          BottomNav(onPressed: () {}, icon: Icons.settings_outlined),
        ],
      ),
    );
  }

  _startGame(BuildContext context) {
    Navigator.of(context).pushNamed(ColorsViewScreen.routeName);
  }
}
