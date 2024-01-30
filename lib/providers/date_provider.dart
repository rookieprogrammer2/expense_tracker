import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  var currentDate = DateTime.now();
  bool showAllExpenses = true;

  changeCurrentDate (DateTime newDate) {
    currentDate = newDate;
    notifyListeners();
  }

  toggleShowAllExpenses () {
    showAllExpenses = false;
    notifyListeners();
  }
}