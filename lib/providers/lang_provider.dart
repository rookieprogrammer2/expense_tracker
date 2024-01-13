// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // Observable/ Subject/ Provider
// class SettingsProvider extends ChangeNotifier {
//
//   ThemeMode themeMode = ThemeMode.light;
//   String currentLocale = "en";
//   late final SharedPreferences prefs;
//
//   void init () async{
//     prefs = await SharedPreferences.getInstance();
//     currentLocale = prefs.getString("currentLocale") ?? "en";
//   }
// /*  Here, when the "init" method is called in the
//   main function, the new "currentLocale" value which
//   will have been set by the "getLanguage" method below
//   is going to be swapped with the current value of
//   "currentLocale" using the "getString" method, which
//   would change the language of the app.  */
//
//   void getLanguage (String newLocale) async {
//     currentLocale = newLocale;
//     await prefs.setString("currentLocale", newLocale);
//     /*  The above line is the first action that happens
//     when the user changes the language. It swaps the
//     value of the "currentLocale" variable with the
//     new value and maps it to it.  */
//     notifyListeners();
//   }
//
//
//
//
// }