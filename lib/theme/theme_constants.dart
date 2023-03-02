import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF50A89B);
const colorOnPrimary = Colors.white;
const colorSecondary = Color(0xFFF3EBE0);
const colorBackground = Color(0xFFE6E6E6);
const bottomNavigation = Colors.white;

const colorPrimaryDark = Color(0xFF50A89B);
const bottomNavigationDark = Color(0xFF191A1D);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(),
);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ));
