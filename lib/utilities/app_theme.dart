import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
);

abstract class AppTheme {

  static final darkMode = ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        brightness: Brightness.dark,

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: StadiumBorder(
              side: BorderSide(
                width: 3,
                color: Colors.white,
              ),
            ),
            iconSize: 19
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 53, 74, 83),
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
          selectedItemColor: Colors.white
        ),

        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),


        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),

      );


  static final lightMode = ThemeData().copyWith(
    brightness: Brightness.light,
    colorScheme: kColorScheme,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
          side: BorderSide(
            width: 3,
            color: Colors.white,
          ),
        ),
        iconSize: 19
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 53, 74, 83),
      showUnselectedLabels: false,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      selectedItemColor: Colors.white
    ),

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        )
    ),

    cardTheme: const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
        foregroundColor: kColorScheme.onPrimaryContainer,
      ),
    ),

  );



}