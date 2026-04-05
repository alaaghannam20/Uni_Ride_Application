import 'package:dio/dio.dart';
import 'package:uni_ride_application/core/models/auth_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  // Error Handler 

  AuthModel _handleError(dynamic e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return AuthModel(
          success: false,
          message: 'Connection timeout, try again',
          fullName: '', email: '', token: '',
          userType: UserType.unknown, status: '',
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        return AuthModel(
          success: false,
          message: 'No internet connection',
          fullName: '', email: '', token: '',
          userType: UserType.unknown, status: '',
        );
      }
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data;
        String message = 'Server error';
        if (data is Map && data['message'] != null) message = data['message'];
        return AuthModel(
          success: false, message: message,
          fullName: '', email: '', token: '',
          userType: UserType.unknown, status: '',
        );
      }
      if (e.type == DioExceptionType.cancel) {
        return AuthModel(
          success: false, message: 'Request cancelled',
          fullName: '', email: '', token: '',
          userType: UserType.unknown, status: '',
        );
      }
    }
    return AuthModel(
      success: false, message: 'Unexpected error occurred',
      fullName: '', email: '', token: '',
      userType: UserType.unknown, status: '',
    );
  }

  //  Register Member

  Future<AuthModel> registerMember(String email, String password) async {
    try {
      final response = await _dio.post(
        AppEndpoints.registerMember,
        data: {'email': email, 'password': password},
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Register Driver 

  Future<AuthModel> registerDriver({
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
    try {
      final formData = FormData.fromMap({
        'FullName': fullName,
        'Email': email,
        'PhoneNumber': phoneNumber,
        'Password': password,
        'LicenseNumber': licenseNumber,
        'VehicleType': vehicleType,
        'VehicleModel': vehicleModel,
        'PlateNumber': plateNumber,
        'SeatCapacity': seatCapacity,
        'DriverLicenseImage': await MultipartFile.fromFile(driverLicensePath),
        'VehicleLicenseImage': await MultipartFile.fromFile(vehicleLicensePath),
      });
      final response = await _dio.post(
        AppEndpoints.registerDriver,
        data: formData,
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }


  // Login 

  Future<AuthModel> login(String emailOrPhone, String password) async {
    try {
      final response = await _dio.post(
        AppEndpoints.login,
        data: {'emailOrPhone': emailOrPhone, 'password': password},
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  //  Verify OTP

  Future<AuthModel> verifyOtp(String email, String otpCode) async {
    try {
      final response = await _dio.post(
        AppEndpoints.verifyOtp,
        data: {'email': email, 'otpCode': otpCode},
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  //  Forget Password

  Future<AuthModel> forgetPassword(String email) async {
    try {
      final response = await _dio.post(
        AppEndpoints.forgetPassword,
        data: {'email': email},
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Reset Password 

  Future<AuthModel> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppEndpoints.resetPassword,
        data: {
          'email': email,
          'otpCode': otpCode,
          'newPassword': newPassword,
        },
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }

  //  Change Password 

  Future<AuthModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppEndpoints.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
      return AuthModel.fromJson(response.data);
    } catch (e) {
      return _handleError(e);
    }
  }
  // send otp

Future<AuthModel> sendOtp(String email) async {
  try {
    final response = await _dio.post(
      AppEndpoints.sendOtp,
      data: {'email': email},
    );
    return AuthModel.fromJson(response.data);
  } catch (e) {
    return _handleError(e);
  }
}
}



