import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
import 'package:uni_ride_application/core/provider/one_signal_service.dart';
import 'package:uni_ride_application/core/services/auth_service.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

enum AuthState { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthState _state = AuthState.idle;
  AuthState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  UserType _userType = UserType.unauthorized;
  UserType get userType => _userType;

  AuthProvider() {
    _loadSavedUser();
  }

  void _loadSavedUser() {
    final token      = AppPrefs.getToken();
    final fullName   = AppPrefs.getFullName();
    final email      = AppPrefs.getEmail();
    final userType   = AppPrefs.getUserType();
    final profileImage = AppPrefs.getProfileImage();
    final userId     = AppPrefs.getUserId();

    if (token != null && fullName != null) {
      _user = UserModel(
        userId: userId,
        fullName: fullName,
        email: email ?? '',
        userType: userTypeFromString(userType ?? ''),
        token: token,
        status: 'Active',
        profileImage: profileImage,
      );
      _userType = _user!.userType;

      if (userId != null) {
        OneSignalService().initialize(
          languageCode: AppPrefs.getLanguageCode(),
          externalUserId: userId.toString(),
        );
      }

      notifyListeners();
    }
  }

  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  //  Register Member
  Future<bool> registerMember(String email, String password) async {
    _setState(AuthState.loading);
    final result = await _authService.registerMember(email, password);
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  // Register Driver
  Future<bool> registerDriver({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String licenseNumber,
    required String vehicleType,
    required String vehicleModel,
    required String plateNumber,
    required int seatCapacity,
    required String driverLicensePath,
    required String vehicleLicensePath,
    required String profileImagePath,
  }) async {
    _setState(AuthState.loading);
    final result = await _authService.registerDriver(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      licenseNumber: licenseNumber,
      vehicleType: vehicleType,
      vehicleModel: vehicleModel,
      plateNumber: plateNumber,
      seatCapacity: seatCapacity,
      driverLicensePath: driverLicensePath,
      vehicleLicensePath: vehicleLicensePath,
      profileImagePath: profileImagePath,
    );
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  // Register Carpool
  Future<bool> registerCarpool({
    required String email,
    required String password,
    required String phoneNumber,
    required String vehicleType,
    required String vehicleModel,
    required String plateNumber,
    required int seatCapacity,
    required String licenseNumber,
    required String driverLicensePath,
    required String vehicleLicensePath,
    required String profileImagePath,
  }) async {
    _setState(AuthState.loading);
    final result = await _authService.registerCarpool(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      vehicleType: vehicleType,
      vehicleModel: vehicleModel,
      plateNumber: plateNumber,
      seatCapacity: seatCapacity,
      licenseNumber: licenseNumber,
      driverLicensePath: driverLicensePath,
      vehicleLicensePath: vehicleLicensePath,
      profileImagePath: profileImagePath,
    );
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  //  Login
  Future<bool> login(String emailOrPhone, String password) async {
    _setState(AuthState.loading);
    try {
      final userResult = await _authService.login(emailOrPhone, password);
      
      // Check if the account is pending approval
      if (userResult.status.toLowerCase() == 'pending') {
        _errorMessage = 'ACCOUNT_PENDING';
        _setState(AuthState.error);
        return false;
      }
        //TODO:Check authstate error for pending approval and show appropriate message in UI
        //TODO: Implement the navigation by user type in the login function of the auth provider and remove the navigation logic from the login page
        //if (userResult.userType == UserType.driver) {
        //  // Navigate to driver dashboard
        //} else if (userResult.userType == UserType.member) {
        //  // Navigate to member dashboard
        //} else if (userResult.userType == UserType.admin) {
        //  // Navigate to admin dashboard
        //} else {
        //  // Handle unauthorized user type
      _user = userResult;
      await AppPrefs.setToken(userResult.token);
      await AppPrefs.setUserType(userResult.userType.name);
      await AppPrefs.setFullName(userResult.fullName);
      await AppPrefs.setEmail(userResult.email);
      await AppPrefs.setProfileImage(userResult.profileImage);
      if (userResult.userId != null) {
        await AppPrefs.setUserId(userResult.userId!);
        await OneSignalService().initialize(
          languageCode: AppPrefs.getLanguageCode(),
          externalUserId: userResult.userId.toString(),
        );
      }
      _userType = userResult.userType;
      _setState(AuthState.success);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setState(AuthState.error);
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String email, String otpCode) async {
    _setState(AuthState.loading);
    try {
      final userResult = await _authService.verifyOtp(email, otpCode);
      _user = userResult;
      await AppPrefs.setToken(userResult.token);
      await AppPrefs.setUserType(userResult.userType.name);
      await AppPrefs.setFullName(userResult.fullName);
      await AppPrefs.setEmail(userResult.email);
      await AppPrefs.setProfileImage(userResult.profileImage);
      if (userResult.userId != null) {
        await AppPrefs.setUserId(userResult.userId!);
        await OneSignalService().initialize(
          languageCode: AppPrefs.getLanguageCode(),
          externalUserId: userResult.userId.toString(),
        );
      }
      _userType = userResult.userType;
      _setState(AuthState.success);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setState(AuthState.error);
      return false;
    }
  }

  //  Forget Password
  Future<bool> forgetPassword(String email) async {
    _setState(AuthState.loading);
    final result = await _authService.forgetPassword(email);
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
  }) async {
    _setState(AuthState.loading);
    final result = await _authService.resetPassword(
      email: email,
      otpCode: otpCode,
      newPassword: newPassword,
    );
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  //  Change Password
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    _setState(AuthState.loading);
    final result = await _authService.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  //  Send OTP
  Future<bool> sendOtp(String email) async {
    _setState(AuthState.loading);
    final result = await _authService.sendOtp(email);
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AuthState.error);
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await OneSignalService().logout();
    await AppPrefs.logout();
    _user = null;
    _userType = UserType.unauthorized;
    _setState(AuthState.idle);
  }
}
