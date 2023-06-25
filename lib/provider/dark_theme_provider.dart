import 'package:flutter/material.dart';

import '../shared_preferences/preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    SharedPreferencesUtils.setDarkTheme(value);
    notifyListeners();
  }
}