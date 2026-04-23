import 'package:dio/dio.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
import 'package:uni_ride_application/core/models/api_response_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/core/constants/api_keys.dart';

class AuthService {
  
  // Helper to extract clean error message
  String _cleanError(dynamic e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  //  Register Member
  Future<ApiResponseModel> registerMember(String email, String password) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.registerMember,
        data: {ApiKeys.email: email, ApiKeys.password: password},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
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
        ApiKeys.driverFullName: fullName,
        ApiKeys.driverEmail: email,
        ApiKeys.driverPhoneNumber: phoneNumber,
        ApiKeys.driverPassword: password,
        ApiKeys.driverLicenseNumber: licenseNumber,
        ApiKeys.driverVehicleType: vehicleType,
        ApiKeys.driverVehicleModel: vehicleModel,
        ApiKeys.driverPlateNumber: plateNumber,
        ApiKeys.driverSeatCapacity: seatCapacity,
        ApiKeys.driverLicenseImage: await MultipartFile.fromFile(driverLicensePath),
        ApiKeys.driverVehicleLicenseImage: await MultipartFile.fromFile(vehicleLicensePath),
      });
      final response = await DioFactory.post(
        AppEndpoints.registerDriver,
        data: formData,
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // Register Carpool 
  Future<ApiResponseModel> registerCarpool({
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
  }) async {
    try {
      final formData = FormData.fromMap({
        ApiKeys.driverEmail: email,
        ApiKeys.driverPassword: password,
        ApiKeys.driverPhoneNumber: phoneNumber,
        ApiKeys.driverVehicleType: vehicleType,
        ApiKeys.driverVehicleModel: vehicleModel,
        ApiKeys.driverPlateNumber: plateNumber,
        ApiKeys.driverSeatCapacity: seatCapacity,
        ApiKeys.driverLicenseNumber: licenseNumber,
        ApiKeys.driverLicenseImage: await MultipartFile.fromFile(driverLicensePath),
        ApiKeys.driverVehicleLicenseImage: await MultipartFile.fromFile(vehicleLicensePath),
      });
      final response = await DioFactory.post(
        AppEndpoints.registerCarpool,
        data: formData,
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // Login 
  Future<UserModel> login(String emailOrPhone, String password) async {
    try {
      print("start api call");
      final response = await DioFactory.post(
        AppEndpoints.login,
        data: {ApiKeys.emailOrPhone: emailOrPhone, ApiKeys.password: password},
      );
              print("api call completed");

      if (response.data != null && response.data[ApiKeys.success] == true) {
         return UserModel.fromJson(response.data);
      } else {
         throw Exception(response.data[ApiKeys.message] ?? 'Login failed');
      }
    } catch (e) {
      print(e);
      throw Exception(_cleanError(e));
    }
  }

  //  Verify OTP
  Future<ApiResponseModel> verifyOtp(String email, String otpCode) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.verifyOtp,
        data: {ApiKeys.email: email, ApiKeys.otpCode: otpCode},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  //  Forget Password
  Future<ApiResponseModel> forgetPassword(String email) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.forgetPassword,
        data: {ApiKeys.email: email},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // Reset Password 
  Future<ApiResponseModel> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.resetPassword,
        data: {
          ApiKeys.email: email,
          ApiKeys.otpCode: otpCode,
          ApiKeys.newPassword: newPassword,
        },
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  //  Change Password 
  Future<ApiResponseModel> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.changePassword,
        data: {
          ApiKeys.oldPassword: oldPassword,
          ApiKeys.newPassword: newPassword,
        },
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // send otp
  Future<ApiResponseModel> sendOtp(String email) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.sendOtp,
        data: {ApiKeys.email: email},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }
}
