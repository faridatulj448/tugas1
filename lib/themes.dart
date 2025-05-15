import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.indigo,
    secondary: Colors.indigoAccent,
  ),
);
