import 'package:flutter/material.dart';

import '../config/constants.dart';

List<Widget> buildScaffoldBackground(BuildContext context) {
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
