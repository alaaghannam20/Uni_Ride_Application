import 'package:shared_preferences/shared_preferences.dart';
import 'prefs_keys.dart';

class AppPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getSeenOnboarding() {
    return _prefs.getBool(PrefKeys.seenOnboarding) ?? false;
  }

  static Future<void> setSeenOnboarding(bool value) async {
    await _prefs.setBool(PrefKeys.seenOnboarding, value);
  }

  static bool getIsLoggedIn() {
    return _prefs.getBool(PrefKeys.isLoggedIn) ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    await _prefs.setBool(PrefKeys.isLoggedIn, value);
  }


  static String getLanguageCode() {
    return _prefs.getString(PrefKeys.languageCode) ?? 'en';
  }

  static Future<void> setLanguageCode(String code) async {
    await _prefs.setString(PrefKeys.languageCode, code);
  }

}
