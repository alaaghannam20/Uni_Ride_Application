import 'package:flutter/material.dart';

extension AppThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Backgrounds
  Color get bgColor     => isDark ? const Color(0xFF1A1D2E) : const Color(0xFFF5F7FA);
  Color get bgWhite     => isDark ? const Color(0xFF1A1D2E) : const Color(0xFFFFFFFF);
  Color get bgCard      => isDark ? const Color(0xFF252836) : const Color(0xFFFFFFFF);
  Color get bgSubtle    => isDark ? const Color(0xFF2D3045) : const Color(0xFFF9FAFB);

  // Text
  Color get textPrimary   => isDark ? const Color(0xFFE8ECF4) : const Color(0xFF101828);
  Color get textSecondary => isDark ? const Color(0xFF8B95B0) : const Color(0xFF6A7282);
  Color get textHint      => isDark ? const Color(0xFF5C667A) : const Color(0xFF9CA3AF);

  // Borders
  Color get borderColor => isDark ? const Color(0xFF3A4060) : const Color(0xFFE5E7EB);

  // AppBar
  Color get appBarBg => isDark ? const Color(0xFF1E2235) : const Color(0xFFFFFFFF);
}
