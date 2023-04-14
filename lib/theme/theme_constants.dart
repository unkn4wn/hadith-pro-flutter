import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF609D92);
const colorOnPrimary = Colors.white;
const colorPrimaryContainer = Colors.white;
const colorOnPrimaryContainer = Colors.black;
const colorSecondary = Color(0xFF609D92);
const colorOnSecondary = Colors.white;
const colorTertiaryContainer = Color(0xFFF3EBE0);
const colorOnTertiaryContainer = Colors.black;
const colorBackground = Color(0xFFF7F8FA);
const colorOnBackground = Colors.black;
const colorSurfaceVariant = Color(0xFFF6FAF9);
const colorOnSurfaceVariant = Colors.black;
const colorError = Colors.white;
const colorOnError = Colors.white;

const colorPrimaryDark = Color(0xFF457064);
const colorOnPrimaryDark = Colors.white;
const colorPrimaryContainerDark = Color(0xFF232527);
const colorOnPrimaryContainerDark = Colors.white;
const colorSecondaryDark = Color(0xFF457064);
const colorOnSecondaryDark = Colors.white;
const colorTertiaryContainerDark = Color(0xFFDEC7A3);
const colorOnTertiaryContainerDark = Color(0xFF413F47);
const colorBackgroundDark = Color(0xFF121416);
const colorOnBackgroundDark = Colors.white;
const colorSurfaceVariantDark = Color(0x0f0f0f0f);
const colorOnSurfaceVariantDark = Colors.white;
const bottomNavigationDark = Color(0xFF191A1D);

const colorSchemeLight = ColorScheme.light(
    primary: colorPrimary,
    onPrimary: colorOnPrimary,
    primaryContainer: colorPrimaryContainer,
    onPrimaryContainer: colorOnPrimaryContainer,
    secondary: colorSecondary,
    onSecondary: colorOnSecondary,
    tertiaryContainer: colorTertiaryContainer,
    onTertiaryContainer: colorOnTertiaryContainer,
    background: colorBackground,
    onBackground: colorOnBackground,
    surfaceVariant: colorSurfaceVariant,
    onSurfaceVariant: colorOnSurfaceVariant,
    error: Colors.red,
    onError: Colors.white);

const colorSchemeDark = ColorScheme.dark(
  primary: colorPrimaryDark,
  onPrimary: colorOnPrimaryDark,
  primaryContainer: colorPrimaryContainerDark,
  onPrimaryContainer: colorOnPrimaryContainerDark,
  secondary: colorSecondaryDark,
  onSecondary: colorOnSecondaryDark,
  tertiaryContainer: colorTertiaryContainerDark,
  onTertiaryContainer: colorOnTertiaryContainerDark,
  background: colorBackgroundDark,
  onBackground: colorOnBackgroundDark,
  surfaceVariant: colorSurfaceVariantDark,
  onSurfaceVariant: colorOnSurfaceVariantDark,
  error: Colors.red,
  onError: Colors.white,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006B5F),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF75F8E3),
  onPrimaryContainer: Color(0xFF00201C),
  secondary: Color(0xFF4A635E),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCDE8E1),
  onSecondaryContainer: Color(0xFF06201C),
  tertiary: Color(0xFF755B00),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDF90),
  onTertiaryContainer: Color(0xFF241A00),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFDFB),
  onBackground: Color(0xFF191C1B),
  surface: Color(0xFFFAFDFB),
  onSurface: Color(0xFF191C1B),
  surfaceVariant: Color(0xFFDAE5E1),
  onSurfaceVariant: Color(0xFF3F4946),
  outline: Color(0xFF6F7976),
  onInverseSurface: Color(0xFFEFF1EF),
  inverseSurface: Color(0xFF2D3130),
  inversePrimary: Color(0xFF55DBC7),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006B5F),
  outlineVariant: Color(0xFFBEC9C5),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF55DBC7),
  onPrimary: Color(0xFF003731),
  primaryContainer: Color(0xFF005047),
  onPrimaryContainer: Color(0xFF75F8E3),
  secondary: Color(0xFFB1CCC6),
  onSecondary: Color(0xFF1C3530),
  secondaryContainer: Color(0xFF334B47),
  onSecondaryContainer: Color(0xFFCDE8E1),
  tertiary: Color(0xFFECC248),
  onTertiary: Color(0xFF3D2E00),
  tertiaryContainer: Color(0xFF584400),
  onTertiaryContainer: Color(0xFFFFDF90),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1B),
  onBackground: Color(0xFFE0E3E1),
  surface: Color(0xFF191C1B),
  onSurface: Color(0xFFE0E3E1),
  surfaceVariant: Color(0xFF3F4946),
  onSurfaceVariant: Color(0xFFBEC9C5),
  outline: Color(0xFF899390),
  onInverseSurface: Color(0xFF191C1B),
  inverseSurface: Color(0xFFE0E3E1),
  inversePrimary: Color(0xFF006B5F),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF55DBC7),
  outlineVariant: Color(0xFF3F4946),
  scrim: Color(0xFF000000),
);

ThemeData lightTheme = ThemeData(
    colorScheme: colorSchemeLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: colorBackground,
      selectedItemColor: colorPrimary,
    ));

ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: colorBackgroundDark,
      selectedItemColor: colorPrimaryDark,
    ));
