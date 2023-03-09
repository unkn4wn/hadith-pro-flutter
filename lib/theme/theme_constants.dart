import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF609D92);
const colorOnPrimary = Colors.white;
const colorSecondary = Color(0xFF609D92);
const colorOnSecondary = Colors.white;
const colorTertiary = Color(0xFFF3EBE0);
const colorOnTertiary = Colors.black;
const colorBackground = Color(0xFFF7F8FA);
const colorOnBackground = Colors.black;
const colorSurface = Colors.white;
const colorOnSurface = Colors.black;
const colorSurfaceVariant = Color(0xFFF6FAF9);
const colorOnSurfaceVariant = Colors.black;
const colorError = Colors.white;
const colorOnError = Colors.white;

const colorPrimaryDark = Color(0xFF457064);
const colorOnPrimaryDark = Colors.white;
const colorSecondaryDark = Color(0xFF457064);
const colorOnSecondaryDark = Colors.white;
const colorTertiaryDark = Color(0xFFDEC7A3);
const colorOnTertiaryDark = Color(0xFF413F47);
const colorBackgroundDark = Color(0xFF121416);
const colorOnBackgroundDark = Colors.white;
const colorSurfaceDark = Color(0xFF232527);
const colorOnSurfaceDark = Colors.white;
const colorSurfaceVariantDark = Color(0x0f0f0f0f);
const colorOnSurfaceVariantDark = Colors.white;
const bottomNavigationDark = Color(0xFF191A1D);

const colorSchemeLight = ColorScheme.light(
  primary: colorPrimary,
  onPrimary: colorOnPrimary,
  secondary: colorSecondary,
  onSecondary: colorOnSecondary,
  tertiary: colorTertiary,
  onTertiary: colorOnTertiary,
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
  tertiary: colorTertiaryDark,
  onTertiary: colorOnTertiaryDark,
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
