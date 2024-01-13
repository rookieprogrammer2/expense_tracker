import 'package:flutter/material.dart';

abstract class AppTheme {
  static var lightMode = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        iconTheme: IconThemeData(
            color: Colors.black,
        ),

    ),
    colorScheme: const ColorScheme.light(),
  );
}