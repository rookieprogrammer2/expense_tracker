import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode currentTheme = ThemeMode.dark;
  late final SharedPreferences prefs;

  void init () async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isDark") == false) {
      currentTheme = ThemeMode.light;
    } else if (prefs.getBool("isDark") == true) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.dark;
    }
    notifyListeners();
  }

  void toggleTheme () async {
    if (currentTheme == ThemeMode.light) {
      currentTheme = ThemeMode.dark;
      await prefs.setBool("isDark", true);
    } else {
      currentTheme = ThemeMode.light;
      await prefs.setBool("isDark", false);
    }
    notifyListeners();
  }

  bool isDark () {
    return currentTheme == ThemeMode.dark;
  }

  static final darkMode = AppTheme.darkMode;
  static final lightMode = AppTheme.lightMode;
}