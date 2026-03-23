
import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class AppLanguageProvider extends ChangeNotifier{
  Locale _locale = Locale(AppPrefs.getLanguageCode());

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await AppPrefs.setLanguageCode(languageCode);
    notifyListeners();
  }

  Future<void> toggleLocale() async {
    final newCode = isArabic ? 'en' : 'ar';
    await setLocale(newCode);
  }
}