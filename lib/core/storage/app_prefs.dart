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

  static String? getToken() {
    return _prefs.getString(PrefKeys.token);
  }

  static Future<void> setToken(String token) async {
    await _prefs.setString(PrefKeys.token, token);
  }

  static Future<void> logout() async {
    await _prefs.remove(PrefKeys.token);
    await _prefs.setBool(PrefKeys.isLoggedIn, false);
  }
  static bool getSeenSplash2() {
  return _prefs.getBool(PrefKeys.seenSplash2) ?? false;
}

static Future<void> setSeenSplash2(bool value) async {
  await _prefs.setBool(PrefKeys.seenSplash2, value);
}
}