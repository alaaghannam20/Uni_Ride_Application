import 'package:uni_ride_application/core/constants/api_keys.dart';

class ApiResponseModel {
  final bool success;
  final String message;

  ApiResponseModel({
    required this.success,
    required this.message,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      success: json[ApiKeys.success] ?? false,
      message: json[ApiKeys.message] ?? 'Something went wrong',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.success: success,
      ApiKeys.message: message,
    };
  }
}
