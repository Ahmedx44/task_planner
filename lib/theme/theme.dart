import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    onSurface: Colors.white,
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.grey[200]!,
    onPrimary: Colors.white,
    onPrimaryContainer: Colors.grey.shade600,
    onSecondary: Colors.black,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
    titleMedium: TextStyle(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(color: Colors.black54, fontSize: 16),
    labelSmall: TextStyle(color: Colors.black54, fontSize: 12),
    labelLarge: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
  ),
);

final ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    onSurface: Colors.grey.shade900,
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.grey[800]!,
    onPrimary: Colors.white,
    onPrimaryContainer: Colors.grey.shade600,
    onSecondary: Colors.white,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    titleMedium: TextStyle(
        color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(color: Colors.white60, fontSize: 16),
    labelSmall: TextStyle(color: Colors.white60, fontSize: 12),
    labelLarge: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
