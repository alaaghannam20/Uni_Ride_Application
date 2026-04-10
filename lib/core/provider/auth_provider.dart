import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
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

      _user = userResult;
      await AppPrefs.setToken(userResult.token);
      await AppPrefs.setUserType(userResult.userType.name);
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
    final result = await _authService.verifyOtp(email, otpCode);
    if (result.success) {
      _setState(AuthState.success);
      return true;
    } else {
      _errorMessage = result.message;
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
    await AppPrefs.logout();
    _user = null;
    _userType = UserType.unauthorized;
    _setState(AuthState.idle);
  }
}
