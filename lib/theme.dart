import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfff1f1f1),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
        .copyWith(secondary: Colors.pink));

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
      .copyWith(secondary: Colors.pink),
);

class ThemeNotifier with ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _prefs;
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  // ThemeNotifier() {
  //   _darkTheme = true;
  //   _loadFromPrefs();
  // }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darkTheme);
  }
}
