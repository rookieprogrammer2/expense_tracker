import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  var currentDate = DateTime.now();


  changeCurrentDate (DateTime newDate) {
    currentDate = newDate;
    notifyListeners();
  }




}