import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/expenses_view.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'expense_tracker',
      themeMode: ThemeMode.dark,
      home: Expenses(),
    ),
  );
}