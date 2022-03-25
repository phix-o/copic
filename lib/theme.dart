import 'package:copic/config/constants.dart';
import 'package:flutter/material.dart';

ThemeData themeLight() {
  ThemeData theme = ThemeData.light();

  return theme.copyWith(
    primaryColor: kPrimaryColor,
    textTheme: theme.textTheme.copyWith(
      button: theme.textTheme.button?.copyWith(
        color: kBtnTextColor,
        fontSize: 20,
      ),
    ),
    cardTheme: theme.cardTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

ThemeData themeDark() {
  ThemeData theme = ThemeData.light();

  return theme.copyWith(
    primaryColor: kPrimaryColor,
    textTheme: theme.textTheme.copyWith(
      button: theme.textTheme.button?.copyWith(
        color: kBtnTextColor,
        fontSize: 20,
      ),
    ),
  );
}
