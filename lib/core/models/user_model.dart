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
  final int? userId;
  final String fullName;
  final String email;
  final UserType userType;
  final String token;
  final String status;
  final String? profileImage;

  const UserModel({
    this.userId,
    required this.fullName,
    required this.email,
    required this.userType,
    required this.token,
    required this.status,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawId = json[ApiKeys.userId] ?? json['id'] ?? json['Id'] ?? json['UserId'];
    return UserModel(
      userId: rawId is int ? rawId : int.tryParse(rawId?.toString() ?? ''),
      fullName: json[ApiKeys.fullName] ?? '',
      email: json[ApiKeys.email] ?? '',
      userType: userTypeFromString(json[ApiKeys.userType] ?? ''),
      token: json[ApiKeys.token] ?? '',
      status: json[ApiKeys.status] ?? '',
      profileImage: json[ApiKeys.profileImage] ?? json[ApiKeys.profilePicturePath] ?? json['ProfileImage'],
    );
  }

  bool get isActive => status.toLowerCase() == 'active';
}
