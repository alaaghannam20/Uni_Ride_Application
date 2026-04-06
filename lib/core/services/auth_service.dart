import 'package:dio/dio.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
import 'package:uni_ride_application/core/models/api_response_model.dart';
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
  String _handleError(dynamic e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return 'Connection timeout, try again';
      }
      if (e.type == DioExceptionType.connectionError) {
        return 'No internet connection';
      }
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data;
        if (data is Map && data['message'] != null) return data['message'];
        return 'Server error';
      }
      if (e.type == DioExceptionType.cancel) {
        return 'Request cancelled';
      }
    }
    return 'Unexpected error occurred';
  }

  //  Register Member
  Future<ApiResponseModel> registerMember(String email, String password) async {
    try {
      final response = await _dio.post(
        AppEndpoints.registerMember,
        data: {'email': email, 'password': password},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  // Register Driver
  Future<ApiResponseModel> registerDriver({
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
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  // Login
  Future<UserModel> login(String emailOrPhone, String password) async {
    try {
      final response = await _dio.post(
        AppEndpoints.login,
        data: {'emailOrPhone': emailOrPhone, 'password': password},
      );

      if (response.data != null && response.data['success'] == true) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  //  Verify OTP
  Future<ApiResponseModel> verifyOtp(String email, String otpCode) async {
    try {
      final response = await _dio.post(
        AppEndpoints.verifyOtp,
        data: {'email': email, 'otpCode': otpCode},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  //  Forget Password
  Future<ApiResponseModel> forgetPassword(String email) async {
    try {
      final response = await _dio.post(
        AppEndpoints.forgetPassword,
        data: {'email': email},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  // Reset Password
  Future<ApiResponseModel> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppEndpoints.resetPassword,
        data: {'email': email, 'otpCode': otpCode, 'newPassword': newPassword},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  //  Change Password
  Future<ApiResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        AppEndpoints.changePassword,
        data: {'oldPassword': oldPassword, 'newPassword': newPassword},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }

  // send otp
  Future<ApiResponseModel> sendOtp(String email) async {
    try {
      final response = await _dio.post(
        AppEndpoints.sendOtp,
        data: {'email': email},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _handleError(e));
    }
  }
}
