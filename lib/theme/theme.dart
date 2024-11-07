import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    surface: Color.fromARGB(255, 234, 236, 238),
    onSurface: Color.fromARGB(255, 212, 212, 212),
    onSecondary: Colors.black87,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.black87, fontSize: 28, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    titleMedium: TextStyle(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(color: Colors.black54, fontSize: 16),
    labelSmall: TextStyle(color: Colors.black54, fontSize: 12),
    labelLarge: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
  ),
);

final ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Colors.blue,
    onPrimary: Color.fromARGB(255, 20, 20, 20),
    surface: Color.fromARGB(255, 31, 31, 31),
    onSurface: Color.fromARGB(255, 26, 26, 26),
    onSecondary: Colors.white,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        color: Colors.white70, fontSize: 28, fontWeight: FontWeight.w600),
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
