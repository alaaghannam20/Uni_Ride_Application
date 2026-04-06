enum UserType { member, driver, admin, carpool, unknown }

UserType userTypeFromString(String value) {
  final normalized = value.toLowerCase().trim();
  switch (normalized) {
    case 'universitymember':
      return UserType.member;
    case 'driver':
      return UserType.driver;
    case 'admin':
      return UserType.admin;
    case 'carpool':
      return UserType.carpool;
    default:
      return UserType.unknown;
  }
}

class UserModel {
  final String fullName;
  final String email;
  final UserType userType;
  final String token;
  final String status;

  UserModel({
    required this.fullName,
    required this.email,
    required this.userType,
    required this.token,

    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      userType: userTypeFromString(json['userType'] ?? ''),
      token: json['token'] ?? '',

      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'userType': userType.name,
      'token': token,
      'status': status,
    };
  }

  bool get isActive => status.toLowerCase() == 'active';
}
