import 'package:flutter/material.dart';

import 'package:copic/common/widgets/button.dart';
import 'package:copic/screens/home_screen.dart';

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
