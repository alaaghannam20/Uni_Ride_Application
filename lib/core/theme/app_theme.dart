import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        cardColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF101828),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFCF8307),
          surface: Color(0xFFFFFFFF),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1D2E),
        cardColor: const Color(0xFF252836),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E2235),
          foregroundColor: Color(0xFFE8ECF4),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFCF8307),
          surface: Color(0xFF252836),
          onSurface: Color(0xFFE8ECF4),
        ),
      );
}
