import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = prefs.getString(key);

    if (result == null) return null;
    return json.decode(result);
  }

  static void save(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static void remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
