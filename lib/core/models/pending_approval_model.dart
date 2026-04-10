import 'package:uni_ride_application/core/constants/api_keys.dart';

class PendingApprovalModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String appliedAt;
  final String vehicleType;
  final String vehicleModel;
  final String plateNumber;
  final String type;

  PendingApprovalModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.appliedAt,
    required this.vehicleType,
    required this.vehicleModel,
    required this.plateNumber,
    required this.type,
  });

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalModel(
      id: json['id']?.toString() ?? '',
      fullName: json[ApiKeys.driverFullName] ?? json['fullName'] ?? '',
      email: json[ApiKeys.driverEmail] ?? json['email'] ?? '',
      phoneNumber: json[ApiKeys.driverPhoneNumber] ?? json['phoneNumber'] ?? '',
      appliedAt: json['appliedAt'] ?? json['AppliedAt'] ?? '',
      vehicleType: json[ApiKeys.driverVehicleType] ?? json['vehicleType'] ?? '',
      vehicleModel: json[ApiKeys.driverVehicleModel] ?? json['vehicleModel'] ?? '',
      plateNumber: json[ApiKeys.driverPlateNumber] ?? json['plateNumber'] ?? '',
      type: json['type'] ?? json['Type'] ?? 'Driver',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      ApiKeys.driverFullName: fullName,
      ApiKeys.driverEmail: email,
      ApiKeys.driverPhoneNumber: phoneNumber,
      'appliedAt': appliedAt,
      ApiKeys.driverVehicleType: vehicleType,
      ApiKeys.driverVehicleModel: vehicleModel,
      ApiKeys.driverPlateNumber: plateNumber,
      'type': type,
    };
  }
}
