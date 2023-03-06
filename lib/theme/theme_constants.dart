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
const colorOnSecondaryDark = Colors.black;
const colorBackgroundDark = Color(0xFF161616);
const colorOnBackgroundDark = Colors.white;
const colorSurfaceDark = Colors.black;
const colorOnSurfaceDark = Colors.white;
const colorSurfaceVariantDark = Color(0x0f0f0f0f);
const colorOnSurfaceVariantDark = Colors.white;
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
  secondary: colorSecondaryDark,
  onSecondary: colorOnSecondaryDark,
  background: colorBackgroundDark,
  onBackground: colorOnBackgroundDark,
  surface: colorSurfaceDark,
  onSurface: colorOnSurfaceDark,
  surfaceVariant: colorSurfaceVariantDark,
  onSurfaceVariant: colorOnSurfaceVariantDark,
  error: Colors.red,
  onError: Colors.white,
);

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: colorBackground,
    colorScheme: colorSchemeLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorBackground,
      selectedItemColor: colorPrimary,
    ));

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: colorBackgroundDark,
    colorScheme: colorSchemeDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorBackgroundDark,
      selectedItemColor: colorPrimaryDark,
    ));
