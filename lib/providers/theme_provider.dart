import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  void init () {

  }
  ThemeMode currentTheme = ThemeMode.system;

  changeTheme (){
    if (_themeData == lightMode) {
      currentTheme = ThemeMode.dark;
    } else {
      currentTheme = ThemeMode.light;
    }
  }

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool isDark () {
    return _themeData == darkMode;
  }

  set themeData (ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> toggleTheme () async {
    if (_themeData == lightMode) {
      themeData = darkMode;
      changeTheme();
    } else {
      themeData = lightMode;
      changeTheme();
    }
  }

  static final darkMode = AppTheme.darkMode;
  static final lightMode = AppTheme.lightMode;
}
