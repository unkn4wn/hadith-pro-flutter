import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF50A89B);
const colorOnPrimary = Colors.white;
const colorSecondary = Color(0xFFF3EBE0);
const colorOnSecondary = Colors.black;
const colorBackground = Color(0xFFF5F6F8);
const colorOnBackground = Colors.black;
const colorSurface = Colors.white;
const colorOnSurface = Colors.black;
const colorSurfaceVariant = Color(0xFFF6FAF9);
const colorOnSurfaceVariant = Colors.black;
const colorError = Colors.white;
const colorOnError = Colors.white;

const colorPrimaryDark = Color(0xFF50A89B);
const colorOnPrimaryDark = Colors.white;
const colorSecondaryDark = Color(0xFFE7CCA9);
const bottomNavigationDark = Color(0xFF191A1D);

const colorSchemeLight = ColorScheme.light(
  primary: colorPrimary,
  onPrimary: colorOnPrimary,
  secondary: colorSecondary,
  onSecondary: colorOnSecondary,
  background: colorBackground,
  onBackground: colorOnBackground,
  surface: colorSurface,
  onSurface: colorOnSurface,
  surfaceVariant: colorSurfaceVariant,
  onSurfaceVariant: colorOnSurfaceVariant,
  error: Colors.red,
  onError: Colors.white,
);

const colorSchemeDark = ColorScheme.dark(
  primary: colorPrimaryDark,
  onPrimary: colorOnPrimaryDark,
  secondary: colorSecondary,
  onSecondary: Colors.black,
  background: colorBackground,
  onBackground: Colors.black,
  surface: Colors.grey,
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: colorBackground,
    colorScheme: colorSchemeLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorBackground,
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    secondaryHeaderColor: colorSecondary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ));
