import 'package:flutter/material.dart';

extension AppThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Backgrounds
  Color get bgColor     => isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA);
  Color get bgWhite     => isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
  Color get bgCard      => isDark ? const Color(0xFF252525) : const Color(0xFFFFFFFF);
  Color get bgSubtle    => isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF9FAFB);

  // Text
  Color get textPrimary   => isDark ? const Color(0xFFFFFFFF) : const Color(0xFF101828);
  Color get textSecondary => isDark ? const Color(0xFFB0B0B0) : const Color(0xFF6A7282);
  Color get textHint      => isDark ? const Color(0xFF808080) : const Color(0xFF9CA3AF);

  // Borders
  Color get borderColor => isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE5E7EB);

  // AppBar
  Color get appBarBg => isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFFFFFF);
}
