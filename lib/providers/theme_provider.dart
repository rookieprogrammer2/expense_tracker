import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode currentTheme = ThemeMode.dark;

  bool isDark () {
    return currentTheme == ThemeMode.dark;
  }

   void toggleTheme () {
    if (currentTheme == ThemeMode.light) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
    notifyListeners();
  }

  static final darkMode = AppTheme.darkMode;
  static final lightMode = AppTheme.lightMode;
}