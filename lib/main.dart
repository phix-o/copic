import 'package:copic/screens/screens.dart';
import 'package:copic/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeLight(),
        darkTheme: themeDark(),
        themeMode: ThemeMode.light,
        initialRoute: HomeScreen.routeName,
        // initialRoute: ColorsGuessScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          ColorsViewScreen.routeName: (_) => const ColorsViewScreen(),
          ColorsGuessScreen.routeName: (_) => const ColorsGuessScreen(),
        });
  }
}
