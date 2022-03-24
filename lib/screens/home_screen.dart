import 'package:copic/common/widgets.dart';
import 'package:copic/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackground(context),
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
                  onPressed: () {},
                  label: 'Start Game',
                )
              ],
            ),
          ),
          _buildBottomNav()
        ],
      ),
    );
  }

  List<Widget> _buildBackground(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return [
      Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ))),
      Container(
          width: size.width,
          height: size.height,
          color: kPrimaryColor.withOpacity(0.48)),
    ];
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: kAppPaddingValue + 10,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.settings_outlined,
              color: Colors.white.withOpacity(0.6),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
