enum UserType {
  member,
  driver,
  admin,
  carpool,
  unknown,
}

UserType userTypeFromString(String value) {
  return UserType.values.firstWhere(
    (e) => e.name == value.toLowerCase(),
    orElse: () => UserType.unknown,
  );
}

class AuthModel {
  final bool success;
  final String message;
  final String fullName;
  final String email;
  final UserType userType;
  final String token;
  final String status;

  AuthModel({
    required this.fullName,
    required this.email,
    required this.userType,
    required this.token,
    required this.success,
    required this.message,
    required this.status,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      userType: userTypeFromString(json['userType'] ?? ''),
      token: json['token'] ?? '',
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'fullName': fullName,
      'email': email,
      'userType': userType.name,
      'token': token,
      'status': status,
    };
  }

  bool get isActive => status.toLowerCase() == 'active';
}