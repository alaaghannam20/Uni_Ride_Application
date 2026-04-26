import 'package:uni_ride_application/core/constants/api_keys.dart';

class PendingApprovalModel {
  final String  id;
  final String  fullName;
  final String  email;
  final String  phoneNumber;
  final String  appliedAt;
  final String  vehicleType;
  final String  vehicleModel;
  final String  plateNumber;
  final String  type;
  final String? profileImage;

  const PendingApprovalModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.appliedAt,
    required this.vehicleType,
    required this.vehicleModel,
    required this.plateNumber,
    required this.type,
    this.profileImage,
  });

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalModel(
      id:           json[ApiKeys.id]?.toString()                                          ?? '',
      fullName:     json[ApiKeys.driverFullName]    ?? json[ApiKeys.fullName]              ?? '',
      email:        json[ApiKeys.driverEmail]        ?? json[ApiKeys.email]                ?? '',
      phoneNumber:  json[ApiKeys.driverPhoneNumber]  ?? json[ApiKeys.phoneNumber]          ?? '',
      appliedAt:    json[ApiKeys.appliedAt]           ?? json[ApiKeys.appliedAtAlt]        ?? '',
      vehicleType:  json[ApiKeys.driverVehicleType]  ?? json[ApiKeys.vehicleType]          ?? '',
      vehicleModel: json[ApiKeys.driverVehicleModel] ?? json[ApiKeys.vehicleModel]         ?? '',
      plateNumber:  json[ApiKeys.driverPlateNumber]  ?? json[ApiKeys.plateNumber]          ?? '',
      type:         json[ApiKeys.type]               ?? json['Type']                       ?? 'Driver',
      profileImage: json[ApiKeys.profileImage]       ?? json[ApiKeys.driverProfileImage],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id:                 id,
      ApiKeys.driverFullName:     fullName,
      ApiKeys.driverEmail:        email,
      ApiKeys.driverPhoneNumber:  phoneNumber,
      ApiKeys.appliedAt:          appliedAt,
      ApiKeys.driverVehicleType:  vehicleType,
      ApiKeys.driverVehicleModel: vehicleModel,
      ApiKeys.driverPlateNumber:  plateNumber,
      ApiKeys.type:               type,
    };
  }
}
