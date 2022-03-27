import 'package:flutter/material.dart';

import './shared_preferences.dart';

class LocalStorage {
  static read(String key) async {
    final val = await SharedPrefs.read(key);
    debugPrint('Val: $val');
    return val;
  }

  static save(String key, value) async {
    SharedPrefs.save(key, value);
  }

  static remove(String key) async {
    SharedPrefs.remove(key);
  }
}
