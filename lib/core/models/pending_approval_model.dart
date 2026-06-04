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
  final String? licenseNumber;
  final int?    seatCapacity;
  final String? driverLicenseImage;
  final String? vehicleLicenseImage;

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
    this.licenseNumber,
    this.seatCapacity,
    this.driverLicenseImage,
    this.vehicleLicenseImage,
  });

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalModel(
      id:           json[ApiKeys.id]?.toString()                                          ?? '',
      fullName:     json[ApiKeys.driverFullName]    ?? json[ApiKeys.fullName]              ?? '',
      email:        json[ApiKeys.driverEmail]        ?? json[ApiKeys.email]                ?? '',
      phoneNumber:  json[ApiKeys.driverPhoneNumber]  ?? json[ApiKeys.phoneNumber]          ?? '',
      appliedAt:    json['createdAt']  ?? json[ApiKeys.appliedAt] ?? json[ApiKeys.appliedAtAlt] ?? '',
      vehicleType:  json[ApiKeys.driverVehicleType]  ?? json[ApiKeys.vehicleType]          ?? '',
      vehicleModel: json[ApiKeys.driverVehicleModel] ?? json[ApiKeys.vehicleModel]         ?? '',
      plateNumber:  json[ApiKeys.driverPlateNumber]  ?? json[ApiKeys.plateNumber]          ?? '',
      type:               json[ApiKeys.type]                ?? json['Type']              ?? 'Driver',
      profileImage:       (json[ApiKeys.profilePicturePath] ?? json[ApiKeys.profileImage] ?? json[ApiKeys.driverProfileImage])?.replaceAll('\\', '/'),
      licenseNumber:      json[ApiKeys.licenseNumber]      ?? json['LicenseNumber'],
      seatCapacity:       json[ApiKeys.seatCapacity] != null ? (json[ApiKeys.seatCapacity]).toInt() : null,
      driverLicenseImage:  (json['licenseImagePath']        ?? json[ApiKeys.driverLicenseImageUrl]  ?? json['DriverLicenseImage'])?.replaceAll('\\', '/'),
      vehicleLicenseImage: (json['vehicleLicenseImagePath'] ?? json[ApiKeys.vehicleLicenseImageUrl] ?? json['VehicleLicenseImage'])?.replaceAll('\\', '/'),
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
