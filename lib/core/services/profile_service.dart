import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_ride_application/core/models/api_response_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/driver_profile_model.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/member_profile_model.dart';

class ProfileService {
  String _cleanError(dynamic e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  // GET /user/member-profile
  Future<MemberProfileModel> getMemberProfile() async {
    try {
      final response = await DioFactory.get(AppEndpoints.memberProfile);
      final json = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      debugPrint('=== MEMBER PROFILE JSON: $json');
      return MemberProfileModel.fromJson(json);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  // PUT /user/update-profile-image
  Future<ApiResponseModel> updateProfileImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'profileImage': await MultipartFile.fromFile(imageFile.path),
      });
      final response = await DioFactory.put(
        AppEndpoints.updateProfileImage,
        data: formData,
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // PUT /user/update-profile
  Future<ApiResponseModel> updateProfile({required String phoneNumber}) async {
    try {
      final response = await DioFactory.put(
        AppEndpoints.updateProfile,
        data: {'phoneNumber': phoneNumber},
      );
      debugPrint('=== UPDATE PROFILE response: ${response.data}');
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      debugPrint('=== UPDATE PROFILE error: $e');
      return ApiResponseModel(success: false, message: _cleanError(e));
    }
  }

  // GET /User/carpool-profile
  Future<DriverProfileModel> getCarpoolProfile() async {
    try {
      final response = await DioFactory.get(AppEndpoints.carpoolProfile);
      final json = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return DriverProfileModel.fromJson(json);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  // GET /User/driver-profile
  Future<DriverProfileModel> getDriverProfile() async {
    try {
      final response = await DioFactory.get(AppEndpoints.driverProfile);
      final json = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return DriverProfileModel.fromJson(json);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
