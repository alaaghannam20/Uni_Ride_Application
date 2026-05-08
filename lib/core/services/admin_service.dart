import 'package:flutter/foundation.dart';
import 'package:uni_ride_application/core/models/admin_dashboard_stats_model.dart';
import 'package:uni_ride_application/core/models/admin_driver_model.dart';
import 'package:uni_ride_application/core/models/admin_student_model.dart';
import 'package:uni_ride_application/core/models/admin_trip_model.dart';
import 'package:uni_ride_application/core/models/pending_approval_model.dart';
import 'package:uni_ride_application/core/models/api_response_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class AdminService {
  Future<List<PendingApprovalModel>> getPendingApprovals() async {
    try {
      final response = await DioFactory.get(AppEndpoints.pendingApprovals);
      if (response.data is List) {
        return (response.data as List)
            .map((item) => PendingApprovalModel.fromJson(item))
            .toList();
      } else if (response.data is Map && response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((item) => PendingApprovalModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PendingApprovalModel> getPendingApprovalDetails(String id, String type) async {
    try {
      final response = await DioFactory.get(
        AppEndpoints.pendingApprovalDetails(id),
        queryParameters: {'type': type},
      );
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data'] as Map<String, dynamic>
          : response.data as Map<String, dynamic>;
      // DEBUG — remove after diagnosis
      debugPrint('=== RAW DETAILS RESPONSE: ${response.data}');
      debugPrint('=== PARSED DATA MAP: $data');
      debugPrint('=== driverLicenseImage key check: licenseImagePath=${data['licenseImagePath']}, driverLicenseImage=${data['driverLicenseImage']}, DriverLicenseImage=${data['DriverLicenseImage']}');
      debugPrint('=== vehicleLicenseImage key check: vehicleLicenseImagePath=${data['vehicleLicenseImagePath']}, vehicleLicenseImage=${data['vehicleLicenseImage']}, VehicleLicenseImage=${data['VehicleLicenseImage']}');
      return PendingApprovalModel.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseModel> approveApplication(String id, String type) async {
    try {
      final response = await DioFactory.put(
        '${AppEndpoints.approve}/$id',
        queryParameters: {'type': type},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: e.toString());
    }
  }

  Future<ApiResponseModel> rejectApplication(String id, String type) async {
    try {
      final response = await DioFactory.put(
        '${AppEndpoints.reject}/$id',
        queryParameters: {'type': type},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: e.toString());
    }
  }

  Future<AdminDashboardStatsModel> getDashboardStats() async {
    final response = await DioFactory.get(AppEndpoints.dashboardStats);
    return AdminDashboardStatsModel.fromJson(response.data);
  }

  Future<List<AdminStudentModel>> getStudents() async {
    final response = await DioFactory.get(AppEndpoints.adminStudents);
    final list = response.data as List? ?? [];
    return list.map((e) => AdminStudentModel.fromJson(e)).toList();
  }

  Future<ApiResponseModel> toggleDriverStatus(String id) async {
    try {
      final response = await DioFactory.put(AppEndpoints.toggleDriverStatus(id));
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: e.toString());
    }
  }

  Future<List<AdminDriverModel>> getDriversList() async {
    try {
      final response = await DioFactory.get(AppEndpoints.adminDrivers);
      final list = response.data as List? ?? [];
      return list.map((e) => AdminDriverModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<AdminTripModel>> getAdminTrips() async {
    final response = await DioFactory.get(AppEndpoints.adminTrips);
    final list = response.data as List? ?? [];
    return list.map((e) => AdminTripModel.fromJson(e)).toList();
  }
}
