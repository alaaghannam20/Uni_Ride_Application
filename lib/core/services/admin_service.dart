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
         // Handle case where data is wrapped in a 'data' field
         return (response.data['data'] as List)
            .map((item) => PendingApprovalModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ApiResponseModel> approveApplication(String id, String type) async {
    try {
      final response = await DioFactory.post(
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
      final response = await DioFactory.post(
        '${AppEndpoints.reject}/$id',
        queryParameters: {'type': type},
      );
      return ApiResponseModel.fromJson(response.data);
    } catch (e) {
      return ApiResponseModel(success: false, message: e.toString());
    }
  }
}
