import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class AppThemeProvider extends ChangeNotifier {
  bool _isLightMode = AppPrefs.getIsLightMode();

  bool get isLightMode => _isLightMode;
  ThemeMode get themeMode => _isLightMode ? ThemeMode.light : ThemeMode.dark;

  Future<void> setLightMode(bool isLight) async {
    _isLightMode = isLight;
    await AppPrefs.setIsLightMode(isLight);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    await setLightMode(!_isLightMode);
  }
}
