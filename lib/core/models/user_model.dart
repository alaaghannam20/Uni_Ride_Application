import 'package:uni_ride_application/core/constants/api_keys.dart';

enum UserType { member, driver, admin, carpool, unauthorized }

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
      return UserType.unauthorized;
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
      fullName: json[ApiKeys.fullName] ?? '',
      email: json[ApiKeys.email] ?? '',
      userType: userTypeFromString(json[ApiKeys.userType] ?? ''),
      token: json[ApiKeys.token] ?? '',
      status: json[ApiKeys.status] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.fullName: fullName,
      ApiKeys.email: email,
      ApiKeys.userType: userType.name,
      ApiKeys.token: token,
      ApiKeys.status: status,
    };
  }

  bool get isActive => status.toLowerCase() == 'active';
}
