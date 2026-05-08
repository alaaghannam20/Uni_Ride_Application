import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class AppThemeProvider extends ChangeNotifier {
  // null = follow system, true = light, false = dark
  bool? _preference = AppPrefs.getSavedTheme();

  bool? get preference => _preference;

  ThemeMode get themeMode {
    if (_preference == null) return ThemeMode.system;
    return _preference! ? ThemeMode.light : ThemeMode.dark;
  }

  // Used by the Switch widget in settings — reflects actual current state
  bool get isLightMode => _preference ?? true;

  Future<void> setLightMode(bool isLight) async {
    _preference = isLight;
    notifyListeners(); // immediate UI update
    await AppPrefs.setIsLightMode(isLight); // then persist
  }

  Future<void> toggleTheme() async {
    await setLightMode(!isLightMode);
  }

  // Reset to system default
  Future<void> useSystemTheme() async {
    _preference = null;
    await AppPrefs.clearTheme();
    notifyListeners();
  }
}
