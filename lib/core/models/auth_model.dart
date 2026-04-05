enum UserType { member, driver, admin, unknown }

extension UserTypeExtension on UserType {
  static UserType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'carpool':
        return UserType.member;
      case 'member':
        return UserType.member;
      case 'driver':
        return UserType.driver;
      case 'admin':
        return UserType.admin;
      default:
        return UserType.unknown;
    }
  }
}

class RegisterMemberModel {
  final String email;
  final String password;

  RegisterMemberModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class RegisterDriverModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String licenseNumber;
  final String vehicleType;
  final String vehicleModel;
  final String plateNumber;
  final int seatCapacity;

  RegisterDriverModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.licenseNumber,
    required this.vehicleType,
    required this.vehicleModel,
    required this.plateNumber,
    required this.seatCapacity,
  });

  Map<String, dynamic> toJson() => {
    'FullName': fullName,
    'Email': email,
    'PhoneNumber': phoneNumber,
    'Password': password,
    'LicenseNumber': licenseNumber,
    'VehicleType': vehicleType,
    'VehicleModel': vehicleModel,
    'PlateNumber': plateNumber,
    'SeatCapacity': seatCapacity,
  };
}

class LoginModel {
  final String emailOrPhone;
  final String password;

  LoginModel({required this.emailOrPhone, required this.password});

  Map<String, dynamic> toJson() => {
    'emailOrPhone': emailOrPhone,
    'password': password,
  };
}

class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final String fullName;
  final String email;
  final String userType;
  final String status;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.fullName,
    required this.email,
    required this.userType,
    required this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      fullName: json['fullName'],
      email: json['email'],
      userType: json['userType'],
      status: json['status'],
    );
  }
}

class OtpModel {
  final String email;
  final String? otpCode;

  OtpModel({required this.email, this.otpCode});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'email': email};
    if (otpCode != null) map['otpCode'] = otpCode;
    return map;
  }
}

class ResetPasswordModel {
  final String email;
  final String otpCode;
  final String newPassword;

  ResetPasswordModel({
    required this.email,
    required this.otpCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'otpCode': otpCode,
    'newPassword': newPassword,
  };
}

class ForgetPasswordModel {
  final String email;

  ForgetPasswordModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ApiResponseModel {
  final bool success;
  final String message;

  ApiResponseModel({required this.success, required this.message});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(success: json['success'], message: json['message']);
  }
}
