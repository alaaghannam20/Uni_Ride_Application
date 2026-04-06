class ApiResponseModel {
  final bool success;
  final String message;

  ApiResponseModel({
    required this.success,
    required this.message,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Something went wrong',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
