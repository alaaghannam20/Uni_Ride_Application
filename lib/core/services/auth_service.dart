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

  ApiResponseModel handleDioError(dynamic e) {
    if (e is DioException) {
      // ⏱️ Timeout
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return ApiResponseModel(
          success: false,
          message: 'Connection timeout, try again',
        );
      }

      // 🌐 No Internet
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponseModel(
          success: false,
          message: 'No internet connection',
        );
      }

      // 📩 Server Error (400, 401, 500...)
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data;

        String message = 'Server error';

        if (data is Map && data['message'] != null) {
          message = data['message'];
        }

        return ApiResponseModel(
          success: false,
          message: message,
        );
      }

      // ❌ Cancel
      if (e.type == DioExceptionType.cancel) {
        return ApiResponseModel(
          success: false,
          message: 'Request cancelled',
        );
      }

      // ❓ Unknown Dio error
      return ApiResponseModel(
        success: false,
        message: 'Unexpected network error',
      );
    }

    // ❗ Non-Dio error
    return ApiResponseModel(
      success: false,
      message: 'Unexpected error occurred',
    );
  }

  // Register Member
  Future<ApiResponseModel> registerMember(RegisterMemberModel model) async {
    try {
      final response = await _dio.post(
        AppEndpoints.registerMember,
        data: model.toJson(),
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }

  // Register Driver
  Future<ApiResponseModel> registerDriver(
    RegisterDriverModel model, {
    required String driverLicensePath,
    required String vehicleLicensePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...model.toJson(),
        'DriverLicenseImage': await MultipartFile.fromFile(driverLicensePath),
        'VehicleLicenseImage': await MultipartFile.fromFile(vehicleLicensePath),
      });

      final response = await _dio.post(
        AppEndpoints.registerDriver,
        data: formData,
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }

  // Login
  Future<LoginResponseModel> login(LoginModel model) async {
    try {
      final response = await _dio.post(
        AppEndpoints.login,
        data: model.toJson(),
      );

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      final error = handleDioError(e);

      return LoginResponseModel(
        success: false,
        message: error.message,
        token: '',
        fullName: '',
        email: '',
        userType: '',
        status: '',
      );
    }
  }

  // Send OTP
  Future<ApiResponseModel> sendOtp(String email) async {
    try {
      final response = await _dio.post(
        AppEndpoints.sendOtp,
        data: OtpModel(email: email).toJson(),
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }

  // Verify OTP
  Future<ApiResponseModel> verifyOtp(String email, String otpCode) async {
    try {
      final response = await _dio.post(
        AppEndpoints.verifyOtp,
        data: OtpModel(email: email, otpCode: otpCode).toJson(),
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }

  // Forget Password
  Future<ApiResponseModel> forgetPassword(String email) async {
    try {
      final response = await _dio.post(
        AppEndpoints.forgetPassword,
        data: ForgetPasswordModel(email: email).toJson(),
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }

  // Reset Password
  Future<ApiResponseModel> resetPassword(ResetPasswordModel model) async {
    try {
      final response = await _dio.post(
        AppEndpoints.resetPassword,
        data: model.toJson(),
      );

      return response.data != null
          ? ApiResponseModel.fromJson(response.data)
          : ApiResponseModel(success: true, message: 'Success');
    } catch (e) {
      return handleDioError(e);
    }
  }
}