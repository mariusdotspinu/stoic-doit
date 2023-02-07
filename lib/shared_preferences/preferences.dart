import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_PREF = "themePref";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_PREF, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_PREF) ?? false;
  }
}