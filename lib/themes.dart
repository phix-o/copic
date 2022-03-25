import 'package:copic/config/constants.dart';
import 'package:flutter/material.dart';

// TODO Find better way to use common themes
ThemeData commonTheme = ThemeData(
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  textTheme: const TextTheme(
      button: TextStyle(
    color: kBtnTextColor,
    fontSize: 20,
  )),
);

ThemeData themeLight() {
  ThemeData light = ThemeData.light();
  ThemeData theme = light.copyWith(
    cardTheme: light.cardTheme.copyWith(
      shape: commonTheme.cardTheme.shape,
    ),
    textTheme: light.textTheme.copyWith(
      button: commonTheme.textTheme.button,
    ),
  );

  return theme.copyWith(
    primaryColor: kPrimaryColor,
  );
}

ThemeData themeDark() {
  ThemeData dark = ThemeData.dark();
  ThemeData theme = dark.copyWith(
    cardTheme: dark.cardTheme.copyWith(
      shape: commonTheme.cardTheme.shape,
    ),
    textTheme: dark.textTheme.copyWith(
      button: commonTheme.textTheme.button,
    ),
  );

  return theme.copyWith(
    primaryColor: kPrimaryColor,
    cardColor: kSurfaceColorDark,
  );
}
