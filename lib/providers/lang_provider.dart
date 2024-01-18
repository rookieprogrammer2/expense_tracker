import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {

  String currentLocale = "en";

  late final SharedPreferences prefs;

  void init () async{
    prefs = await SharedPreferences.getInstance();
    currentLocale = prefs.getString("currentLocale") ?? "en";
  }

  void changeLanguage (String newLocale) async {
    currentLocale = newLocale;
    await prefs.setString("currentLocale", newLocale);
    notifyListeners();
  }

}