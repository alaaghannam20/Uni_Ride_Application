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

  static String getLanguageCode() {
    return _prefs.getString(PrefKeys.languageCode) ?? 'en';
  }

  static Future<void> setLanguageCode(String code) async {
    await _prefs.setString(PrefKeys.languageCode, code);
  }

    static String? getToken() {
    return _prefs.getString(PrefKeys.token);
  }

  static Future<void> setToken(String token) async {
    await _prefs.setString(PrefKeys.token, token);
  }

  static Future<void> clearToken() async {
  await _prefs.remove(PrefKeys.token);
}

  static Future<void> logout() async {
    await _prefs.remove(PrefKeys.token);
    await _prefs.remove(PrefKeys.userType);
    await _prefs.remove(PrefKeys.userFullName);
    await _prefs.remove(PrefKeys.userEmail);
    await _prefs.remove(PrefKeys.userProfileImage);
  }

    static Future<void> saveDriverProgress({
    required int currentStep,
    required String fullName,
    required String email,
    required String phone,
    required String carType,
    required String carModel,
    required String carSeats,
    required String license,
    required String plate,
  }) async {
    await _prefs.setInt(PrefKeys.driverCurrentStep, currentStep);
    await _prefs.setString(PrefKeys.driverFullName, fullName);
    await _prefs.setString(PrefKeys.driverEmail, email);
    await _prefs.setString(PrefKeys.driverPhone, phone);
    await _prefs.setString(PrefKeys.driverCarType, carType);
    await _prefs.setString(PrefKeys.driverCarModel, carModel);
    await _prefs.setString(PrefKeys.driverCarSeats, carSeats);
    await _prefs.setString(PrefKeys.driverLicense, license);
    await _prefs.setString(PrefKeys.driverPlate, plate);
  }

  static int getDriverCurrentStep() =>
      _prefs.getInt(PrefKeys.driverCurrentStep) ?? 0;
  static String getDriverFullName() =>
      _prefs.getString(PrefKeys.driverFullName) ?? '';
  static String getDriverEmail() =>
      _prefs.getString(PrefKeys.driverEmail) ?? '';
  static String getDriverPhone() =>
      _prefs.getString(PrefKeys.driverPhone) ?? '';
  static String? getDriverCarType() {
    final val = _prefs.getString(PrefKeys.driverCarType);
    return (val == null || val.isEmpty) ? null : val;
  }
  static String getDriverCarModel() =>
      _prefs.getString(PrefKeys.driverCarModel) ?? '';
  static String getDriverCarSeats() =>
      _prefs.getString(PrefKeys.driverCarSeats) ?? '';
  static String getDriverLicense() =>
      _prefs.getString(PrefKeys.driverLicense) ?? '';
  static String getDriverPlate() =>
      _prefs.getString(PrefKeys.driverPlate) ?? '';

  static Future<void> clearDriverProgress() async {
    await _prefs.remove(PrefKeys.driverCurrentStep);
    await _prefs.remove(PrefKeys.driverFullName);
    await _prefs.remove(PrefKeys.driverEmail);
    await _prefs.remove(PrefKeys.driverPhone);
    await _prefs.remove(PrefKeys.driverCarType);
    await _prefs.remove(PrefKeys.driverCarModel);
    await _prefs.remove(PrefKeys.driverCarSeats);
    await _prefs.remove(PrefKeys.driverLicense);
    await _prefs.remove(PrefKeys.driverPlate);
  }


  static String? getUserType() {
  return _prefs.getString(PrefKeys.userType);
}

static Future<void> setUserType(String userType) async {
  await _prefs.setString(PrefKeys.userType, userType);
}

  static String? getFullName() => _prefs.getString(PrefKeys.userFullName);
  static Future<void> setFullName(String name) async =>
      _prefs.setString(PrefKeys.userFullName, name);

  static String? getEmail() => _prefs.getString(PrefKeys.userEmail);
  static Future<void> setEmail(String email) async =>
      _prefs.setString(PrefKeys.userEmail, email);

  static String? getProfileImage() => _prefs.getString(PrefKeys.userProfileImage);
  static Future<void> setProfileImage(String? path) async {
    if (path != null) {
      await _prefs.setString(PrefKeys.userProfileImage, path);
    } else {
      await _prefs.remove(PrefKeys.userProfileImage);
    }
  }

  static Future<void> clearUserType() async {
    await _prefs.remove(PrefKeys.userType);
  }

  static bool getIsLightMode() => _prefs.getBool(PrefKeys.themeMode) ?? true;
  static Future<void> setIsLightMode(bool isLight) async =>
      _prefs.setBool(PrefKeys.themeMode, isLight);

}
