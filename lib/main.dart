import 'package:flutter/material.dart';

import './common/functional.dart';
import './common/storage/storage.dart';
import './screens/screens.dart';
import './themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await LocalStorage.read('difficulty') == null) {
    await LocalStorage.save('difficulty', 'Easy');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: isAppDebug(),
        title: 'Copic',
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
