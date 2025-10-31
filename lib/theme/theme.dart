import 'package:flutter/material.dart';

/// @description: Theme definitions following iOS Human Interface Guidelines
/// @author: jixiaoyong
/// @email: jixiaoyong1995@gmail.com
/// @date: 2023/3/20

// iOS Light Mode Colors (iOS Design Guidelines)
const Color _iosLightPrimary = Color(0xFF007AFF); // iOS System Blue
const Color _iosLightBackground = Color(0xFFF2F2F7); // iOS System Gray 6
const Color _iosLightSecondaryBackground =
    Color(0xFFFFFFFF); // iOS System Background
const Color _iosLightLabel = Color(0xFF000000);
const Color _iosLightSecondaryLabel = Color(0x3D000000); // ~24% opacity
const Color _iosLightTertiaryLabel = Color(0x29000000); // ~16% opacity
const Color _iosLightSeparator = Color(0xC6C6C8); // ~77% opacity
const Color _iosLightFill = Color.fromARGB(120, 69, 156, 232); // System Gray 4 with opacity

// iOS Dark Mode Colors
const Color _iosDarkPrimary = Color(0xFF0A84FF); // iOS System Blue (Dark)
const Color _iosDarkBackground =
    Color(0xFF000000); // iOS System Background (Dark)
const Color _iosDarkSecondaryBackground =
    Color(0xFF1C1C1E); // iOS System Gray 6 (Dark)
const Color _iosDarkLabel = Color(0xFFFFFFFF);
const Color _iosDarkSecondaryLabel = Color(0x99FFFFFF); // ~60% opacity
const Color _iosDarkTertiaryLabel = Color(0x66FFFFFF); // ~40% opacity
const Color _iosDarkSeparator = Color(0x38383A);
const Color _iosDarkFill = Color.fromARGB(120, 69, 156, 232);

final ThemeData kLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: false,
  // iOS System Blue
  primaryColor: _iosLightPrimary,
  // Background colors
  scaffoldBackgroundColor: _iosLightBackground,
  cardColor: _iosLightSecondaryBackground,
  // Interactive colors
  hoverColor: _iosLightFill,
  highlightColor: _iosLightFill,
  splashColor: _iosLightFill,
  // Text and label colors
  hintColor: _iosLightTertiaryLabel,
  // Divider and separator
  dividerColor: _iosLightSeparator,
  // Text theme following iOS typography
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: _iosLightLabel,
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.37,
    ),
    displayMedium: TextStyle(
      color: _iosLightLabel,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.36,
    ),
    displaySmall: TextStyle(
      color: _iosLightLabel,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.35,
    ),
    headlineLarge: TextStyle(
      color: _iosLightLabel,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.38,
    ),
    headlineMedium: TextStyle(
      color: _iosLightLabel,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
    ),
    bodyLarge: TextStyle(
      color: _iosLightLabel,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.41,
    ),
    bodyMedium: TextStyle(
      color: _iosLightLabel,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    ),
    bodySmall: TextStyle(
      color: _iosLightSecondaryLabel,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.08,
    ),
    labelLarge: TextStyle(
      color: _iosLightLabel,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    ),
    labelMedium: TextStyle(
      color: _iosLightSecondaryLabel,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.08,
    ),
  ),
  // Icon theme
  iconTheme: const IconThemeData(
    color: _iosLightLabel,
    size: 24,
  ),
  // Color scheme
  colorScheme: const ColorScheme.light(
    primary: _iosLightPrimary,
    primaryContainer: _iosLightFill,
    secondary: _iosLightSecondaryLabel,
    secondaryContainer: _iosLightFill,
    error: Color(0xFFFF3B30), // iOS System Red
    errorContainer: Color(0xFFFFEBEE),
    surface: _iosLightSecondaryBackground,
    surfaceVariant: _iosLightBackground,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    onSurface: _iosLightLabel,
    onSurfaceVariant: _iosLightSecondaryLabel,
    outline: _iosLightSeparator,
    outlineVariant: _iosLightSeparator,
    shadow: Colors.black,
  ),
);

final ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  // iOS System Blue (Dark)
  primaryColor: _iosDarkPrimary,
  // Background colors
  scaffoldBackgroundColor: _iosDarkBackground,
  cardColor: _iosDarkSecondaryBackground,
  // Interactive colors
  hoverColor: _iosDarkFill,
  highlightColor: _iosDarkFill,
  splashColor: _iosDarkFill,
  // Text and label colors
  hintColor: _iosDarkTertiaryLabel,
  // Divider and separator
  dividerColor: _iosDarkSeparator,
  // Text theme following iOS typography
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: _iosDarkLabel,
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.37,
    ),
    displayMedium: TextStyle(
      color: _iosDarkLabel,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.36,
    ),
    displaySmall: TextStyle(
      color: _iosDarkLabel,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.35,
    ),
    headlineLarge: TextStyle(
      color: _iosDarkLabel,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.38,
    ),
    headlineMedium: TextStyle(
      color: _iosDarkLabel,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
    ),
    bodyLarge: TextStyle(
      color: _iosDarkLabel,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.41,
    ),
    bodyMedium: TextStyle(
      color: _iosDarkLabel,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    ),
    bodySmall: TextStyle(
      color: _iosDarkSecondaryLabel,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.08,
    ),
    labelLarge: TextStyle(
      color: _iosDarkLabel,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.24,
    ),
    labelMedium: TextStyle(
      color: _iosDarkSecondaryLabel,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.08,
    ),
  ),
  // Icon theme
  iconTheme: const IconThemeData(
    color: _iosDarkLabel,
    size: 24,
  ),
  // Color scheme
  colorScheme: const ColorScheme.dark(
    primary: _iosDarkPrimary,
    primaryContainer: _iosDarkFill,
    secondary: _iosDarkSecondaryLabel,
    secondaryContainer: _iosDarkFill,
    error: Color(0xFFFF453A), // iOS System Red (Dark)
    errorContainer: Color(0x4DFF453A),
    surface: _iosDarkSecondaryBackground,
    surfaceVariant: _iosDarkBackground,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    onSurface: _iosDarkLabel,
    onSurfaceVariant: _iosDarkSecondaryLabel,
    outline: _iosDarkSeparator,
    outlineVariant: _iosDarkSeparator,
    shadow: Colors.black,
  ),
);
